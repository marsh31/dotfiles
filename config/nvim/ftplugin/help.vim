""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File:   ftplugin/help.vim
" Author: marsh
"
" Help plugin.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("b:did_help_ftplugin")
    finish
endif
let b:did_help_ftplugin = 1

setlocal wrap
setlocal signcolumn=no
nnoremap <buffer> q <C-w>c

" vim: sw=2 sts=2 expandtab fenc=utf-8
