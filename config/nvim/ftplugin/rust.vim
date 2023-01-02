""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File:   rust.vim
" Author: marsh
"
" Rust plugin.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("b:did_rust_ftplugin")
    finish
endif
let b:did_rust_ftplugin = 1

let termdebugger="rust-gdb"

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab


" vim: sw=2 sts=2 expandtab fenc=utf-8
