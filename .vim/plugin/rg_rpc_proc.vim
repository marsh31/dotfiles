"
" スクリプト(script/rg_rpc_async.py)はサーバーとして動きます。
" 標準入力で要求を受け取り、処理を実行します。
" 要求はJSON-RPC形式です。検索開始は以下の形式で受け取ります。
"
" 検索開始API
" REQ: { "jsonrpc": "2.0", "id": 1, "method": "search/start", "params": { "query": "foo bar", "options": { "limit": 50, "offset": 0, "sort": "score_desc" }, "context": { "root": "", "file": "", } } }
" RES: { "jsonrpc": "2.0", "id": 1, "result": { "search_id": "sch_20260328_0001", "state": "queued", "created_at": "2026-03-28T10:00:00Z", "expires_at": "2026-03-28T10:05:00Z" } }
" スクリプトは検索ジョブのIDを発行し、IDを返します。
" ジョブが実行できるようになったら、検索ジョブを実行します。検索ジョブのステータス、結果は保持しておき、要求があれば返します。
"
" 状態取得API
" REQ: { "jsonrpc": "2.0", "id": 2, "method": "search/status", "params": { "search_id": "sch_20260328_0001" } }
" RES: { "jsonrpc": "2.0", "id": 2, "result": { "search_id": "sch_20260328_0001", "state": "running", } }
"
" 状態はqueued, running, succeeded, failed, cancelled, expired とあります。
" 状態は以下のように遷移します。
" queued -> running -> succeeded -> expired
" queued -> running -> failed -> expired
" queued -> running -> cancelled -> expired
" queued -> cancelled -> expired
"
" expired状態に遷移するのは、状態要求や結果要求が来なくなってから１時間経過したあととする。
" また、search/delete 要求があった場合も遷移するとする。
"
" 結果取得API
" REQ: { "jsonrpc": "2.0", "id": 3, "method": "search/result", "params": { "search_id": "sch_20260328_0001", } }
" RES: { "jsonrpc": "2.0", "id": 3, "result": { "search_id": "sch_20260328_0001", "state": "succeeded", "query": "foo bar", "total_count": 128, "items": [ { "pattern": "foo bar" "text": "Guide foo bar", "path": "/docs/foobar.txt", "line_number": 95, "start": 7, "end": 13 }, { "pattern": "foo bar" "text": "Guide foo bar", "path": "/docs/foobar.txt", "line_number": 95, "start": 7, "end": 13 } ], "generated_at": "2026-03-28T10:00:00Z", "expires_at": "2026-03-28T11:00:00Z" } }
"
"
" キャンセル要求API
" REQ: { "jsonrpc": "2.0", "id": 4, "method": "search/cancel", "params": { "search_id": "sch_20260328_0001" } }
" RES: { "jsonrpc": "2.0", "id": 4, "result": { "search_id": "sch_20260328_0001", "state": "cancelled", "cancelled_at": "2026-03-28T10:00:02Z" } }
"
"
" delete要求API
" REQ: { "jsonrpc": "2.0", "id": 5, "method": "search/delete", "params": { "search_id": "sch_20260328_0001" } }
" RES: { "jsonrpc": "2.0", "id": 4, "result": { "search_id": "sch_20260328_0001", "state": "expired", "deleted_at": "2026-03-28T10:00:02Z" } }
"
" 補足：
" 標準入力の受け取り形式は１行に１つのJsonです。出力も同様です。
"
" サーバーは、単一プロセスで、内部にジョブキューとワーカーを持つ形です。
"
" 検索対象の決め方は、context.root が検索起点ディレクトリで、
" context.file が指定されたらそのファイルだけ検索、未指定なら root 配下全体検索。
" root, file が未指定の場合は、カレントディレクトリ配下全体検索としてください。
"
" query の "foo bar" は ripgrep にそのまま1個のパターン文字列として渡します。他の場合も同様です。
"
" 結果の並び順は、未実装で良いです。今後の拡張性のために入れています。
"
" offset/limitについては未実装で良いです。今後の拡張性のために入れています。
"
" cancel時の結果の扱いですが、途中までの結果は破棄します。
"
" expired後は、結果は即削除してNotFound状態にします。
"
" 不正メソッドや未知の search_id は JSON-RPC 2.0 の error で返します。
"
" 実行環境は rg コマンドがインストール済みの Unix系/Windowsを想定しています。
"
"
"
"
"


