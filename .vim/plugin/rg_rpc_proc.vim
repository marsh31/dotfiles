

let s:rg_job            = 0
let s:rg_job_ready      = v:false
let s:rg_next_id        = 1
let s:rg_pending        = {}
let s:rg_last_status_id = -1
let s:rg_last_result_id = -1


fun! s:fail(msg) abort
  echohl ErrorMsg
  echomsg '[rg-rpc] ' .. a:msg
  echohl None
  return 0
endfun


fun! s:on_stdout(job_id, data) abort
  echom "on_stdout: "..string(job_id)..": "..string(data)
  for l:line in a:data
    if empty(l:line)
      continue
    endif

    try
      let l:msg = json_decode(l:line)
    catch
      call s:fail("failed to decode: "..string(l:line))
      continue
    endtry

    call s:handle_message(l:msg)
  endfor
endfun


fun! s:on_stderr(job_id, data) abort
  for l:line in a:data
    if !empty(l:line)
      call s:fail(l:line)
    endif
  endfor
endfun



fun! s:on_exit(job_id, data) abort
  let s:rg_job = 0
  let s:rg_job_ready = v:false
endfun


fun! s:handle_message(msg) abort
  if type(a:msg) != type({})
    call s:fail("invalid message: " .. string(a:msg))
    return
  endif

  let l:id = get(a:msg, 'id', v:null)
  if !has_key(a:msg, 'result')
    call s:fail("message without reuslt: "..json_encode(a:msg))
    return
  endif

  let l:result = a:msg.result
  let s:rg_pending[string(l:id)] = l:result

  echom '[rg-rpc] response id='..string(l:id)..': '..json_encode(l:result)
endfun


fun! RgRpcStart() abort
  if s:rg_job_ready
    echom '[rg-rpc] already started'
    return
  endif

  let l:script = $VIMFILES .. '/script/rg_rpc_async_proc.py' 
  let l:cmd = [ 'python3', l:script ]
  let s:rg_job = job_start(l:cmd, {
        \ 'out_cb': function('s:on_stdout'),
        \ 'err_cb': function('s:on_stderr'),
        \ 'exit_cb': function('s:on_exit'),
        \ 'out_mode': 'nl',
        \ 'err_mode': 'nl',
        \ })

  if job_status(s:rg_job) ==# 'fail'
    let s:rg_job = 0
    let s:rg_job_ready = v:false
    call s:fail("failed to start job")
    return 
  endif

  let s:rg_job_ready = v:true
  let s:rg_next_id = 1
  echom "[rg-rpc] server started"
endfun


fun! RgRpcStop() abort
  if !s:rg_job_ready
    call s:fail('not running')
    return
  endif

  call job_stop(s:rg_job)
  let s:rg_job = 0
  let s:rg_job_ready = v:false
endfun


fun! s:next_id() abort
  let l:id = s:rg_next_id
  let s:rg_next_id += 1
  return l:id
endfun



fun! s:send(req) abort
  if !s:rg_job_ready
    call s:fail("server is not running")
    return -1
  endif

  let l:line = json_encode(a:req)..'\n'
  call ch_sendraw(s:rg_job, l:line)
  return get(a:req, 'id', -1)
endfun


fun! RgRpcSearch(pattern, path, ...) abort
  let l:extra_args = get(a:000, 0, ['-n'])
  let l:id = s:next_id()

  let l:req = {
        \ 'jsonrpc': '2.0',
        \ 'id': l:id,
        \ 'method': 'search',
        \ 'params': {
        \   'pattern': a:pattern,
        \   'path': a:path,
        \   'extra_args': l:extra_args,
        \ },
        \ }

  let s:rg_last_status_id = l:id
  call s:send(l:req)
  echom '[rg-rpc] search requested id=' . l:id
  return l:id
endfun


fun! RgRpcSearchWithId(id, pattern, path, ...) abort
  let l:extra_args = get(a:000, 0, ['-n'])
  let l:req = {
        \ 'jsonrpc': '2.0',
        \ 'id': a:id,
        \ 'method': 'search',
        \ 'params': {
        \   'pattern': a:pattern,
        \   'path': a:path,
        \   'extra_args': l:extra_args,
        \ },
        \ }

  let s:rg_last_status_id = a:id
  call s:send(l:req)
  echom '[rg-rpc] search requested id=' . a:id
  return a:id
endfun



fun! RgRpcGetStatus(id) abort
  let l:req = {
        \ 'jsonrpc': '2.0',
        \ 'id': s:next_id(),
        \ 'method': 'get_status',
        \ 'params': {
        \   'id': a:id,
        \ },
        \ }

  call s:send(l:req)
endfun



fun! RgRpcGetResult(id) abort
  let l:req = {
        \ 'jsonrpc': '2.0',
        \ 'id': s:next_id(),
        \ 'method': 'get_result',
        \ 'params': {
        \   'id': a:id,
        \ },
        \ }

  let s:rg_last_result_id = a:id
  call s:send(l:req)
endfun




fun! RgRpcClear(id) abort
  let l:req = {
        \ 'jsonrpc': '2.0',
        \ 'id': s:next_id(),
        \ 'method': 'clear_cache',
        \ 'params': {
        \   'id': a:id,
        \ },
        \ }

  call s:send(l:req)
endfun



fun! RgRpcPrintCachedResponse(id) abort
  let l:key = string(a:id)
  if !has_key(s:rg_pending, l:key)
    echom '[rg-rpc] no cached response for id=' . l:key
    return
  endif
  echom json_encode(s:rg_pending[l:key])
endfun



fun! RgRpcSearchCurrentWord() abort
  let l:word = expand('<cword>')
  let l:id = RgRpcSearch(l:word, getcwd(), ['-n'])
  echom '[rg-rpc] current word search id=' . l:id
endfun



command! RgRpcStart call RgRpcStart()
command! RgRpcStop call RgRpcStop()
command! -nargs=+ RgRpcSearch call RgRpcSearch(<f-args>)
command! -nargs=1 RgRpcStatus call RgRpcGetStatus(<args>)
command! -nargs=1 RgRpcResult call RgRpcGetResult(<args>)
command! -nargs=1 RgRpcClear call RgRpcClear(<args>)
command! -nargs=1 RgRpcPrint call RgRpcPrintCachedResponse(<args>)
command! RgRpcWord call RgRpcSearchCurrentWord()



" vim: set expandtab tabstop=2 :
