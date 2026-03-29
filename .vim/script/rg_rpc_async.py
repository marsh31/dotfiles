#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import json
import os
import subprocess
import threading
import queue
import time
from datetime import datetime, timedelta, timezone
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional

JSONRPC_VERSION = "2.0"
EXPIRATION_SECONDS = 3600
CLEANUP_INTERVAL_SECONDS = 30


def utc_now() -> datetime:
    return datetime.now(timezone.utc)


def isoformat_z(dt: datetime) -> str:
    return dt.astimezone(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


class JsonRpcError(Exception):
    def __init__(self, code: int, message: str, data: Optional[Any] = None):
        super().__init__(message)
        self.code = code
        self.message = message
        self.data = data


def make_error_response(req_id: Any, code: int, message: str, data: Optional[Any] = None) -> Dict[str, Any]:
    err = {
        "code": code,
        "message": message,
    }
    if data is not None:
        err["data"] = data
    return {
        "jsonrpc": JSONRPC_VERSION,
        "id": req_id,
        "error": err,
    }


def make_result_response(req_id: Any, result: Dict[str, Any]) -> Dict[str, Any]:
    return {
        "jsonrpc": JSONRPC_VERSION,
        "id": req_id,
        "result": result,
    }


@dataclass
class SearchJob:
    search_id: str
    query: str
    root: str
    file: str
    options: Dict[str, Any]
    state: str = "queued"
    created_at: datetime = field(default_factory=utc_now)
    updated_at: datetime = field(default_factory=utc_now)
    last_access_at: datetime = field(default_factory=utc_now)
    started_at: Optional[datetime] = None
    generated_at: Optional[datetime] = None
    cancelled_at: Optional[datetime] = None
    failed_at: Optional[datetime] = None
    failure_message: Optional[str] = None
    total_count: int = 0
    items: List[Dict[str, Any]] = field(default_factory=list)
    cancel_requested: bool = False

    def expires_at(self) -> datetime:
        return self.last_access_at + timedelta(seconds=EXPIRATION_SECONDS)


class SearchServer:
    def __init__(self) -> None:
        self._lock = threading.RLock()
        self._jobs: Dict[str, SearchJob] = {}
        self._job_queue: "queue.Queue[str]" = queue.Queue()
        self._shutdown = threading.Event()
        self._seq = 0
        self._seq_date = utc_now().strftime("%Y%m%d")

        self._worker = threading.Thread(target=self._worker_loop, name="search-worker", daemon=True)
        self._cleaner = threading.Thread(target=self._cleanup_loop, name="search-cleaner", daemon=True)
        self._worker.start()
        self._cleaner.start()

    def stop(self) -> None:
        self._shutdown.set()
        self._job_queue.put("__shutdown__")
        self._worker.join(timeout=1.0)
        self._cleaner.join(timeout=1.0)

    def _next_search_id(self) -> str:
        with self._lock:
            today = utc_now().strftime("%Y%m%d")
            if today != self._seq_date:
                self._seq_date = today
                self._seq = 0
            self._seq += 1
            return f"sch_{today}_{self._seq:04d}"

    def _touch(self, job: SearchJob) -> None:
        now = utc_now()
        job.last_access_at = now
        job.updated_at = now

    def _get_job_or_error(self, search_id: str) -> SearchJob:
        with self._lock:
            job = self._jobs.get(search_id)
            if job is None:
                raise JsonRpcError(-32004, "Search job not found", {"search_id": search_id})
            return job

    def handle_request(self, req: Dict[str, Any]) -> Dict[str, Any]:
        if not isinstance(req, dict):
            raise JsonRpcError(-32600, "Invalid Request")

        if req.get("jsonrpc") != JSONRPC_VERSION:
            raise JsonRpcError(-32600, "Invalid Request", {"reason": "jsonrpc must be '2.0'"})

        if "method" not in req or not isinstance(req["method"], str):
            raise JsonRpcError(-32600, "Invalid Request", {"reason": "method is required"})

        req_id = req.get("id")
        method = req["method"]
        params = req.get("params", {})
        if params is None:
            params = {}
        if not isinstance(params, dict):
            raise JsonRpcError(-32602, "Invalid params")

        if method == "search/start":
            result = self._handle_start(params)
        elif method == "search/status":
            result = self._handle_status(params)
        elif method == "search/result":
            result = self._handle_result(params)
        elif method == "search/cancel":
            result = self._handle_cancel(params)
        elif method == "search/delete":
            result = self._handle_delete(params)
        else:
            raise JsonRpcError(-32601, "Method not found", {"method": method})

        return make_result_response(req_id, result)

    def _handle_start(self, params: Dict[str, Any]) -> Dict[str, Any]:
        query = params.get("query")
        if not isinstance(query, str) or query == "":
            raise JsonRpcError(-32602, "Invalid params", {"reason": "params.query must be a non-empty string"})

        options = params.get("options", {})
        context = params.get("context", {})
        if options is None:
            options = {}
        if context is None:
            context = {}

        if not isinstance(options, dict) or not isinstance(context, dict):
            raise JsonRpcError(-32602, "Invalid params", {"reason": "params.options/context must be objects"})

        root = context.get("root", "") or ""
        file_path = context.get("file", "") or ""

        if not isinstance(root, str) or not isinstance(file_path, str):
            raise JsonRpcError(-32602, "Invalid params", {"reason": "context.root/context.file must be strings"})

        effective_root = root if root else "."
        effective_root = os.path.abspath(effective_root)

        if file_path:
            target_file = file_path
            if not os.path.isabs(target_file):
                target_file = os.path.abspath(os.path.join(effective_root, target_file))
        else:
            target_file = ""

        if not os.path.exists(effective_root):
            raise JsonRpcError(-32602, "Invalid params", {"reason": f"root does not exist: {effective_root}"})

        if file_path and not os.path.exists(target_file):
            raise JsonRpcError(-32602, "Invalid params", {"reason": f"file does not exist: {target_file}"})

        if file_path and not os.path.isfile(target_file):
            raise JsonRpcError(-32602, "Invalid params", {"reason": f"file is not a regular file: {target_file}"})

        search_id = self._next_search_id()
        now = utc_now()
        job = SearchJob(
            search_id=search_id,
            query=query,
            root=effective_root,
            file=target_file,
            options=options,
            state="queued",
            created_at=now,
            updated_at=now,
            last_access_at=now,
        )

        with self._lock:
            self._jobs[search_id] = job

        self._job_queue.put(search_id)

        return {
            "search_id": search_id,
            "state": job.state,
            "created_at": isoformat_z(job.created_at),
            "expires_at": isoformat_z(job.expires_at()),
        }

    def _handle_status(self, params: Dict[str, Any]) -> Dict[str, Any]:
        search_id = params.get("search_id")
        if not isinstance(search_id, str) or not search_id:
            raise JsonRpcError(-32602, "Invalid params", {"reason": "params.search_id is required"})

        with self._lock:
            job = self._get_job_or_error(search_id)
            self._touch(job)
            return {
                "search_id": job.search_id,
                "state": job.state,
            }

    def _handle_result(self, params: Dict[str, Any]) -> Dict[str, Any]:
        search_id = params.get("search_id")
        if not isinstance(search_id, str) or not search_id:
            raise JsonRpcError(-32602, "Invalid params", {"reason": "params.search_id is required"})

        with self._lock:
            job = self._get_job_or_error(search_id)
            self._touch(job)

            result = {
                "search_id": job.search_id,
                "state": job.state,
                "query": job.query,
                "total_count": job.total_count,
                "items": job.items if job.state == "succeeded" else [],
                "generated_at": isoformat_z(job.generated_at) if job.generated_at else None,
                "expires_at": isoformat_z(job.expires_at()),
            }

            if job.state == "failed":
                result["error_message"] = job.failure_message

            return result

    def _handle_cancel(self, params: Dict[str, Any]) -> Dict[str, Any]:
        search_id = params.get("search_id")
        if not isinstance(search_id, str) or not search_id:
            raise JsonRpcError(-32602, "Invalid params", {"reason": "params.search_id is required"})

        with self._lock:
            job = self._get_job_or_error(search_id)
            self._touch(job)

            if job.state in ("succeeded", "failed", "expired"):
                raise JsonRpcError(-32010, "Search job cannot be cancelled in current state", {
                    "search_id": search_id,
                    "state": job.state,
                })

            if job.state == "cancelled":
                cancelled_at = job.cancelled_at or utc_now()
                return {
                    "search_id": job.search_id,
                    "state": "cancelled",
                    "cancelled_at": isoformat_z(cancelled_at),
                }

            job.cancel_requested = True

            if job.state == "queued":
                job.state = "cancelled"
                job.cancelled_at = utc_now()
                job.items = []
                job.total_count = 0
                job.generated_at = None

            cancelled_at = job.cancelled_at or utc_now()
            return {
                "search_id": job.search_id,
                "state": "cancelled" if job.state == "cancelled" else job.state,
                "cancelled_at": isoformat_z(cancelled_at),
            }

    def _handle_delete(self, params: Dict[str, Any]) -> Dict[str, Any]:
        search_id = params.get("search_id")
        if not isinstance(search_id, str) or not search_id:
            raise JsonRpcError(-32602, "Invalid params", {"reason": "params.search_id is required"})

        with self._lock:
            job = self._get_job_or_error(search_id)
            deleted_at = utc_now()
            job.state = "expired"
            job.updated_at = deleted_at

            del self._jobs[search_id]

            return {
                "search_id": search_id,
                "state": "expired",
                "deleted_at": isoformat_z(deleted_at),
            }

    def _worker_loop(self) -> None:
        while not self._shutdown.is_set():
            try:
                search_id = self._job_queue.get(timeout=0.5)
            except queue.Empty:
                continue

            if search_id == "__shutdown__":
                return

            with self._lock:
                job = self._jobs.get(search_id)
                if job is None:
                    continue
                if job.state == "cancelled":
                    continue
                if job.cancel_requested:
                    job.state = "cancelled"
                    job.cancelled_at = utc_now()
                    job.items = []
                    job.total_count = 0
                    job.generated_at = None
                    continue

                job.state = "running"
                job.started_at = utc_now()
                job.updated_at = job.started_at

            self._run_search_job(search_id)

    def _run_search_job(self, search_id: str) -> None:
        with self._lock:
            job = self._jobs.get(search_id)
            if job is None:
                return

            query = job.query
            root = job.root
            file_path = job.file

        try:
            cmd = ["rg", "--json", "-n", "-e", query]
            target = file_path if file_path else root
            cmd.append(target)

            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                encoding="utf-8",
                errors="replace",
                cwd=root if os.path.isdir(root) else None,
            )

            items: List[Dict[str, Any]] = []
            stderr_lines: List[str] = []

            assert process.stdout is not None
            for line in process.stdout:
                with self._lock:
                    live_job = self._jobs.get(search_id)
                    if live_job is None:
                        try:
                            process.kill()
                        except Exception:
                            pass
                        return
                    if live_job.cancel_requested:
                        try:
                            process.kill()
                        except Exception:
                            pass
                        process.wait(timeout=1)
                        live_job.state = "cancelled"
                        live_job.cancelled_at = utc_now()
                        live_job.items = []
                        live_job.total_count = 0
                        live_job.generated_at = None
                        live_job.updated_at = utc_now()
                        return

                stripped = line.strip()
                if not stripped:
                    continue

                try:
                    obj = json.loads(stripped)
                except json.JSONDecodeError:
                    continue

                if obj.get("type") != "match":
                    continue

                data = obj.get("data", {})
                path_info = data.get("path", {})
                lines_info = data.get("lines", {})
                line_number = data.get("line_number")
                submatches = data.get("submatches", [])

                path_text = path_info.get("text", "")
                text_line = lines_info.get("text", "").rstrip("\r\n")

                if not isinstance(line_number, int):
                    line_number = None

                for sm in submatches:
                    start = sm.get("start")
                    end = sm.get("end")
                    match_text = sm.get("match", {}).get("text", query)

                    item = {
                        "pattern": match_text,
                        "text": text_line,
                        "path": path_text,
                        "line_number": line_number,
                        "start": start,
                        "end": end,
                    }
                    items.append(item)

            assert process.stderr is not None
            stderr_output = process.stderr.read()
            if stderr_output:
                stderr_lines.append(stderr_output.strip())

            returncode = process.wait()

            with self._lock:
                live_job = self._jobs.get(search_id)
                if live_job is None:
                    return

                if live_job.cancel_requested:
                    live_job.state = "cancelled"
                    live_job.cancelled_at = utc_now()
                    live_job.items = []
                    live_job.total_count = 0
                    live_job.generated_at = None
                    live_job.updated_at = utc_now()
                    return

                if returncode == 0 or returncode == 1:
                    # rg returns 1 when no matches were found.
                    live_job.items = items
                    live_job.total_count = len(items)
                    live_job.state = "succeeded"
                    live_job.generated_at = utc_now()
                    live_job.updated_at = live_job.generated_at
                else:
                    live_job.state = "failed"
                    live_job.failed_at = utc_now()
                    live_job.failure_message = "\n".join([s for s in stderr_lines if s]) or f"rg exited with code {returncode}"
                    live_job.items = []
                    live_job.total_count = 0
                    live_job.generated_at = None
                    live_job.updated_at = live_job.failed_at

        except FileNotFoundError:
            with self._lock:
                live_job = self._jobs.get(search_id)
                if live_job is None:
                    return
                live_job.state = "failed"
                live_job.failed_at = utc_now()
                live_job.failure_message = "rg command not found"
                live_job.items = []
                live_job.total_count = 0
                live_job.generated_at = None
                live_job.updated_at = live_job.failed_at
        except Exception as e:
            with self._lock:
                live_job = self._jobs.get(search_id)
                if live_job is None:
                    return
                live_job.state = "failed"
                live_job.failed_at = utc_now()
                live_job.failure_message = str(e)
                live_job.items = []
                live_job.total_count = 0
                live_job.generated_at = None
                live_job.updated_at = live_job.failed_at

    def _cleanup_loop(self) -> None:
        while not self._shutdown.is_set():
            time.sleep(CLEANUP_INTERVAL_SECONDS)
            now = utc_now()

            with self._lock:
                expired_ids = []
                for search_id, job in self._jobs.items():
                    if now >= job.expires_at():
                        expired_ids.append(search_id)

                for search_id in expired_ids:
                    del self._jobs[search_id]


def parse_json_line(line: str) -> Dict[str, Any]:
    try:
        return json.loads(line)
    except json.JSONDecodeError as e:
        raise JsonRpcError(-32700, "Parse error", {"detail": str(e)})


def write_response(resp: Dict[str, Any]) -> None:
    sys.stdout.write(json.dumps(resp, ensure_ascii=False) + "\n")
    sys.stdout.flush()


def main() -> int:
    server = SearchServer()
    try:
        for raw_line in sys.stdin:
            line = raw_line.strip()
            if not line:
                continue

            req_id = None
            try:
                req = parse_json_line(line)
                req_id = req.get("id") if isinstance(req, dict) else None
                resp = server.handle_request(req)
            except JsonRpcError as e:
                resp = make_error_response(req_id, e.code, e.message, e.data)
            except Exception as e:
                resp = make_error_response(req_id, -32603, "Internal error", {"detail": str(e)})

            write_response(resp)
    finally:
        server.stop()

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
