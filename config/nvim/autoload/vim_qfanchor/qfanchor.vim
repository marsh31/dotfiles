"""""""""""""""""""""""""""""
" NAME:   vim-qfanchor.vim
" AUTHOR: marsh
" NOTE:
"
"
"

let s:anchor_winid = -1

fun! vim_qfanchor#qfanchor#set()
  let s:anchor_winid = winnr()
endfun


fun! vim_qfanchor#qfanchor#get()
  if s:anchor_winid < 0 || winnr('$') < s:anchor_winid 
    let s:anchor_winid = winnr('#')
  endif

  return s:anchor_winid
endfun


fun! vim_qfanchor#qfanchor#open()
  let l:qflist = getqflist()
  let [ _, l:lnum, l:col, _ ] = getpos('.')

  let l:qfitem = l:qflist[l:lnum - 1]

  exe vim_qfanchor#qfanchor#get() .. "wincmd w"
  exe "edit " .. bufname(l:qfitem.bufnr)
  call cursor(l:qfitem.lnum, l:qfitem.col)
endfun


" vim: set nowrap :
