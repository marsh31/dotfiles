" NAME:   {{_expr_:expand('%:t:r')}}
" AUTHOR: marsh
"
" NOTE:
"
"

if exist('loaded_{{_expr_:substitute(expand('%:t:r'), '-', '_', 'g')}}')
  finish
endif
let g:loaded_{{_expr_:substitute(expand('%:t:r'), '-', '_', 'g')}} = 1

{{_cursor_}}

" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 :
