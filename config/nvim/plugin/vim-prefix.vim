" NAME:   vim-prefix-q
" AUTHOR: marsh
"
" NOTE:
"
" prefix q / <C-s> / <C-q>
"
" nnoremap <script><expr> q empty(reg_recording()) ? '<sid>(q)' : 'q'

" <prefix>
"        .. prefix           ................ plug map
nnoremap q                   <Plug>(prefix-q)


nnoremap <Plug>(prefix-q)q   q
nnoremap <Plug>(prefix-q)o   <Cmd>only!<CR>

" nnoremap <script><expr> Q empty(reg_recording()) ? '@q' : 'q@q'


" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
