"
" augroup KeepLastPos
"   autocmd!
"   autocmd Bufread * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"zz" | endif
" augroup END
