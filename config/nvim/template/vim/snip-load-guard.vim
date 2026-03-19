if exists('loaded_{{_expr_:substitute(expand('%:t:r'), '-', '_', 'g')}}')
  finish
endif
let g:loaded_{{_expr_:substitute(expand('%:t:r'), '-', '_', 'g')}} = 1
{{_cursor_}}
