#!/usr/bin/env python3
import json
import shlex
import subprocess
import sys
import threading
import time
import traceback
from typing import Any, Dict, List, Optional


class RipgrepAsyncJsonRpcServer:
    def __init__(self) -> None:
        # id -> job
        self.jobs: Dict[str, Dict[str, Any]] = {}
        self.lock = threading.Lock()

    def send_response(self, response: Dict[str, Any]) -> None:
        sys.stdout.write(json.dumps(response, ensure_ascii=False) + "\n")
        sys.stdout.flush()

    def make_error(self, req_id: Any, code: int, message: str, data: Any = None) -> Dict[str, Any]:
        err: Dict[str, Any] = {
            "jsonrpc": "2.0",
            "id": req_id,
            "error": {
                "code": code,
                "message": message,
            },
        }
        if data is not None:
            err["error"]["data"] = data
        return err

    def make_result(self, req_id: Any, result: Any) -> Dict[str, Any]:
        return {
            "jsonrpc": "2.0",
            "id": req_id,
            "result": result,
        }

    def _now(self) -> float:
        return time.time()

    def _job_summary(self, job: Dict[str, Any]) -> Dict[str, Any]:
        return {
            "job_id": job["job_id"],
            "status": job["status"],
            "created_at": job["created_at"],
            "started_at": job.get("started_at"),
            "finished_at": job.get("finished_at"),
            "request": job["request"],
            "command_pretty": job.get("command_pretty"),
            "returncode": job.get("returncode"),
            "cached": True,
        }

    def _run_search_job(self, job_id: str) -> None:
        with self.lock:
            job = self.jobs.get(job_id)
            if job is None:
                return
            job["status"] = "running"
            job["started_at"] = self._now()

            params = job["request"]
            pattern = params["pattern"]
            path = params["path"]
            extra_args = params["extra_args"]

            cmd = ["rg", "--json"] + extra_args + [pattern, path]
            job["command"] = cmd
            job["command_pretty"] = " ".join(shlex.quote(x) for x in cmd)

        try:
            completed = subprocess.run(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                encoding="utf-8",
                errors="replace",
                check=False,
            )

            events: List[Dict[str, Any]] = []
            for line in completed.stdout.splitlines():
                line = line.strip()
                if not line:
                    continue
                try:
                    events.append(json.loads(line))
                except json.JSONDecodeError:
                    events.append({
                        "type": "raw",
                        "data": line,
                    })

            with self.lock:
                job = self.jobs.get(job_id)
                if job is None:
                    return
                job["status"] = "done"
                job["finished_at"] = self._now()
                job["returncode"] = completed.returncode
                job["stderr"] = completed.stderr
                job["events"] = events
                job["error"] = None

        except FileNotFoundError:
            with self.lock:
                job = self.jobs.get(job_id)
                if job is None:
                    return
                job["status"] = "error"
                job["finished_at"] = self._now()
                job["error"] = {
                    "code": -32001,
                    "message": "ripgrep (rg) not found in PATH",
                }

        except Exception as e:
            with self.lock:
                job = self.jobs.get(job_id)
                if job is None:
                    return
                job["status"] = "error"
                job["finished_at"] = self._now()
                job["error"] = {
                    "code": -32002,
                    "message": "Failed to execute ripgrep",
                    "data": {
                        "exception": str(e),
                        "traceback": traceback.format_exc(),
                    },
                }

    def handle_search(self, req_id: Any, params: Dict[str, Any]) -> Dict[str, Any]:
        req_key = str(req_id)

        pattern = params.get("pattern")
        path = params.get("path", ".")
        extra_args = params.get("extra_args", [])

        if not isinstance(pattern, str) or not pattern:
            return self.make_error(req_id, -32602, "Invalid params: 'pattern' must be a non-empty string")

        if not isinstance(path, str) or not path:
            return self.make_error(req_id, -32602, "Invalid params: 'path' must be a non-empty string")

        if not isinstance(extra_args, list) or not all(isinstance(x, str) for x in extra_args):
            return self.make_error(req_id, -32602, "Invalid params: 'extra_args' must be a list of strings")

        with self.lock:
            # 同じ id が既にある場合は再実行せず、その状態を返す
            if req_key in self.jobs:
                job = self.jobs[req_key]
                return self.make_result(req_id, {
                    "accepted": True,
                    "reused": True,
                    "job": self._job_summary(job),
                })

            job: Dict[str, Any] = {
                "job_id": req_key,
                "status": "queued",
                "created_at": self._now(),
                "started_at": None,
                "finished_at": None,
                "request": {
                    "pattern": pattern,
                    "path": path,
                    "extra_args": extra_args,
                },
                "command": None,
                "command_pretty": None,
                "returncode": None,
                "stderr": None,
                "events": None,
                "error": None,
            }
            self.jobs[req_key] = job

            thread = threading.Thread(target=self._run_search_job, args=(req_key,), daemon=True)
            job["thread"] = thread
            thread.start()

            return self.make_result(req_id, {
                "accepted": True,
                "reused": False,
                "job": self._job_summary(job),
            })

    def handle_get_status(self, req_id: Any, params: Dict[str, Any]) -> Dict[str, Any]:
        target_id = params.get("id", req_id)
        target_key = str(target_id)

        with self.lock:
            job = self.jobs.get(target_key)
            if job is None:
                return self.make_error(req_id, -32004, f"No job found for id={target_id!r}")

            result: Dict[str, Any] = self._job_summary(job)
            if job["status"] == "error":
                result["error"] = job["error"]
            return self.make_result(req_id, result)

    def handle_get_result(self, req_id: Any, params: Dict[str, Any]) -> Dict[str, Any]:
        target_id = params.get("id", req_id)
        target_key = str(target_id)

        with self.lock:
            job = self.jobs.get(target_key)
            if job is None:
                return self.make_error(req_id, -32004, f"No job found for id={target_id!r}")

            status = job["status"]
            if status in ("queued", "running"):
                return self.make_result(req_id, {
                    "ready": False,
                    "job": self._job_summary(job),
                })

            if status == "error":
                return self.make_result(req_id, {
                    "ready": True,
                    "job": self._job_summary(job),
                    "error": job["error"],
                })

            return self.make_result(req_id, {
                "ready": True,
                "job": self._job_summary(job),
                "result": {
                    "command": job["command"],
                    "command_pretty": job["command_pretty"],
                    "returncode": job["returncode"],
                    "stderr": job["stderr"],
                    "events": job["events"],
                },
            })

    def handle_clear_cache(self, req_id: Any, params: Dict[str, Any]) -> Dict[str, Any]:
        with self.lock:
            if "id" in params:
                target_key = str(params["id"])
                existed = target_key in self.jobs
                if existed:
                    del self.jobs[target_key]
                return self.make_result(req_id, {"cleared": existed, "target_id": params["id"]})

            count = len(self.jobs)
            self.jobs.clear()
            return self.make_result(req_id, {"cleared_all": True, "count": count})

    def handle_request(self, request: Dict[str, Any]) -> Dict[str, Any]:
        if request.get("jsonrpc") != "2.0":
            return self.make_error(request.get("id"), -32600, "Invalid Request: jsonrpc must be '2.0'")

        req_id = request.get("id")
        if req_id is None:
            return self.make_error(None, -32600, "Invalid Request: missing 'id'")

        method = request.get("method")
        params = request.get("params", {})

        if not isinstance(method, str):
            return self.make_error(req_id, -32600, "Invalid Request: 'method' must be a string")

        if not isinstance(params, dict):
            return self.make_error(req_id, -32602, "Invalid params: 'params' must be an object")

        if method == "search":
            return self.handle_search(req_id, params)
        if method == "get_status":
            return self.handle_get_status(req_id, params)
        if method == "get_result":
            return self.handle_get_result(req_id, params)
        if method == "clear_cache":
            return self.handle_clear_cache(req_id, params)

        return self.make_error(req_id, -32601, f"Method not found: {method}")

    def serve(self) -> None:
        for raw_line in sys.stdin:
            line = raw_line.strip()
            if not line:
                continue

            try:
                request = json.loads(line)
            except json.JSONDecodeError as e:
                self.send_response(self.make_error(None, -32700, "Parse error", {"detail": str(e)}))
                continue

            if not isinstance(request, dict):
                self.send_response(self.make_error(None, -32600, "Invalid Request: JSON object expected"))
                continue

            try:
                response = self.handle_request(request)
            except Exception as e:
                response = self.make_error(
                    request.get("id"),
                    -32603,
                    "Internal error",
                    {
                        "exception": str(e),
                        "traceback": traceback.format_exc(),
                    },
                )

            self.send_response(response)


def main() -> None:
    server = RipgrepAsyncJsonRpcServer()
    server.serve()


if __name__ == "__main__":
    main()
