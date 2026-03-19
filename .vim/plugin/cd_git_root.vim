" 
"
"

let s:git_root = ''
let s:cmd = 'git rev-parse --show-superproject-working-tree --show-toplevel'

fun! GetGitRoot()
  " sequential run
  let l:path = system(s:cmd)->trim()->expand()
  return l:path
endfun

fun! CdGitRootFrontCWD()
  fun! s:cd_to_root() abort
    let root = get(s:, 'git_root', '')
    if isdirectory(root) && root != getcwd()
      exec 'cd ' .. root
    endif
  endfun

  fun! s:on_stdout(_, msg, ...) abort
    let s:git_root = type(a:msg) == v:t_list ? a:msg[0] : msg
    call s:cd_to_root()
  endfun

  if exists('*jobstart')
    call jobstart(split(s:cmd), { 'on_stdout': function('s:on_stdout') })
  elseif exists('*job_start')
    call job_start(split(s:cmd), { 'out_cb': function('s:on_stdout') } })
  else
    call s:git_root = GetGitRoot()
    call s:cd_to_root()
  endif
endfun

" END {{{
" vim:tw=2 ts=2 et sw=2 nowrap ff=unix fenc=utf-8 foldmethod=marker:
