" NAME:   vim-markdown-indent
" AUTHOR: marsh
"
" NOTE:
" 20250104170137.md を参照
"

" if exists('loaded_vim_markdown_indent')
"   finish
" endif
" let g:loaded_vim_markdown_indent = 1


fun! s:markdown_enhancement_ctrl_t() abort
  let l:line = getline('.')
  let [ _, l:curlnum, l:curcol, _, _ ] = getcurpos('.')
  if l:line =~# '^#\+\s'
    exec $'normal! I#'
    exec $'normal! {l:curcol + 1}|'
  else
    exec 'normal! >>'
  endif
endfun

fun! s:markdown_enhancement_ctrl_d() abort
  let l:line = getline('.')
  let [ _, l:curlnum, l:curcol, _, _ ] = getcurpos('.')
  if l:line =~# '^#\+\s'
    exec $'normal! I<DEL>
    exec $'normal! {l:curcol - 1}|'
  else
    exec 'normal! <<'
  endif
endfun

imap <Plug>(markdown_insert_ctrl_d) <C-o>:<C-u>call <SID>markdown_enhancement_ctrl_d()<CR>
imap <Plug>(markdown_insert_ctrl_t) <C-o>:<C-u>call <SID>markdown_enhancement_ctrl_t()<CR>


" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 :
