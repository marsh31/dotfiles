" NAME:   vim-rgqf
" AUTHOR: marsh
"
" NOTE:
"
"


command! -nargs=+ RGrep    call ripgrep_qf#search#search(<q-args>)
command! -nargs=+ RGrepCF  call ripgrep_qf#search#search(<q-args> . ' ' . expand('%'))

" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
