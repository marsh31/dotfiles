" NAME: markdown.vim
" PATH: $HOME/.vim/plugged/vim-markdown
"       $HOME/.vim/plugged/markdown-preview.nvim


" vim-markdown



" markdown-preview.nvim

let g:mkdp_auto_start = 1

function! g:Open_browser(url)
  echo a:url
  silent exe 'firefox ' . a:url
endfunction

let g:mkdp_browser = "firefox"
let g:mkdp_browserfunc = 'g:Open_browser'
