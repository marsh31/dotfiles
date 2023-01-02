""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File:   qf.vim
" Author: marsh
"
" Quickfix plugin.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("b:did_quickfix_ftplugin")
    finish
endif
let b:did_quickfix_ftplugin = 1

"===========================================================
" config
setlocal nowrap


"===========================================================
" keys
nmap <buffer> p <CR>zz<C-w>p
nmap <buffer> q :quit<CR>

nmap <buffer> a <Plug>(qfopen-action)
nmap <buffer> <C-v> <Plug>(qfopen-open-vsplit)
nmap <buffer> <C-x> <Plug>(qfopen-open-split)
nmap <buffer> <C-t> <Plug>(qfopen-open-tab)

" vim: sw=2 sts=2 expandtab fenc=utf-8
