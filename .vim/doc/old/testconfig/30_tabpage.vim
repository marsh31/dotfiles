" 15-tabpage.vim
"
" tab page setting. 
nnoremap [Tab] <Nop>
nmap t [Tab]

" tab jump

for n in range(1, 9)
  execute 'nnoremap <silent> [Tab]'.n  ':<C-u>tabnext'. n . '<CR>'
endfor

nnoremap t^ :<C-u>tabfirst<CR>
nnoremap t$ :<C-u>tablast<CR>
nnoremap tc :<C-u>tabnew<CR>
nnoremap tx :<C-u>tabclose<CR>
nnoremap tn gt
nnoremap tp gT

