" NAME:   vim-markdown-newline
" AUTHOR: marsh
"
" NOTE:
"
"

if exists('loaded_vim_markdown_newline')
  finish
endif
let g:loaded_vim_markdown_newline = 1


fun! ChangeLineEnd(word) range
  for lnum in range(a:firstline, a:lastline)
    call setline(lnum, substitute(getline(lnum), ' *$', a:word, ''))
  endfor
endfun

nnoremap  <Plug>(markdown-addnewline-n)     :call ChangeLineEnd('  ')<CR>
xnoremap  <Plug>(markdown-addnewline-x)     :'<,'>call ChangeLineEnd('  ')<CR> 

nnoremap  <Plug>(markdown-deletenewline-n)  :call ChangeLineEnd('')<CR>
xnoremap  <Plug>(markdown-deletenewline-x)  :'<,'>call ChangeLineEnd('')<CR> 

nmap      <Leader><Space>a                  <Plug>(markdown-addnewline-n)
xmap      <Leader><Space>a                  <Plug>(markdown-addnewline-x)
nmap      <Leader><Space>d                  <Plug>(markdown-deletenewline-n)
xmap      <Leader><Space>d                  <Plug>(markdown-deletenewline-x)

" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 :
