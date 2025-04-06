" NAME:   vim-test.vim
" AUTHOR: marsh
"
" NOTE:
"
"

let s:save_cpo = &cpo
set cpo&vim

pyfile <sfile>:h:h/python3/date.py
python import vim

fun TestPy()
  let s = python3 weeknum(2025, 1, 1)
  echo s

endfun

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set foldmethod=marker :
