

" ============================
" fzf window の設定
" ============================
let g:fzf_layout = { 'down': '40%' }


" ============================
" fzf window のキーマップ
" ============================
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
