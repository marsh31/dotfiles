" NAME:   job
" AUTHOR: marsh
"
" NOTE:
"
"

let s:root_keywords = [ '.git', '.svn' ]

" s:ripgre_exec() {{{


fun! s:ripgrep_exec() abort
  " Get ripgrep executable from global variable 
  if has('win32')
    return 'rg.exe'
  else
    return 'rg'
  endif
endfun

" }}}
" ripgrep#job#exec() {{{


fun! ripgrep#job#exec() abort
  return s:ripgrep_exec()
endfun


" }}}
" ripgrep#job#executable() {{{


fun! ripgrep#job#executable() abort
  return executable(s:ripgrep_exec())
endfun


"}}}
" ripgrep#job#get_base_options() {{{


fun! ripgrep#job#get_base_options() abort
  " Get common command-line options for ripgrep.
  " It uses 'ignorecase' and 'smartcase' vim option.
  let l:opts = ['--json', '--no-line-buffered', '--no-block-buffered']
  if &ignorecase == 1
    call add(l:opts, '--ignore-case')
  endif
  if &smartcase == 1
    call add(l:opts, '--smart-case')
  endif
  return l:opts
endfun


" }}}
" ripgrep#job#start(args, cwd, callback) {{{
" callback
" - reset
" - on_stdout
" - on_stderr
" - on_exit

fun! ripgrep#job#start(arg, cwd, callback) abort
  let l:exe = ripgrep#job#exec()
  if !ripgrep#job#executable()
    echoerr 'Rg is not executable'
  endif

  let l:cmds = [ l:exe ]
  call extend(l:cmds, ripgrep#job#get_base_options())

  let l:cmd = join(l:cmds, ' ')
  return s:call({
        \ 'cmd':        l:cmd,
        \ 'arg':        a:arg,
        \ 'normalize':  'array',
        \ 'overlapped': v:true,
        \ 'cwd':        a:cwd,
        \ }, a:callback)
endfun


" }}}
" s:call(data, callback) {{{
" info {{{
"
" a:data
"   - cmd
"   - arg
"   - cwd
"   - normalize
"   - overlapped
"
" a:callback
"   - reset
"   - on_stdout
"   - on_stderr
"   - on_exit
"
" }}}
"

fun! s:call(data, callback) abort
  let l:cmd = a:data.cmd
  if a:data.arg !=# ''
    let l:cmd = l:cmd . ' ' . a:data.arg
  endif

  call a:callback.reset()
  let l:jobid = vim#async#job#start(l:cmd, {
        \ 'on_stdout':  a:callback.on_stdout,
        \ 'on_stderr':  a:callback.on_stderr,
        \ 'on_exit':    a:callback.on_exit,
        \ 'normalize':  a:data.normalize,
        \ 'overlapped': a:data.overlapped,
        \ 'cwd':        a:data.cwd,
        \ })

  if l:jobid <= 0
    echoerr 'Failed to be call ripgrep'
  endif

  return l:jobid
endfun

" }}}
" ripgrep#job#wait(jobid, ...) {{{

fun! ripgrep#job#wait(jobid, ...) abort
  let l:jobid = a:jobid
  if l:jobid <= 0
    return
  endif
  try
    let l:timeout = get(a:000, 0, -1)
    call vim#async#job#wait([l:jobid], l:timeout)
  catch
  endtry
endfun

" }}}
" ripgrep#job#stop(jobid) {{{

fun! ripgrep#job#stop(jobid) abort
  let l:jobid = a:jobid
  if l:jobid <= 0
    return
  endif

  silent call vim#async#job#stop(l:jobid)
endfun

" }}}
" ripgrep#job#call(data, callback) {{{

fun! ripgrep#core#call(data, callback) abort
  return s:call(a:data, a:callback)
endfun


" }}}
" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
