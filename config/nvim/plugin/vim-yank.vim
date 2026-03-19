"===========================================================
" NAME:   vim-yank.vim
" AUTHRO: marsh
"
" Usage:
" YankCurr {name}
"

if exists('loaded_vim_yank')
  finish
endif
let g:loaded_vim_yank = 1

let s:save_cpo = &cpoptions
set cpoptions&vim


command!  -nargs=*  -complete=customlist,vim#yank#complete  YankCurr  call vim#yank#main(<q-args>)

nnoremap  <plug>(my-vim-yank-cwd)       :call vim#yank#main('work_directory')<cr>
nnoremap  <plug>(my-vim-yank-fullname)  :call vim#yank#main('full_name')<cr>
nnoremap  <plug>(my-vim-yank-filename)  :call vim#yank#main('file_name')<cr>
nnoremap  <plug>(my-vim-yank-basename)  :call vim#yank#main('base_name')<cr>
nnoremap  <plug>(my-vim-yank-parent)    :call vim#yank#main('parent')<cr>
nnoremap  <plug>(my-vim-yank-ext)       :call vim#yank#main('ext')<cr>

let &cpoptions = s:save_cpo
unlet s:save_cpo
