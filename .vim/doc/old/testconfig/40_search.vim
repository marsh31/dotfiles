" 30-search.vim
"
" search plugin mapping.

nnoremap <fzf> <Nop>
nmap <C-k> <fzf>

nmap <fzf><C-/> :FindHistory/<CR>
nmap <fzf><C-:> :FindHistory:<CR>
nmap <fzf><C-b> :FindBuffers<CR>
nmap <fzf><C-l> :FindBLines<CR>
nmap <fzf><C-m> :FindMark<CR>
nmap <fzf><C-r> :FindHistory:<CR>
nmap <fzf><C-t> :FindToggle<CR>
nmap <fzf><C-w> :FindWindows<CR>
nmap <fzf><C-y> :FindRegister<CR>

nmap <fzf><C-j> :Vista finder<CR>
