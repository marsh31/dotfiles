"=======================================
" FILE:   plugin/terminal.vim
" AUTHOR: marsh
" 
" Config file to extend terminal.
"=======================================

" config
set sh=bash

" augroup term_open_config; always start in insert mode.
augroup term_open_config
  autocmd!
  autocmd TermOpen * startinsert
augroup END

" command
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>

" map
tnoremap <A-j><A-j> <C-\><C-n>


" vim: sw=2 sts=2 expandtab fenc=utf-8
