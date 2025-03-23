" NAME:   core
" AUTHOR: marsh
"
" NOTE:
"


let s:root_keywords = [ '.git', '.svn' ]
let s:jobs = {}

" s:ripgre_exec {{{


fun! s:ripgrep_exec() abort
  " Get ripgrep executable from global variable 
  if has('win32')
    return 'rg.exe'
  else
    return 'rg'
  endif
endfun

" }}}
" ripgrep#core#exec {{{


fun! ripgrep#core#exec() abort
  return s:ripgrep_exec()
endfun


" }}}
" ripgrep#core#executable {{{


fun! ripgrep#core#executable() abort
  return executable(s:ripgrep_exec())
endfun


"}}}
" ripgrep#core#get_base_options{{{


fun! ripgrep#core#get_base_options() abort
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
" ripgrep#core#search(arg, name, callback) {{{
" callback
" - reset
" - on_stdout
" - on_stderr
" - on_exit
" - on_begin
" - on_match
" - on_end

fun! ripgrep#core#search(arg, name, callback) abort
  let [ l:cwd, l:rel] = vim#root#search(getcwd(), s:root_keywords)
  let l:exe = ripgrep#core#exec()
  if !ripgrep#core#executable()
    echoerr 'Rg is not executable'
  endif

  let l:cmds = [ l:exe ]
  call extend(l:cmds, ripgrep#core#get_base_options())

  let l:cmd = join(l:cmds, ' ')
  call s:call(a:name, {
        \ 'cmd':        l:cmd,
        \ 'arg':        a:arg,
        \ 'normalize':  'array',
        \ 'overlapped': v:true,
        \ 'cwd':        l:cwd,
        \ 'rel':        l:rel,
        \ }, a:callback)
endfun


" }}}
" s:call(name, data, callback) {{{

fun! s:call(name, data, callback) abort
  let l:cmd = a:data.cmd
  if a:data.arg !=# ''
    let l:cmd = l:cmd . ' ' . a:data.arg
  endif

  call a:callback.reset()
  let l:jobid = vim#async#start(l:cmd, {
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

  call ripgrep#manager#set(a:name, {
        \ 'jobid': l:jobid,
        \ 'callback': a:callback,
        \ 'data': a:data,
        \ 'parser': ripgrep#parser#parser()
        \ })
endfun

" }}}
" ripgrep#core#wait(name, ...) {{{

fun! ripgrep#core#wait(name, ...) abort
  let l:info = ripgrep#manager#get(a:name)
  let l:jobid = info.jobid
  if l:jobid <= 0
    return
  endif
  try
    let l:timeout = get(a:000, 0, -1)
    call async#job#wait([l:jobid], l:timeout)
  catch
  endtry
endfun

" }}}
" ripgrep#core#stop(name) {{{

fun! ripgrep#core#stop(name) abort
  let l:info = ripgrep#manager#get(a:name)
  let l:jobid = l:info.jobid
  if l:jobid <= 0
    return
  endif

  silent call async#job#stop(l:jobid)
  silent call ripgrep3manager#unset(a:name)
endfun

" }}}
" ripgrep#core#call(name, data, callback) {{{

fun! ripgrep#core#call(name, data, callback) abort
  call s:call(a:name, a:data, a:callback)
endfun




" }}}
" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
