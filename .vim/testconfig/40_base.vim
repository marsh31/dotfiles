" 30-base.vim
"
" key map

" Set map leader to <Space>
let mapleader = "\<Space>"


inoremap jj <ESC>
nnoremap j gj
nnoremap k gk
nnoremap gg ggzz
nnoremap G Gzz

nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

nnoremap <C-c><C-c> :nohlsearch<CR><ESC>
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>

nnoremap s "_s
vnoremap s "_s
nnoremap S "_S
vnoremap S "_S

cnoremap <C-a> <HOME>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-r>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-r>=@/<CR><CR>
function! s:VSetSearch() abort
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction


" MARK: - Unbind the mouse buttons  {{{
map <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>
" }}}
" MARK: - ale {{{
"
" check plugin mapping.

nnoremap [ale] <Nop>
nmap <Leader>a [ale]

nmap [ale]n <Plug>(ale_next_wrap)
nmap [ale]p <Plug>(ale_previous_wrap)

