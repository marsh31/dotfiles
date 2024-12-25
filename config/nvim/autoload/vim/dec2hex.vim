""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" vim#dec2hex#do {{{
" 引数で受け取った１０進数数字を１６進数で返す関数
"

fun! vim#dec2hex#do(dec) abort
  return printf("%x", a:dec)
endfun

" }}}



"
" vim#dec2hex#get_cursor {{{
" カーソル下の１０進数数字を取得して１６進数で返す関数
"

fun! vim#dec2hex#get_cursor() abort
  let word = expand("<cword>")
  return vim#dec2hex#do(str2nr(word))
endfun

" }}}



"
" vim#dec2hex#change_cursor {{{
"
" 64

fun! vim#dec2hex#change_cursor() abort
  let hex = vim#dec2hex#get_cursor()
  exec $'normal! bcw{hex}'
endfun

" }}}




" END {{{
" vim: foldmethod=marker
