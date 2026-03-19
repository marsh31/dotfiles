" NAME:   vim-bufpocket
" AUTHOR: marsh
"
" NOTE:
"
"

let s:pocket = 0

" PocketIn {{{

fun! PocketIn() abort
  let s:pocket = bufnr()
endfun

" }}}
" PocketOut {{{

fun! PocketOut() abort
  if s:pocket ==# 0
    return
  endif

  exec $'sp | b {s:pocket}'
  let s:pocket = 0
endfun

" }}}

nnoremap <Plug>(buf-pocketin)  :<C-u>call PocketIn()<CR>
nnoremap <Plug>(buf-pocketout) :<C-u>call PocketOut()<CR>

" example:
" nmap <M-c> <Plug>(buf-pocketin)
" nmap <M-v> <Plug>(buf-pocketout)



" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
