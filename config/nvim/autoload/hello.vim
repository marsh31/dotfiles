" NAME:   hello.vim
" AUTHOR: marsh
"
" NOTE:
"
"

let s:save_cpo = &cpo
set cpo&vim

pyfile <sfile>:h:h/python3/date.py
python import vim

fun hello#hello()

endfun

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set foldmethod=marker :
