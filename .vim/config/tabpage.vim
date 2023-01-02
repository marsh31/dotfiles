" 15-tabpage.vim
"
" tab page setting.
nnoremap [Tab] <Nop>
nmap <C-t> [Tab]

" tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tab]'.n  ':<C-u>tabnext'. n . '<CR>'
endfor

nnoremap [Tab]h :<C-u>tabfirst<CR>
nnoremap [Tab]j gt
nnoremap [Tab]k gT
nnoremap [Tab]l :<C-u>tablast<CR>

nnoremap [Tab]q :<C-u>tabclose<CR>
nnoremap [Tab]n :<C-u>tabnew<CR>


nnoremap [Tab]<C-h> :<C-u>tabfirst<CR>
nnoremap [Tab]<C-j> gt
nnoremap [Tab]<C-k> gT
nnoremap [Tab]<C-l> :<C-u>tablast<CR>

nnoremap [Tab]<C-q> :<C-u>tabclose<CR>
nnoremap [Tab]<C-n> :<C-u>tabnew<CR>





