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


let s:rg_jobid       = 0
let s:rg_next_id     = 1
let s:rg_history     = []

" id -> request(dict)
let s:pending_by_id  = {}
let g:rg_rpc_log_level = get(g:, 'rg_rpc_log_level', 'info')
let g:rg_rpc_debug      = get(g:, 'rg_rpc_debug', 0)

" ログレベルを数値化
let s:LOG_LEVEL = { 'debug': 10, 'info': 20, 'warn': 30, 'error': 40 }

function! s:log_enabled(level) abort
  let l:cur = get(s:LOG_LEVEL, get(g:, 'rg_rpc_log_level', 'info'), 20)
  let l:req = get(s:LOG_LEVEL, a:level, 20)
  return l:req >= l:cur || (a:level ==# 'debug' && get(g:, 'rg_rpc_debug', 0))
endfunction

function! s:log_debug(msg) abort
  if s:log_enabled('debug')
    echom '[rg-rpc][DEBUG] ' . string(a:msg)
  endif
endfunction

function! s:log_info(msg) abort
  if s:log_enabled('info')
    echom '[rg-rpc][INFO] ' . string(a:msg)
  endif
endfunction

function! s:log_error(msg) abort
  echoerr '[rg-rpc][ERROR] ' . string(a:msg)
endfunction

fun! s:next_id()
  let l:id = s:rg_next_id
  let s:rg_next_id += 1
  return l:id
endfun

fun! s:send(req)
  let l:line = json_encode(a:req) . "\n"
  call s:log_debug({'send': a:req})
  call ch_sendraw(job_getchannel(s:rg_jobid), l:line)
  let s:pending_by_id[a:req.id] = a:req
endfun

fun! s:on_stdout(ch, msg) abort
  try
    let l:resp = json_decode(a:msg)
    call s:log_debug({'recv': l:resp})

    if type(l:resp) != type({}) || !has_key(l:resp, 'id')
      return
    endif

    if has_key(l:resp, 'error')
      let l:err = l:resp.error
      call s:log_error(l:err)
      call remove(s:pending_by_id, l:resp.id)
      return
    endif

    let l:req = get(s:pending_by_id, l:resp.id, v:null)
    if l:req is v:null
      call s:log_debug('unknown response id: ' . string(l:resp.id))
      return
    endif

    call remove(s:pending_by_id, l:resp.id)

    if l:req.method ==# 'search/start'
      call add(s:rg_history, l:resp.result.search_id)
      call s:log_info(printf('started %s', l:resp.result.search_id))

    elseif l:req.method ==# 'search/status'
      call s:log_info(printf('%s is %s', l:resp.result.search_id, l:resp.result.state))

    elseif l:req.method ==# 'search/result'
      let l:id = l:resp.result.search_id
      let l:items_qf = get(l:resp.result, 'items_qf', v:null)
      if type(l:items_qf) == type([])
        let l:items = l:items_qf
      else
        " 後方互換: サーバーが items_qf を返さない場合、自前整形
        let l:res_items = get(l:resp.result, 'items', [])
        let l:items = []
        for l:res_item in l:res_items
          call add(l:items, {
                \ 'filename': get(l:res_item,'path',''),
                \ 'lnum': get(l:res_item,'line_number',0),
                \ 'end_lnum': get(l:res_item,'line_number',0),
                \ 'col' : get(l:res_item,'start',1),
                \ 'end_col' : get(l:res_item,'end',1),
                \ 'text': get(l:res_item,'text',''),
                \ 'type': 'I'
                \ })
        endfor
      endif

      let l:what = { 'title': 'qf result id: ' . l:id, 'items': l:items }
      call setqflist([], 'r', l:what)
      copen
    endif
  endtry
endfun


fun! s:on_stderr(ch, msg) abort
  call s:log_error(a:msg)
endfun


fun! s:on_exit(job, status) abort
  call s:log_info('server exit status=' . string(a:status))
endfun


fun! s:init() abort
  " スクリプトの場所を <sfile> から相対解決
  let l:plugdir = fnamemodify(expand('<sfile>:p'), ':h')
  let l:root = fnamemodify(l:plugdir, ':h')
  let l:server = l:root . '/script/rg_rpc_async.py'
  let s:rg_jobid = job_start(['python3', l:server], {
        \ 'out_cb': function('s:on_stdout'),
        \ 'err_cb': function('s:on_stderr'),
        \ 'exit_cb': function('s:on_exit'),
        \ 'out_mode': 'nl',
        \ 'err_mode': 'nl',
        \ })
endfun


fun! RgRpcSearch(pattern, path, args)
  let l:id = s:next_id()

  " path の解釈: 未指定は CWD。ファイル/ディレクトリの判定。
  let l:path = a:path ==# '' ? getcwd() : a:path
  let l:abs = fnamemodify(l:path, ':p')
  if isdirectory(l:abs)
    let l:root = l:abs
    let l:file = ''
  else
    let l:root = fnamemodify(l:abs, ':h')
    let l:file = l:abs
  endif

  let l:req = {
        \ 'jsonrpc': '2.0',
        \ 'id': l:id,
        \ 'method': 'search/start',
        \ 'params': {
        \   'query': a:pattern,
        \   'options': { 'format': 'vim_qf' },
        \   'context': { 'root': l:root, 'file': l:file },
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
