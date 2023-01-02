" NAME: fern.vim
" PATH: $HOME/.vim/plugged/fern.vim
"       $HOME/.vim/plugged/fern-bookmark.vim
"       $HOME/.vim/plugged/fern-git-status.vim
"       $HOME/.vim/plugged/fern-hijack.vim
"       $HOME/.vim/plugged/fern-renderer-nerdfont.vim
" URL:  ...


nnoremap <leader>ge :Fern . -drawer<CR>
nnoremap ge :Fern .<CR>

" nmap <buffer><expr>
"       \ <Plug>(fern-my-preview)
"       \ fern#smart#leaf(
"       \   "\<Plug>(fern-action-open:edit)\<C-w>p",
"       \   "",
"       \ )
"
function! s:init_fern() abort
  nmap <buffer> p <Plug>(fern-action-open)<C-w>p
endfunction

augroup my_fern_keys
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