let s:rg_jobid     = 0
let s:rg_next_id   = 1
let s:rg_history   = []
let s:rg_req_queue = QueueNew()

fun! s:next_id()
  let l:id = s:rg_next_id
  let s:rg_next_id += 1
  return l:id
endfun

fun! s:send(req)
  let l:line = json_encode(a:req).."\n"
  echom l:line
  call ch_sendraw(job_getchannel(s:rg_jobid), l:line)
  call QueuePush(s:rg_req_queue, a:req)
endfun

fun! s:on_stdout(ch, msg) abort
  try
    let l:response = json_decode(a:msg)
    let l:request  = QueuePop(s:rg_req_queue)

    if l:response.id ==# l:request.id 
      
      if l:request.method ==# 'search/start'
        call add(s:rg_history, l:response.result.search_id)

      elseif l:request.method ==# 'search/status'
        echom printf("%s is %s", l:response.result.search_id, l:response.result.state)

      elseif l:request.method ==# 'search/result'
        let id = l:response.result.search_id
        let res_items = l:response.result.items
        let items = []

        for res_item in res_items
          call add(items, {
                \ 'filename': res_item.path,
                \ 'lnum': res_item.line_number,
                \ 'end_lnum': res_item.line_number,
                \ 'col' : res_item.start,
                \ 'end_col' : res_item.end,
                \ 'text': res_item.text,
                \ 'type': 'I'
                \ })
        endfor

        let what = {
              \ 'title': 'qf result id: '..id,
              \ 'items': items,
              \}
        call setqflist([], 'r', what)
      endif
    endif
  endtry
endfun


fun! s:on_stderr(ch, msg) abort
  echom 'ERR=' . string(a:msg)
endfun


fun! s:on_exit(job, status) abort
  echom 'EXIT=' . string(a:status)
endfun


fun! s:init() abort
  let s:rg_jobid = job_start(['python3', $VIMFILES..'/script/rg_rpc_async.py'], {
        \ 'out_cb': function('s:on_stdout'),
        \ 'err_cb': function('s:on_stderr'),
        \ 'exit_cb': function('s:on_exit'),
        \ 'out_mode': 'nl',
        \ 'err_mode': 'nl',
        \ })
endfun


fun! RgRpcSearch(pattern, path, args)
  let l:extra_args = get(a:000, 0, ['-n'])
  let l:id = s:next_id()

  let l:req = {
        \ 'jsonrpc': '2.0',
        \ 'id': l:id,
        \ 'method': 'search/start',
        \ 'params': {
        \   'query': a:pattern,
        \   'options': {},
        \   'context': {
        \     'root': getcwd(),
        \   },
        \ },
        \ }

  call s:send(l:req)
  return l:id
endfun


fun! RgRpcStatus()
  for l:id in s:rg_history
    let l:req = {
          \ 'jsonrpc': '2.0',
          \ 'id': s:next_id(),
          \ 'method': 'search/status',
          \ 'params': {
          \   'search_id': l:id,
          \ },
          \ }
    call s:send(l:req)
  endfor
endfun


fun! RgRpcResult(id)
  let l:req = {
        \ 'jsonrpc': '2.0',
        \ 'id': s:next_id(),
        \ 'method': 'search/result',
        \ 'params': {
        \   'search_id': a:id,
        \ },
        \ }

  call s:send(l:req)
endfun

call s:init()


" vim: set expandtab tabstop=2 :
