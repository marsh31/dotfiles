" enhancedfzf
" Version: 0.0.1
" Author : marsh31
" License: 

" MARK: - Preprocessing {{{1
scriptencoding utf-8
if exists('g:loaded_enhancedfzf')
  finish
endif
let g:loaded_enhancedfzf = 1

let s:save_cpo = &cpo
set cpo&vim


" MARK: - Init values {{{1
let g:enhancedfzf_toggle_list = get(g:, "enhancedfzf_toggle_list", {})
let g:enhancedfzf_shortcuts   = get(g:, "enhancedfzf_shortcuts", {})


" MARK: - Utils {{{1
function! s:defs(commands)
  let prefix = get(g:, 'fzf_command_prefix', '')
  if prefix =~# '^[^A-Z]'
    echoerr 'g:fzf_enhanced_cmd_must start with an uppercase letter'
    return
  endif
  for command in a:commands
    let name = ':'.prefix.matchstr(command, '\C[A-Z]\S\+')
    if 2 != exists(name)
      execute substitute(command, '\ze\C[A-Z]', prefix, '')
    endif
  endfor
endfunction


" MARK: - Define commands {{{1
call s:defs([
\'command! -bar -nargs=0  Toggle    call enhancedfzf#toggles()',
\'command! -bar -nargs=0  Register  call enhancedfzf#register()',
\'command! -bar -nargs=0  Shortcuts call enhancedfzf#shortcut()',
\'command! -bar -nargs=0  Mru       call enhancedfzf#mru_files()'])


" MARK: - Post processing {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
