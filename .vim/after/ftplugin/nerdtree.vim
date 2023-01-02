" ================================================
" File:   nerdtree.vim
" Author: marsh31
" 
" ================================================

augroup NERDTreeConfig
  autocmd!
  autocmd WinEnter * if &ft == 'nerdtree' | execute 'normal R' | endif
augroup END
