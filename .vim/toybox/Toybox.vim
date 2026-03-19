" toybox.vim - Command-line abbreviations (Vim 8.2+)
"
" Features:
"
" Notes:
"
" Status:
"
" 


if exists('g:loaded_toybox')
  finish
endif
let g:loaded_toybox = 1

fun! TestEntry() abort
  unlet g:loaded_toybox
endfun


fun! s:test_conoremap(key) abort
  echomsg "TEST"
  return "tests" . eval('s\<Left>')
endfun

cnoremap <expr> ; <SID>test_conoremap(';')



