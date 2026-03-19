" abbrev_cmd_simple.vim
" Version: 0.0.1
" Author:  marsh

if exists('g:loaded_abbrev_cmd_simple')
  finish
endif
let g:loaded_abbrev_cmd_simple = 1

let s:save_cpo = &cpo
set cpo&vim

" 本当はdispatch処理を当てて展開したほうがいいが、
" Vimの動作を完全に理解できていないので、一旦この形で。

command! -nargs=+ -bang AbbrevCmd      call s:add({<args>})
command! -nargs=1       AbbrevCmdDel   call abbrev#commandline#del(<f-args>)
command! -nargs=1       AbbrevCmdClear call abbrev#commandline#clear()
command! -nargs=0       AbbrevCmdList  call abbrev#commandline#list()

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
