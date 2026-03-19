" NAME:   manager
" AUTHOR: marsh
"
" NOTE:
"
" 

" - info
"   - jobid
"
"   - callback
"     - reset
"     - on_stdout
"     - on_stderr
"     - on_exit
"     - on_begin
"     - on_match
"     - on_end
"
"   - data
"     - cmd
"     - arg
"     - normalize
"     - overlapped
"     - cwd
"     - rel
"
"   - parser
"
let s:jobs = {}

" ripgrep#manager#set(name, info) {{{


fun! ripgrep#manager#set(name, info) abort
  call ripgrep#manager#unset(a:name)
  let s:jobs[a:name] = a:info
endfun


" }}}
" ripgrep#manager#has_job(name) {{{


fun! ripgrep#manager#has_job(name) abort
  return has_key(s:jobs, a:name)
endfun


" }}}
" ripgrep#manager#unset(name) {{{


fun! ripgrep#manager#unset(name) abort
  if has_key(s:jobs, a:name)
    call s:jobs[a:name].reset()
    unlet s:jobs[a:name]
  endif
endfun


" }}}
" ripgrep#manager#get(name) {{{


fun! ripgrep#manager#get(name) abort
  if has_key(s:jobs, a:name)
    return s:jobs[a:name]
  endif
  return {}
endfun


" }}}


" END{{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
