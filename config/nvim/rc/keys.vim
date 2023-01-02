"=======================================
" FILE:   plugins/keys.vim
" AUTHOR: marsh
"
" Keys config file.
"=======================================

"-------------------------------------------------------------------------------------------|
"  Modes     | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
" [nore]map  |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
" n[nore]map |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
" n[orem]ap! |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
" i[nore]map |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
" c[nore]map |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
" v[nore]map |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
" x[nore]map |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
" s[nore]map |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
" o[nore]map |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
" t[nore]map |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
" l[nore]map |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
"-------------------------------------------------------------------------------------------"

" TODO: What is select mode?
" NOTE: replaceable Ctrl-p

inoremap jj <ESC>
inoremap jk <ESC>

nnoremap j gj
nnoremap k gk

nnoremap <C-c><C-c> <cmd>nohlsearch<CR>

nnoremap <F2> ggVG=<C-o>zz
nnoremap <F3> <cmd>ToggleWrap<CR>

nnoremap x "_x
nnoremap X "_X

nnoremap [q <cmd>cprevious<CR>
nnoremap ]q <cmd>cnext<CR>
nnoremap [Q <cmd>cfirst<CR>
nnoremap ]Q <cmd>clast<CR>

nnoremap [l <cmd>lprevious<CR>
nnoremap ]l <cmd>lnext<CR>



nnoremap gq <cmd>copen<CR>


nnoremap <Leader>e        <cmd>Fern . -drawer<CR>
nnoremap <leader>s        <cmd>source $XDG_CONFIG_HOME/nvim/init.vim<CR>
nnoremap <leader>.        <cmd>edit $XDG_CONFIG_HOME/nvim/<CR>
nnoremap <leader>jj       <cmd>HopWord<CR>
nnoremap <leader>jp       <cmd>HopPattern<CR>
nnoremap <leader>jl       <cmd>HopLine<CR>
nnoremap <leader>f        <cmd>Autoformat<CR>
nnoremap <leader>t        <cmd>Files<CR>
nnoremap <leader><Space>  <cmd>Buffers<CR>

"============ ==========================
" tab page keymap
nnoremap <plug>(tab-page-cmd) <Nop>
nmap <C-t> <plug>(tab-page-cmd)

nnoremap <plug>(tab-page-cmd)h gT
nnoremap <plug>(tab-page-cmd)j gt
nnoremap <plug>(tab-page-cmd)k gT
nnoremap <plug>(tab-page-cmd)l gt

nnoremap <plug>(tab-page-cmd)c :<C-u>tabclose<CR>
nnoremap <plug>(tab-page-cmd)n :<C-u>tabnew<CR>

nnoremap <plug>(tab-page-cmd)<C-h> gT
nnoremap <plug>(tab-page-cmd)<C-j> gt
nnoremap <plug>(tab-page-cmd)<C-k> gT
nnoremap <plug>(tab-page-cmd)<C-l> gt

nnoremap <plug>(tab-page-cmd)^ :<C-u>tabfirst<CR>
nnoremap <plug>(tab-page-cmd)$ :<C-u>tablast<CR>

nnoremap <plug>(tab-page-cmd)<C-c> :<C-u>tabclose<CR>
nnoremap <plug>(tab-page-cmd)<C-n> :<C-u>tabnew<CR>

nnoremap <plug>(tab-page-cmd)<C-t> <cmd>tabnext<CR>
for num in range(9)
  execute printf('nnoremap <plug>(tab-page-cmd)%s :<C-u>tabnext%s<CR>', num+1, num+1)
endfor


"=======================================
" commandline keymap
cnoremap <C-a> <HOME>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

function! s:keyToNop(types, key) abort
  for type in a:types
    execute printf('%snoremap %s <Nop>', type, a:key)
  endfor
endfunction
call s:keyToNop(["n", "i", "c", "v"], "<MiddleMouse>")
call s:keyToNop(["n", "i", "c", "v"], "<2-MiddleMouse>")
call s:keyToNop(["n", "i", "c", "v"], "<3-MiddleMouse>")
call s:keyToNop(["n", "i", "c", "v"], "<4-MiddleMouse>")


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cmdbuf.nvim
"
" key setting
nnoremap q: <cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight)<CR>
augroup cmdbuf_setting
  autocmd!
  autocmd User CmdbufNew call s:cmdbuf()
augroup END
function! s:cmdbuf() abort
  nnoremap <nowait> <buffer> q <cmd>quit<CR>
  nnoremap <buffer> dd <cmd>lua require('cmdbuf').delete()<CR>
endfunction

nnoremap ql <cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {type = "lua/cmd"})<CR>
nnoremap q/ <cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {type = "vim/search/forward"})<CR>
nnoremap q? <cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {type = "vim/search/backward"})<CR>


"
" function! s:init_fern() abort
"   " Use 'select' instead of 'edit' for default 'open' action
"   nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
" endfunction
"
" augroup fern-custom
"   autocmd! *
"   autocmd FileType fern call s:init_fern()
" augroup END

" vim: sw=2 sts=2 expandtab fenc=utf-8
