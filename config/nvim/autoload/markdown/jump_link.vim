" NAME:   jump_link
" AUTHOR: marsh
"
" NOTE:
"
" vim-zett.vim
"


fun! s:get_link_regex() abort
  return '\(\[.\+\](\zs.\+\ze)\)'
endfun


fun! markdown#jump_link#search() abort
  let l:regex = s:get_link_regex()
  let @/ = l:regex
endfun


fun! markdown#jump_link#jump_next() abort
  call markdown#jump_link#search()
  normal! n
endfun


fun! markdown#jump_link#jump_prev() abort
  call markdown#jump_link#search()
  normal! N
endfun


" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
