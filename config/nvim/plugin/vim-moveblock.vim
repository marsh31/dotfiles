"===========================================================
" NAME:   vim-moveblock.vim
" AUTHRO: marsh
"
" Usage:
" MoveZett
"  call moveblock#move#main("zettelkasten#create#new")
"

if exists('loaded_vim_moveblock')
  finish
endif
let g:loaded_vim_moveblock = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

command! -range MoveZsp   call moveblock#move#main("zettelkasten#create#new")
command! -range MoveZva   call moveblock#move#main("zettelkasten#create#vnew")
command! -range MoveZtab  call moveblock#move#main("zettelkasten#create#tabnew")

let &cpoptions = s:save_cpo
unlet s:save_cpo
