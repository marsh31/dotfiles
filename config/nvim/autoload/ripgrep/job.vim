" NAME:   job
" AUTHOR: marsh
"
" NOTE:
"
"

let s:root_keywords = [ '.git', '.svn' ]
let s:default_base_options = ['--json', '--no-line-buffered', '--no-block-buffered']

fun! s:noop(...) abort
endfun

let s:noop_cb = function('s:noop')

fun! s:get_default_command() abort
  if has('win32')
    return 'rg.exe'
  endif
  return 'rg'
endfun

fun! s:get_command() abort
  return get(g:, 'ripgrep_command', s:get_default_command())
endfun

fun! s:is_executable() abort
  return executable(s:get_default_command())
endfun

fun! s:get_base_options() abort
  let l:opts = get(g:, 'ripgrep_base_options', s:default_base_options)

  if type(l:opts) != v:t_list
    let l:opts = copy(s:default_base_options)
  else
    let l:opts = copy(l:opts)
  endif

  if &ignorecase
    call add(l:opts, '--ignore-case')
  endif

  if &smartcase
    call add(l:opts, '--smart-case')
  endif

  return l:opts
endfun

fun! s:get_normalize_option() abort
  let l:normalize = get(g:, 'ripgrep_normalize', 'array')
  return type(l:normalize) == v:t_string ? l:normalize : 'array'
endfun

fun! s:get_overlapped_option() abort
  return get(g:, 'ripgrep_overlapped', v:true)
endfun

fun! s:normalize_args(arg) abort
  if type(a:arg) == v:t_list
    return copy(a:arg)
  elseif type(a:arg) == v:t_string
    if empty(a:arg)
      return []
    endif
    return split(a:arg)
  endif
  return []
endfun

fun! s:split_command(cmd) abort
  if type(a:cmd) == v:t_list
    return copy(a:cmd)
  elseif type(a:cmd) == v:t_string
    if empty(a:cmd)
      return []
    endif
    return split(a:cmd)
  endif
  return []
endfun

fun! s:build_default_command(arg) abort
  let l:list = [s:get_command()]
  call extend(l:list, s:get_base_options())
  call extend(l:list, s:normalize_args(a:arg))
  return l:list
endfun

fun! s:prepare_command(command, arg) abort
  let l:cmd = s:split_command(a:command)
  call extend(l:cmd, s:normalize_args(a:arg))
  return l:cmd
endfun

fun! s:resolve_cwd(data) abort
  let l:cwd = get(a:data, 'cwd', '')
  if type(l:cwd) != v:t_string || empty(l:cwd)
    let l:cwd = get(g:, 'ripgrep_cwd', '')
  endif
  return l:cwd
endfun

fun! s:fetch_callback(callback, key) abort
  if has_key(a:callback, a:key) && type(a:callback[a:key]) == v:t_func
    return a:callback[a:key]
  endif
  return s:noop_cb
endfun

fun! s:build_job_options(data, callback) abort
  let l:options = {
        \ 'on_stdout': s:fetch_callback(a:callback, 'on_stdout'),
        \ 'on_stderr': s:fetch_callback(a:callback, 'on_stderr'),
        \ 'on_exit':   s:fetch_callback(a:callback, 'on_exit'),
        \ 'normalize': get(a:data, 'normalize', s:get_normalize_option()),
        \ 'overlapped': get(a:data, 'overlapped', s:get_overlapped_option()),
        \ }
  let l:cwd = s:resolve_cwd(a:data)
  if type(l:cwd) == v:t_string && !empty(l:cwd)
    let l:options.cwd = l:cwd
  endif
  return l:options
endfun

fun! s:start_job(data, callback) abort
  let l:command = s:prepare_command(get(a:data, 'cmd', []), get(a:data, 'arg', []))
  if empty(l:command)
    echoerr 'ripgrep: command is empty'
    return -1
  endif

  let ResetFunc = get(a:callback, 'reset', v:null)
  if type(ResetFunc) == v:t_func
    call ResetFunc()
  endif

  let l:jobid = vim#async#job#start(l:command, s:build_job_options(a:data, a:callback))
  if l:jobid <= 0
    echoerr 'ripgrep: failed to start job'
  endif
  return l:jobid
endfun

fun! s:wait(jobid, timeout) abort
  if a:jobid <= 0
    return
  endif
  try
    call vim#async#job#wait([a:jobid], a:timeout)
  catch
  endtry
endfun

fun! s:stop(jobid) abort
  if a:jobid <= 0
    return
  endif
  silent call vim#async#job#stop(a:jobid)
endfun

" *ripgrep#job#exec()* ripgrep の実行コマンド名を返す。
fun! ripgrep#job#exec() abort
  return s:get_command()
endfun

" *ripgrep#job#executable()* ripgrep が実行可能かを確認する。
fun! ripgrep#job#executable() abort
  return s:is_executable()
endfun

" *ripgrep#job#get_base_options()* ripgrep の基本オプション一覧を取得する。
fun! ripgrep#job#get_base_options() abort
  return s:get_base_options()
endfun

" *ripgrep#job#start()* ripgrep ジョブを非同期に起動する。
" 引数:
"   arg: ripgrep へ渡す追加引数 (リストまたは文字列)
"   cwd: 実行ディレクトリ
"   callback: stdout/stderr/exit/reset ハンドラを持つ辞書
fun! ripgrep#job#start(arg, cwd, callback) abort
  if !s:is_executable()
    echoerr 'Rg is not executable'
    return -1
  endif
  let l:data = {
        \ 'cmd': s:build_default_command(a:arg),
        \ 'cwd': a:cwd,
        \ }
  return s:start_job(l:data, a:callback)
endfun

" *ripgrep#job#wait()* 指定したジョブの終了を待機する。
fun! ripgrep#job#wait(jobid, ...) abort
  let l:timeout = get(a:000, 0, -1)
  call s:wait(a:jobid, l:timeout)
endfun

" *ripgrep#job#stop()* 指定したジョブを停止する。
fun! ripgrep#job#stop(jobid) abort
  call s:stop(a:jobid)
endfun

" *ripgrep#job#call()* 任意のコマンド仕様で ripgrep ジョブを開始する。
fun! ripgrep#job#call(data, callback) abort
  return s:start_job(a:data, a:callback)
endfun

" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
