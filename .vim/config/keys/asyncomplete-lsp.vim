" Name: asyncomplete-lsp.vim
" PATH: $HOME/.vim/plugged/async.vim
"       $HOME/.vim/plugged/vim-lsp
"       $HOME/.vim/plugged/vim-lsp-settings
"       $HOME/.vim/asyncomplete.vim
"       $HOME/.vim/asyncomplete-lsp.vim
"       $HOME/.vim/asyncomplete-ultisnips.vim
"       $HOME/.vim/asyncomplete-file.vim

" Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" force refresh
inoremap <c-]> <C-o><Plug>(lsp-hover)
imap <c-k> <Plug>(asyncomplete_force_refresh)
nmap gd <plug>(lsp-definition)

nmap <F2>   <plug>(lsp-rename)
nmap <F12>  <plug>(lsp-definition)


