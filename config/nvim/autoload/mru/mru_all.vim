" NAME:    mru_all.vim
" AUTHOR:  marsh
"


let mru_preview_bufnr = 0


"
" mru#mru_all#initialize
" {{{

fun! mru#mru_all#initialize() abort
  call mru#mru_window#register("all", "mru#mru_all#init", "mru#mru_all#update", "mru#mru_all#show")
endfun

" }}}


" init_all
" {{{

fun! mru#mru_all#init() abort
  nmap <buffer><silent><nowait>     q          :q!<CR>
  nmap <buffer><silent><nowait>     s          :<C-u>call mru#mru_all#split_mru_file()<CR>
  nmap <buffer><silent><nowait>     <CR>       :<C-u>call mru#mru_all#enter_mru_file()<CR>
endfun

" }}}


" update_all
" {{{

fun! mru#mru_all#update(data) abort
  return a:data
endfun

" }}}


" show_all
" {{{

fun! mru#mru_all#show(data) abort
  return map(a:data, "v:val.file")
endfun

" }}}


" mru#mru_all#enter_mru_file
" {{{

fun! mru#mru_all#enter_mru_file() abort
  let select = mru#mru_window#select()
  if select !=# {}
    bd | exec "e " .. select.file
  endif
endfun

" }}}


"
" mru#mru_all#split_mru_file
" {{{

fun! mru#mru_all#split_mru_file() abort
  let select = mru#mru_window#select()
  if select !=# {}
    bd | exec "sp " .. select.file
  endif
endfun

" }}}



"
" mru#mru_all#open_preview_window
" {{{

fun! mru#mru_all#open_preview_window() abort

endfun

" }}}


" END {{{
" vim: set foldmethod=marker :
