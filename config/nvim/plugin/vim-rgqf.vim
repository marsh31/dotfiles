" NAME:   vim-rgqf
" AUTHOR: marsh
"
" NOTE:
"
"


command! -nargs=+ Rgrep    call ripgrep_qf#search#search(<q-args>)
command! -nargs=+ Rgrepcf  call ripgrep_qf#search#search(<q-args> . ' ' . expand('%'))

" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
