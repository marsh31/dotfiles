" /home/marsh/.config/vim-jetpack
" /home/marsh/.config/vim-jetpack/pack/jetpack/opt/_
" /home/marsh/.config/vim-jetpack/pack/jetpack/opt/vim-vsnip
" /home/marsh/.config/nvim
" /etc/xdg/xdg-ubuntu/nvim
" /etc/xdg/nvim
" /home/marsh/.local/share/nvim/site
" /usr/share/ubuntu/nvim/site
" /usr/local/share/nvim/site
" /usr/share/nvim/site
" /var/lib/snapd/desktop/nvim/site
" /usr/local/share/nvim/runtime
" /usr/local/lib/nvim
" /home/marsh/.config/vim-jetpack/pack/jetpack/opt/_/after
" /var/lib/snapd/desktop/nvim/site/after
" /usr/share/nvim/site/after
" /usr/local/share/nvim/site/after
" /usr/share/ubuntu/nvim/site/after
" /home/marsh/.local/share/nvim/site/after
" /etc/xdg/nvim/after
" /etc/xdg/xdg-ubuntu/nvim/after
" /home/marsh/.config/nvim/after
" /home/marsh/.config/vim-jetpack/pack/jetpack/src/vim-jetpack
" /home/marsh/dotfiles/.config/nvim/box
" vint: -ProhibitSetNoCompatible

if has('vim_starting')
  set encoding=utf-8
endif
scriptencoding utf-8

if &compatible
  set nocompatible
endif

let $MYVIMRC = resolve($MYVIMRC)

let s:config = {
\   'type': 'nvim',
\   'pairs': 'minx',
\ }

if !has('nvim')
  let s:config.type = 'vim'
endif

let g:vimrc = {}
let g:vimrc.pkg = {}
let g:vimrc.pkg.plugins = expand('~/.config/vim-jetpack')
let g:vimrc.pkg.jetpack = expand(g:vimrc.pkg.plugins .. '/pack/jetpack/src/vim-jetpack')
let g:vimrc.pkg.paths = {}

if !isdirectory(g:vimrc.pkg.jetpack)
  call system(printf('git clone --depth 1 https://github.com/tani/vim-jetpack %s', shellescape(g:vimrc.pkg.jetpack)))
endif

let &runtimepath = &runtimepath . ',' . g:vimrc.pkg.jetpack
let &runtimepath = &runtimepath . ',' . fnamemodify($MYVIMRC, ':p:h')

call vimrc#ignore_runtime()

let g:jetpack#ignore_patterns = [
\   '**/.*',
\   '**/.*/**',
\   '**/*.{toml,yaml,yml}',
\   '**/t/**',
\   '**/test/**',
\   '**/doc/tags',
\   '**/Makefile*',
\   '**/Gemfile*',
\   '**/Rakefile*',
\   '**/VimFlavor*',
\   '**/README*',
\   '**/LICENSE*',
\   '**/LICENCE*',
\   '**/CONTRIBUTING*',
\   '**/CHANGELOG*',
\   '**/NEWS*',
\   '**/VERSION',
\ ]

call jetpack#begin(g:vimrc.pkg.plugins)
call jetpack#add('Shougo/denite.nvim')
call jetpack#add('Shougo/deol.nvim')
call jetpack#add('andymass/vim-matchup')
call jetpack#add('bluz71/vim-nightfly-guicolors')
call jetpack#add('github/copilot.vim')
call jetpack#add('haya14busa/vim-asterisk')
call jetpack#add('hrsh7th/fern-mapping-call-function.vim')
call jetpack#add('hrsh7th/fern-mapping-collapse-or-leave.vim')
call jetpack#add('hrsh7th/vim-candle')
call jetpack#add('hrsh7th/vim-denite-gitto')
call jetpack#add('hrsh7th/vim-effort-gf')
call jetpack#add('hrsh7th/vim-eft')
call jetpack#add('hrsh7th/vim-gindent')
call jetpack#add('hrsh7th/vim-gitto')
call jetpack#add('hrsh7th/vim-operator-replace')
call jetpack#add('hrsh7th/vim-searchx')
call jetpack#add('hrsh7th/vim-vsnip')
call jetpack#add('itchyny/lightline.vim')
call jetpack#add('kana/vim-operator-user')
call jetpack#add('kana/vim-textobj-user')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/fern.vim')
call jetpack#add('lambdalisue/glyph-palette.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('lambdalisue/suda.vim')
call jetpack#add('lambdalisue/vim-findent')
call jetpack#add('machakann/vim-sandwich')
call jetpack#add('machakann/vim-swap')
call jetpack#add('nanotee/luv-vimdocs')
call jetpack#add('sainnhe/everforest')
call jetpack#add('t9md/vim-choosewin')
call jetpack#add('t9md/vim-quickhl')
call jetpack#add('tani/vim-jetpack')
call jetpack#add('thinca/vim-qfreplace')
call jetpack#add('thinca/vim-quickrun')
call jetpack#add('thinca/vim-themis')
call jetpack#add('tweekmonster/helpful.vim')
call jetpack#add('tyru/open-browser.vim')
if s:config.pairs ==# 'minx'
  call jetpack#add('hrsh7th/vim-minx')
elseif s:config.pairs ==# 'lexima'
  call jetpack#add('cohama/lexima.vim')
endif
if s:config.type ==# 'vim'
  call jetpack#add('hrsh7th/vim-vsnip-integ')
  call jetpack#add('mattn/vim-lsp-settings')
  call jetpack#add('prabirshrestha/asyncomplete-lsp.vim')
  call jetpack#add('prabirshrestha/asyncomplete.vim')
  call jetpack#add('prabirshrestha/vim-lsp')
endif
if s:config.type ==# 'nvim'
  call jetpack#add('b0o/SchemaStore.nvim')
  call jetpack#add('hrsh7th/cmp-buffer')
  call jetpack#add('hrsh7th/cmp-calc')
  call jetpack#add('hrsh7th/cmp-cmdline')
  call jetpack#add('hrsh7th/cmp-emoji')
  call jetpack#add('hrsh7th/cmp-nvim-lsp')
  call jetpack#add('hrsh7th/cmp-nvim-lsp-document-symbol')
  call jetpack#add('hrsh7th/cmp-nvim-lsp-signature-help')
  call jetpack#add('hrsh7th/cmp-nvim-lua')
  call jetpack#add('hrsh7th/cmp-path')
  call jetpack#add('hrsh7th/cmp-vsnip')
  call jetpack#add('hrsh7th/nvim-cmp')
  call jetpack#add('neovim/nvim-lspconfig')
  call jetpack#add('notomo/vusted')
  call jetpack#add('nvim-lua/plenary.nvim')
  call jetpack#add('nvim-treesitter/nvim-treesitter')
  call jetpack#add('onsails/lspkind-nvim')
  call jetpack#add('petertriho/cmp-git')
endif
if s:config.type ==# 'coc'
  call jetpack#add('neoclide/coc.nvim', { 'branch': 'release'  })
endif
call jetpack#end()

" Bin.
let $PATH = $PATH .. ':' .. g:vimrc.pkg.plugins . '/pack/jetpack/opt/_/bin'

for s:name in jetpack#names()
  let g:vimrc.pkg.paths[s:name] = jetpack#get(s:name).path
endfor
" Local plugins. 
for s:p in glob('~/Develop/Vim/*', v:false, v:true, v:false)
  let &runtimepath = escape(s:p, ',') .. ',' .. &runtimepath
  let g:vimrc.pkg.paths[fnamemodify(s:p, ':t')] = fnamemodify(s:p, ':p')
endfor

augroup vimrc
  autocmd!
augroup END

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
let $TERM = 'xterm-256color'
set termguicolors
set t_Co=256
set t_ut=
set updatetime=200
set autoread
set hidden
set nobackup
set noswapfile
set lazyredraw
set scrolloff=5
set sidescrolloff=3
set belloff=all
set synmaxcol=512
set undofile
set shell=zsh
set isfname-==
set isfname+=\\
set diffopt=filler,algorithm:patience,indent-heuristic,iwhite

set mouse=n
set termguicolors
set splitright
set splitbelow
set nowrap
set cursorline
set nonumber
set modeline
set modelines=2
set wildmenu
set wildmode=longest:full
set wildchar=<Tab>
set pumheight=15
set showtabline=2
set cmdheight=1
set list
set noshowmode
set ambiwidth=single
set title
set shortmess+=I
set shortmess+=c
set listchars=tab:>-,trail:^
set background=dark
set virtualedit=all
" set debug=msg

set incsearch
set hlsearch
set ignorecase
set smartcase
set suffixesadd=.php,.tpl,.ts,.tsx,.css,.scss,.rb,.java,.json,.md,.as,.js,.jpg,.jpeg,.gif,.png,.vim
set matchpairs=(:),[:],{:}

set autoindent
set cindent
set smartindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=0
set backspace=2
set whichwrap=b,s,h,l,<,>,[,]
set completeopt=menuone,noselect,noinsert
set startofline
set signcolumn=yes
set formatoptions=croq

let g:vim_indent_cont = 0
let g:markdown_fenced_languages = ['ts=typescript']

if has('nvim')
  set wildoptions=pum
  set scrollback=2000
  set clipboard=unnamedplus
  set fillchars+=vert:\│,eob:\ 
  set inccommand=split
  set undodir=~/.vimundo
else
  set clipboard=unnamed
  set fillchars+=vert:\│
  set undodir=~/.vim/vimundo
endif

command! -nargs=* Profile call s:command_profile('<args>')
function! s:command_profile(section) abort
  profile start ~/profile.txt
  profile func *
  execute printf('profile file %s', empty(a:section) ? '*' : a:section)
  if jetpack#tap('plenary.nvim')
    lua require('plenary.profile').start(vim.fn.expand('~/profile.lua.txt'))
  endif
endfunction

nnoremap <expr> , reg_recording() == '' ? 'qq' : 'q'
nnoremap ! @q
xnoremap ! <Esc><Cmd>call <SID>visual_macro()<CR>
function! s:visual_macro() abort
  for l:l in range(getpos("'>")[1], getpos("'<")[1], -1)
    call cursor(l:l, 1)
    normal! @q
  endfor
endfunction

command! DeleteFile call s:command_delete_file()
function! s:command_delete_file() abort
  let l:bufname = expand('%:p')
  if filereadable(l:bufname)
    call delete(l:bufname)
    e!
  endif
endfunction

let mapleader="\<Space>"
nmap ; :
vmap ; :
xmap ; :
nnoremap = ^
vnoremap = ^
nnoremap + =
vnoremap + =
nnoremap @ q
nnoremap j gj
nnoremap k gk
nnoremap < <<<Esc>
nnoremap > >><Esc>
vnoremap < <<<Esc>
vnoremap > >><Esc>
nnoremap <Leader><Esc> <Cmd>call searchx#clear()<CR><Cmd>QuickhlManualReset<CR><Cmd>nohlsearch<CR><Cmd>redraw!<CR>

nnoremap q :<C-u>q<CR>
nnoremap Q :<C-u>qa!<CR>
nnoremap <Leader>t :<C-u>tabclose<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap * *N
nnoremap gj J
nnoremap G Gzz

nnoremap H 20h
nnoremap J 10j
nnoremap K 10k
nnoremap L 20l
nnoremap zk 5H
nnoremap zj 5L
xnoremap H 20h
xnoremap J 10j
xnoremap K 10k
xnoremap L 20l
xnoremap zk 5H
xnoremap zj 5L

nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>L :<C-u>tabnext<CR>
nnoremap <Leader>H :<C-u>tabprev<CR>
nnoremap <C-h> <C-o>0zz
nnoremap <C-l> <C-i>0zz
inoremap <C-h> <Left>
inoremap <C-l> <Right>
nmap <Tab> %
xmap <Tab> %

noremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'
noremap <expr> <Leader>: input('key: ')

noremap <F8> <Nop>
noremap <F9> <Nop>
noremap <F10> <Nop>
noremap <S-F8> <Nop>
noremap <S-F9> <Nop>
noremap <S-F10> <Nop>

nnoremap <Leader>*  *:<C-u>%s/<C-r>///g<C-f><Left><Left>
xnoremap <Leader>*  y:<C-u>%s/<C-r>"//g<C-f><Left><Left>
xnoremap <expr><CR> printf(':s/%s//g<C-f><Left><Left>', expand('<cword>'))

nnoremap <F5> :<C-u>call vimrc#detect_cwd()<CR>

try
  colorscheme nightfly
catch /.*/
  colorscheme ron
endtry

if jetpack#tap('vim-eft')
  let g:eft_index_function = get(g:, 'eft_index_function', {
  \   'head': function('eft#index#head'),
  \   'tail': function('eft#index#tail'),
  \   'space': function('eft#index#space'),
  \   'symbol': function('eft#index#symbol'),
  \ })

  nmap f <Plug>(eft-f-repeatable)
  xmap f <Plug>(eft-f-repeatable)
  omap f <Plug>(eft-f-repeatable)

  nmap t <Plug>(eft-t-repeatable)
  xmap t <Plug>(eft-t-repeatable)
  omap t <Plug>(eft-t-repeatable)

  nmap F <Plug>(eft-F-repeatable)
  xmap F <Plug>(eft-F-repeatable)
  omap F <Plug>(eft-F-repeatable)

  nmap T <Plug>(eft-T-repeatable)
  xmap T <Plug>(eft-T-repeatable)
  omap T <Plug>(eft-T-repeatable)
endif

if s:config.pairs ==# 'minx' && jetpack#tap('vim-minx')
  let s:pairs = { '(': ')', '[': ']', '{': '}', '<': '>' }
  let s:quotes = { '"': '"', "'": "'", '`': '`' }

  " Close.
  for [s:o, s:c] in items(extend(copy(s:pairs), s:quotes))
    call minx#add(s:o, s:o .. s:c .. '<Left>')
  endfor

  " Leave.
  for [s:o, s:c] in items(extend(copy(s:pairs), s:quotes))
    call minx#add('<Tab>', {
    \   'at': '\%#\s*' .. minx#u#e(s:c),
    \   'keys': [minx#x#search(minx#u#e(s:c) .. '\zs')],
    \ })
  endfor
  call minx#add('<Tab>', {
  \   'at': '\%#\%(;\|`\)',
  \   'keys': '<Right>',
  \ })

  " Through.
  for [s:o, s:c] in items(s:pairs)
    call minx#add('<Tab>', {
    \   'at': '\%#' .. minx#u#e(s:o),
    \   'keys': ['<Right>', minx#x#searchpair(minx#u#e(s:o), '', minx#u#e(s:c)), '<Right>']
    \ })
  endfor

  " Space.
  for [s:o, s:c] in items(extend(copy(s:pairs), s:quotes))
    call minx#add('<Space>', {
    \   'at': minx#u#e(s:o) .. '\s*\%#',
    \   'keys': ['<Space>', minx#x#mark('cursor'), minx#x#search(minx#u#e(s:o), 'ncb'), '<Right>', minx#x#searchpair(minx#u#e(s:o), '', minx#u#e(s:c)), '<Space>', minx#x#back('cursor')]
    \ })
  endfor

  " Remove.
  for [s:o, s:c] in items(extend(copy(s:pairs), s:quotes))
    call minx#add('<BS>', {
    \   'at': minx#u#e(s:o) ..  '\s*\%#\s*' .. minx#u#e(s:c),
    \   'keys': '<BS><Del>'
    \ })
  endfor

  " Enter.
  for [s:o, s:c] in items(copy(s:pairs))
    call minx#add('<CR>', {
    \   'at': minx#u#e(s:o) ..  '\%#' .. minx#u#e(s:c),
    \   'keys': [minx#x#enterpair()]
    \ })
  endfor
  call minx#add('<C-j>', {
  \   'keys': [minx#x#search('$'), { 'keys': '<CR>', 'noremap': v:false }],
  \ })
  call minx#add('<CR>', {
  \   'priority': -1,
  \   'at': '<\w\+\%(\s\+.\{-}\)\?>\%#$',
  \   'keys': ['</', minx#x#capture('<\(\w\+\)\%(\s\+.\{-}\)\?></\%#'), '>', minx#x#search('<\w\+\%(\s\+.\{-}\)\?>\zs</\w\+>\%#'), minx#x#enterpair()]
  \ })
  call minx#add('<CR>', {
  \   'at': '>\%#<',
  \   'keys': [minx#x#enterpair()]
  \ })

  " Wrap contents.
  for [s:o, s:c] in items(s:pairs)
    " quotes.
    for [s:target_o, s:target_c] in items(s:quotes)
      call minx#add(s:c, {
      \   'priority': 3,
      \   'at': '\%#' .. minx#u#e(s:c) .. '\s*\zs' .. minx#u#e(s:target_o),
      \   'keys': ['<Del>', minx#x#search(minx#u#e(s:target_o) .. '\zs'), minx#x#search('\\\@<!' .. minx#u#e(s:target_c) .. '\zs'), s:c, '<Left>']
      \ })
    endfor

    " pairs.
    for [s:target_o, s:target_c] in items(s:pairs)
      call minx#add(s:c, {
      \   'priority': 2,
      \   'at': '\%#' .. minx#u#e(s:c) .. '\s*[^[:blank:]]*\zs' .. minx#u#e(s:target_o),
      \   'keys': ['<Del>', minx#x#search(minx#u#e(s:target_o) .. '\zs'), minx#x#searchpair(minx#u#e(s:target_o), '', minx#u#e(s:target_c)), '<Right>', s:c, '<Left>']
      \ })
    endfor

    " keywords.
    call minx#add(s:c, {
    \   'priority': 1,
    \   'at': '\%#' .. minx#u#e(s:c),
    \   'keys': ['<Del>', minx#x#token(), s:c, '<Left>']
    \ })
  endfor
  call minx#add('<C-k>', {
  \   'keys': [{ -> minx#u#next_syntax_group() }]
  \ })
endif

if s:config.pairs ==# 'lexima' && jetpack#tap('lexima.vim')
  let g:lexima_accept_pum_with_enter = v:false
  let g:lexima_no_default_rules = v:true
  call lexima#set_default_rules()

  call lexima#add_rule({ 'char': '<', 'input_after': '>' })
  call lexima#add_rule({ 'char': '>', 'at': '<\%#>', 'leave': 1 })
  call lexima#add_rule({ 'char': '<BS>', 'at': '<\%#>', 'delete': 1 })
  call lexima#add_rule({ 'char': '<BS>', 'at': '< \%# >', 'delete': 1 })
  call lexima#add_rule({ 'char': '<Space>', 'at': '<\%#>', 'input_after': '<Space>' })
  call lexima#add_rule({ 'char': '<CR>', 'at': '>\%#<', 'input': '<CR><Up><End><CR>' })

  call lexima#add_rule({ 'char': '<Tab>', 'at': '\%#\s*)',   'input': '<Left><C-o>f)<Right>' })
  call lexima#add_rule({ 'char': '<Tab>', 'at': '\%#\s*\}',  'input': '<Left><C-o>f}<Right>' })
  call lexima#add_rule({ 'char': '<Tab>', 'at': '\%#\s*\]',  'input': '<Left><C-o>f]<Right>' })
  call lexima#add_rule({ 'char': '<Tab>', 'at': '\%#\s*>',   'input': '<Left><C-o>f><Right>' })
  call lexima#add_rule({ 'char': '<Tab>', 'at': '\%#\s*`',   'input': '<Left><C-o>f`<Right>' })
  call lexima#add_rule({ 'char': '<Tab>', 'at': '\%#\s*"',   'input': '<Left><C-o>f"<Right>' })
  call lexima#add_rule({ 'char': '<Tab>', 'at': '\%#\s*' . "'", 'input': '<Left><C-o>f' . "'" . '<Right>' })
endif

if jetpack#tap('vim-searchx')
  nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
  nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
  xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
  xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>

  nnoremap n <Cmd>call searchx#next()<CR>
  nnoremap N <Cmd>call searchx#prev()<CR>
  cnoremap <C-j> <Cmd>call searchx#next()<CR>
  cnoremap <C-k> <Cmd>call searchx#prev()<CR>

  let g:searchx = {}
  let g:searchx.auto_accept = v:true
  let g:searchx.scrolloff = float2nr(&lines * 0.2)
  let g:searchx.scrolltime = 300
  function g:searchx.convert(input) abort
    if a:input !~# '\k'
      return '\V' .. escape(a:input, '\')
    endif

    let l:input = a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
    if l:input[strlen(l:input) - 1] ==# '/'
      let l:input = l:input[0 : strlen(l:input) - 2] .. '\zs'
    endif
    return l:input
  endfunction
endif

if jetpack#tap('vim-sandwich')
  let g:sandwich#magicchar#f#patterns = [{
  \   'header' : '\<\%(\h\k*\%(\.\|::\)\)*\h\k*',
  \   'bra'    : '(',
  \   'ket'    : ')',
  \   'footer' : '',
  \ }]
endif

if jetpack#tap('vim-quickhl')
  nmap @ <Plug>(quickhl-manual-this)

  let g:quickhl_manual_keywords = [
  \   { 'pattern': '\<\(TODO\|FIXME\|NOTE\|INFO\)\>', 'regexp': 1 },
  \ ]
endif

if s:config.type ==# 'nvim' && jetpack#tap('nvim-treesitter')
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
    indent = {
      enable = false,
    },
  }
EOF
endif

if jetpack#tap('vim-operator-user')
  if jetpack#tap('vim-operator-replace')
    nmap r <Plug>(operator-replace)
    xmap r <Plug>(operator-replace)
  endif
endif

if jetpack#tap('vim-swap')
  omap i, <Plug>(swap-textobject-i)
  xmap i, <Plug>(swap-textobject-i)
  omap a, <Plug>(swap-textobject-a)
  xmap a, <Plug>(swap-textobject-a)
endif

if jetpack#tap('vim-asterisk')
  let g:asterisk#keeppos = 1
  map * <Plug>(asterisk-gz*)
endif

if jetpack#tap('vim-quickrun')
  let g:quickrun_no_default_key_mappings = 1
  nnoremap <Leader><Leader>r :<C-u>QuickRun<CR>
endif

if jetpack#tap('open-browser.vim')
  nmap <Leader><Leader><CR> <Plug>(openbrowser-smart-search)
endif

if jetpack#tap('vim-gindent')
  let g:gindent = {}
  let g:gindent.enabled = { -> index(['html', 'yaml'], &filetype) == -1 }
endif

if jetpack#tap('vim-candle')
  " project files
  nnoremap <silent><F3> :<C-u>call candle#start({
  \   'file': {
  \     'root_path': vimrc#get_cwd(),
  \     'ignore_patterns': vimrc#ignore_globs(),
  \   }
  \ })<CR>

  " mru files
  nnoremap <silent><BS> :<C-u>call candle#start({
  \   'mru_file': {
  \     'ignore_patterns': map(
  \       range(1, tabpagewinnr(tabpagenr(), '$')),
  \       { i, winnr -> fnamemodify(bufname(winbufnr(winnr)), ':p') }
  \     ) + ['COMMIT_EDITMSG']
  \   },
  \ })<CR>

  " grep
  nnoremap <silent>gr :<C-u>call candle#start({
  \   'grep': {
  \     'root_path': vimrc#get_cwd(),
  \     'pattern': input('PATTERN: '),
  \     'command': [
  \       'rg',
  \       '-i',
  \       '--vimgrep',
  \       '--no-heading',
  \       '--no-column',
  \     ] + map(copy(vimrc#ignore_globs()), { _, v -> printf('--glob=!%s', v) }) + [
  \       '-e',
  \       '%PATTERN%',
  \       '%ROOT_PATH%',
  \     ]
  \   }
  \ })<CR>

  " memo
  nnoremap <silent><Leader>m :<C-u>call candle#start({
  \   'file': {
  \     'root_path': expand('~/.memo'),
  \     'sort_by': 'mtime',
  \   }
  \ })<CR>

  " menu
  nnoremap <silent><Leader>0 :<C-u>call candle#start({
  \   'item': [{
  \     'id': 1,
  \     'title': 'jetpack#check_update',
  \     'command': 'call jetpack#check_update(v:true)'
  \   }],
  \ }, {
  \   'action': {
  \     'default': { candle -> [
  \       execute('quit'),
  \       win_gotoid(candle.prev_winid),
  \       execute(candle.get_action_items()[0].command)
  \     ] }
  \   },
  \ })<CR>

  command! Modified call s:command_modified()
  function! s:command_modified() abort
    call candle#start({
    \   'item': map(filter(nvim_list_bufs(), 'getbufvar(v:val, "&modified")'), { id, buf -> {
    \     'id': buf,
    \     'title': nvim_buf_get_name(buf),
    \     'filename': nvim_buf_get_name(buf)
    \   }}),
    \ }, {
    \   'action': {
    \     'default': 'edit'
    \   }
    \ })
  endfunction

  autocmd! vimrc User candle#initialize call s:on_candle_initialize()
  function! s:on_candle_initialize() abort
    "
    " edit/split/vsplit
    "
    function! s:open_invoke(command, candle) abort
      let l:curr_winid = win_getid()
      call a:candle.close()
      let l:next_winid = l:curr_winid == a:candle.winid ? a:candle.prev_winid : l:curr_winid
      let l:item = a:candle.get_action_items()[0]
      call vimrc#open(a:command, l:item, win_id2win(l:next_winid))
    endfunction
    call candle#action#register({
    \   'name': 'edit',
    \   'accept': function('candle#action#location#accept_single'),
    \   'invoke': function('s:open_invoke', ['edit']),
    \ })
    call candle#action#register({
    \   'name': 'split',
    \   'accept': function('candle#action#location#accept_single'),
    \   'invoke': function('s:open_invoke', ['split']),
    \ })
    call candle#action#register({
    \   'name': 'vsplit',
    \   'accept': function('candle#action#location#accept_single'),
    \   'invoke': function('s:open_invoke', ['vsplit']),
    \ })

    "
    " qfreplace
    "
    function! s:qfreplace_invoke(candle) abort
      call setqflist(a:candle.get_action_items())
      Qfreplace split
      resize 12
      call a:candle.close()
    endfunction
    call candle#action#register({
    \   'name': 'qfreplace',
    \   'accept': function('candle#action#common#expect_keys_multiple', [['filename', 'lnum', 'text']]),
    \   'invoke': function('s:qfreplace_invoke'),
    \ })

    "
    " new
    "
    function! s:new_invoke(candle) abort
      let l:item = a:candle.get_action_items()[0]
      let l:title = input('title: ')
      call writefile(
      \   [printf('# %s', l:title), ''],
      \   printf('%s/%s.md', fnamemodify(l:item.filename, ':p:h'), l:title)
      \ )
      call a:candle.start()
    endfunction
    call candle#action#register({
    \   'name': 'new',
    \   'accept': function('candle#action#location#accept_single'),
    \   'invoke': function('s:new_invoke'),
    \ })
  endfunction

  nnoremap <silent> <Leader>; :<C-u>call candle#mapping#toggle()<CR>
  nnoremap <silent> <Leader>n :<C-u>call candle#mapping#action_next('default')<CR>
  nnoremap <silent> <Leader>p :<C-u>call candle#mapping#action_prev('default')<CR>
         
  autocmd! vimrc User candle#start call s:on_candle_start()
  function! s:on_candle_start()
    nnoremap <silent><buffer> k     :<C-u>call candle#mapping#cursor_move(-1)<CR>
    nnoremap <silent><buffer> j     :<C-u>call candle#mapping#cursor_move(1)<CR>
    nnoremap <silent><buffer> K     :<C-u>call candle#mapping#cursor_move(-10)<CR>
    nnoremap <silent><buffer> J     :<C-u>call candle#mapping#cursor_move(10)<CR>
    nnoremap <silent><buffer> gg    :<C-u>call candle#mapping#cursor_top()<CR>
    nnoremap <silent><buffer> G     :<C-u>call candle#mapping#cursor_bottom()<CR>
    nnoremap <silent><buffer> i     :<C-u>call candle#mapping#input_open()<CR>
    nnoremap <silent><buffer> a     :<C-u>call candle#mapping#input_open()<CR>
    nnoremap <silent><buffer> @     :<C-u>call candle#mapping#toggle_select()<CR>
    nnoremap <silent><buffer> *     :<C-u>call candle#mapping#toggle_select_all()<CR>
    nnoremap <silent><buffer> p     :<C-u>call candle#mapping#toggle_preview()<CR>
    nnoremap <silent><buffer> <Tab> :<C-u>call candle#mapping#choose_action()<CR>
    nnoremap <silent><buffer> <C-l> :<C-u>call candle#mapping#restart()<CR>

    nnoremap <silent><buffer> <CR>  :<C-u>call candle#mapping#action('default')<CR>
    nnoremap <silent><buffer> s     :<C-u>call candle#mapping#action('split')<CR>
    nnoremap <silent><buffer> v     :<C-u>call candle#mapping#action('vsplit')<CR>
    nnoremap <silent><buffer> d     :<C-u>call candle#mapping#action('delete')<CR>
    nnoremap <silent><buffer> N     :<C-u>call candle#mapping#action('new')<CR>
  endfunction

  autocmd! vimrc User candle#input#start call s:on_candle_input_start()
  function! s:on_candle_input_start()
    cnoremap <silent><buffer> <Tab>     <Esc>:<C-u>call candle#mapping#choose_action()<CR>
    cnoremap <silent><buffer> <C-y>     <Esc>:<C-u>call candle#mapping#action('default')<CR>
    cnoremap <silent><buffer> <C-Space> <Esc>:<C-u>call candle#mapping#action('default')<CR>
    cnoremap <silent><buffer> <C-p>     <Esc>:<C-u>call candle#mapping#cursor_move(-1) \| call candle#mapping#input_open()<CR>
    cnoremap <silent><buffer> <C-n>     <Esc>:<C-u>call candle#mapping#cursor_move(+1) \| call candle#mapping#input_open()<CR>
  endfunction
endif

if jetpack#tap('vim-matchup')
  let g:matchup_matchparen_enabled = 0
  let g:matchup_matchparen_fallback = 0
  let g:matchup_matchparen_offscreen = {}
endif

if jetpack#tap('vim-vsnip')
  let g:vsnip_namespace = 'snip_'
  imap <silent><expr> <Tab> vsnip#available(1)    ? '<Plug>(vsnip-expand-or-jump)' : minx#expand('<LT>Tab>')
  smap <silent><expr> <Tab> vsnip#jumpable(1)     ? '<Plug>(vsnip-jump-next)'      : minx#expand('<LT>Tab>')
  imap <silent><expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : minx#expand('<LT>S-Tab>')
  smap <silent><expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : minx#expand('<LT>S-Tab>')
endif

if jetpack#tap('copilot.vim')
  let g:copilot_no_tab_map = v:true
  imap <expr> <Plug>(vimrc:dummy-copilot-tab) copilot#Accept("\<Tab>")
endif

if s:config.type ==# 'nvim' && jetpack#tap('nvim-cmp')
" Setup global configuration
lua <<EOF
  local lspkind = require'lspkind'

  local cmp = require'cmp'
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end
    },
    window = {
      completion = {
        -- border = 'single',
      },
      documentation = {
        -- border = 'single',
      },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu', },
      format = require("lspkind").cmp_format({
        with_text = false,
      })
    },
    mapping = {
      ['<C-o>'] = cmp.mapping(function(fallback)
        local fallback_key = vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
        local resolved_key = vim.fn['copilot#Accept'](fallback)
        if fallback_key == resolved_key then
          cmp.confirm({ select = true })
        else
          vim.api.nvim_feedkeys(resolved_key, 'n', true)
        end
      end),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
      ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp_signature_help' },
    }, {
      { name = 'path' },
    }, {
      { name = 'nvim_lsp' },
    }, {
      { name = 'calc' },
      { name = 'vsnip' },
      { name = 'emoji' },
    }, {
      { name = 'buffer' },
    })
  }
  cmp.setup.filetype('gitcommit', {
    sources = require('cmp').config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })
  require('cmp_git').setup({})

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'nvim_lsp_document_symbol' },
      { name = 'buffer' },
    },
  })
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })
EOF
else
  let g:loaded_cmp = v:true
end
                    
if jetpack#tap('deol.nvim')
  let g:deol#prompt_pattern = '.\{-}\$'
  let g:deol#enable_dir_changed = 0

  autocmd! vimrc FileType deol call s:setup_deol()
  function! s:setup_deol()
    setlocal nobuflisted
    nnoremap <buffer><F10> :<C-u>tabnew \| call deol#start(printf('-cwd=%s', vimrc#get_buffer_path()))<CR>
  endfunction
endif

if jetpack#tap('fern.vim')
  let g:fern#renderer = 'nerdfont'
  let g:fern#disable_default_mappings = v:true
  let g:fern#disable_auto_buffer_delete = 1
  let g:fern#drawer_width = 40
  let g:fern#disable_viewer_spinner = 1
  let g:fern#disable_drawer_auto_resize = 1
  let g:fern#disable_drawer_auto_restore_focus = 1
  let g:fern#disable_drawer_auto_winfixwidth = 1
  let g:fern#disable_drawer_hover_popup = 0

  function! s:fern_open(command, helper) abort
    let l:node = a:helper.sync.get_cursor_node()
    call vimrc#open(a:command, {
    \   'filename': l:node._path,
    \ })
  endfunction
  call fern#mapping#call_function#add('edit', function('s:fern_open', ['edit']))
  call fern#mapping#call_function#add('split', function('s:fern_open', ['split']))
  call fern#mapping#call_function#add('vsplit', function('s:fern_open', ['vsplit']))

  autocmd! vimrc FileType fern call s:setup_fern()
  function! s:setup_fern() abort
    let &l:statusline = '%{getline(1)}'

    call glyph_palette#apply()

    nnoremap <silent><nowait><buffer>H           :<C-u>call FernTerminal()<CR>
    nnoremap <silent><nowait><buffer><Tab>       :<C-u>call FernSuitableMove()<CR>
    nnoremap <silent><nowait><buffer><F5>        :<C-u>call vimrc#detect_cwd()<CR>

    nmap <silent><nowait><buffer>h               <Plug>(fern-action-collapse-or-leave)
    nmap <silent><nowait><buffer>l               <Plug>(fern-action-expand)
    nmap <silent><nowait><buffer>K               <Plug>(fern-action-new-dir)
    nmap <silent><nowait><buffer>N               <Plug>(fern-action-new-file)
    nmap <silent><nowait><buffer>r               <Plug>(fern-action-rename)
    nmap <silent><nowait><buffer>D               <Plug>(fern-action-remove)
    nmap <silent><nowait><buffer>c               <Plug>(fern-action-clipboard-copy)
    nmap <silent><nowait><buffer>m               <Plug>(fern-action-clipboard-move)
    nmap <silent><nowait><buffer>p               <Plug>(fern-action-clipboard-paste)
    nmap <silent><nowait><buffer><expr><CR>      fern#smart#leaf('<Plug>(fern-action-call-function:edit)', '<Plug>(fern-action-enter)')
    nmap <silent><nowait><buffer>s               <Plug>(fern-action-call-function:split)
    nmap <silent><nowait><buffer>v               <Plug>(fern-action-call-function:vsplit)
    nmap <silent><nowait><buffer>@               <Plug>(fern-action-mark:toggle)j
    nmap <silent><nowait><buffer>,               <Plug>(fern-action-hidden:toggle)
    nmap <silent><nowait><buffer><C-l>           <Plug>(fern-action-reload)
    nmap <silent><nowait><buffer>~               :<C-u>Fern ~<CR>
    nmap <silent><nowait><buffer>\               :<C-u>Fern /<CR>
    nmap <silent><nowait><buffer><Leader><CR>    :<C-u>new \| Fern .<CR>
    nmap <silent><nowait><buffer>x              <Plug>(fern-action-open:system)

    nmap <silent> <buffer> P     <Plug>(fern-action-preview:auto:toggle)
    nmap <silent> <buffer> <C-f> <Plug>(fern-action-preview:scroll:down:half)
    nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:up:half)

    nnoremap <silent><nowait><buffer><BS>        :<C-u>call candle#start({
    \   'mru_dir': {},
    \ }, {
    \   'action': {
    \     'default': { candle -> [
    \       execute('quit'),
    \       win_gotoid(candle.prev_winid),
    \       candle#source#mru_dir#source#touch(candle.get_action_items()[0].filename),
    \       execute(printf('Fern %s', candle.get_action_items()[0].filename))
    \     ] }
    \   }
    \ })<CR>
  endfunction

  nnoremap <F2> :<C-u>call FernStart()<CR>
  function! FernStart()
    if &filetype ==# 'fern'
      return
    endif

    let path = fnameescape(expand('%:p:h'))
    let winnrs = filter(range(1, tabpagewinnr(tabpagenr(), '$')), { i, wnr -> getbufvar(winbufnr(wnr), '&filetype') ==# 'fern' })
    if len(winnrs) > 0
      let choise = choosewin#start(winnrs, { 'auto_choose': 1, 'blink_on_land': 0, 'noop': 1 })
      if len(choise) > 0
        execute printf('%swincmd w', choise[1])
        execute printf('Fern %s -drawer', path)
      endif
    else
      execute printf('Fern %s -drawer', path)
    endif
  endfunction

  function! FernSuitableMove()
    let current = b:fern.root._path
    let cwd = vimrc#path(vimrc#get_cwd())
    let root = vimrc#path(vimrc#get_project_root(current))

    if root ==# current
      let root = vimrc#path(vimrc#get_project_root(fnamemodify(root, ':p:h:h')))
    endif

    if root !=# ''
      execute printf('Fern %s -drawer', root)
    else
      execute printf('Fern %s -drawer', cwd)
    endif
  endfunction

  function! FernTerminal()
    let l:cwd = b:fern.root._path
    if !exists('t:deol') || bufwinnr(get(t:deol, 'bufnr', -1)) == -1
      topleft 12new
      set winfixheight
      call deol#start(printf('-cwd=%s', l:cwd))
      execute printf('lcd %s', l:cwd)
    else
      let t:deol['cwd'] = ''
      call deol#start(printf('-cwd=%s', l:cwd))
      execute printf('lcd %s', l:cwd)
    endif
  endfunction
endif

if jetpack#tap('lightline.vim')
  let g:lightline = {}
  let g:lightline.colorscheme = 'nightfly'
  let g:lightline.enable = {}
  let g:lightline.enable.statusline = 1
  let g:lightline.enable.tabline = 1

  let g:lightline.active = {}
  let g:lightline.active.left = [['mode', 'readonly', 'modified'], ['filename']]
  let g:lightline.active.right = [['lineinfo', 'percent', 'filetype']]
  let g:lightline.inactive = g:lightline.active
  let g:lightline.separator = { 'left': '', 'right': '' }
  let g:lightline.subseparator = { 'left': '', 'right': '' }

  let g:lightline.tabline = {}
  let g:lightline.tabline.left = [['tabs']]
  let g:lightline.tabline_separator = { 'left': '', 'right': '' }
  let g:lightline.tabline_subseparator = { 'left': '', 'right': '' }

  let g:lightline.component_function = {}
endif

if jetpack#tap('vim-gitto')
  let g:gitto#config = {}
  let g:gitto#config.get_buffer_path = function('vimrc#get_buffer_path')
endif

if jetpack#tap('denite.nvim')
  autocmd! vimrc FileType denite call s:setup_denite()
  function! s:setup_denite()
    nnoremap <silent><buffer><expr>i     denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr>a     denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr>q     denite#do_map('quit')
    nnoremap <silent><buffer><expr><Esc> denite#do_map('quit')
    nnoremap <silent><buffer><expr><Tab> denite#do_map('choose_action')
    nnoremap <silent><buffer><expr><C-l> denite#do_map('redraw')
    nnoremap <silent><buffer><expr><C-h> denite#do_map('restore_sources')
    nnoremap <silent><buffer><expr><CR>  denite#do_map('do_action')
    nnoremap <silent><buffer><expr>o     denite#do_map('do_action', 'edit')
    nnoremap <silent><buffer><expr>v     denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr>s     denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr>n     denite#do_map('do_action', 'new')
    nnoremap <silent><buffer><expr>d     denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr>p     denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr>*     denite#do_map('toggle_select_all')
    nnoremap <silent><buffer><expr>@     denite#do_map('toggle_select') . 'j'
  endfunction

  autocmd! vimrc FileType denite-filter call s:setup_denite_filter()
  function! s:setup_denite_filter()
    imap <silent><buffer><Esc> <Plug>(denite_filter_quit)
  endfunction

  " filter custom
  call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', vimrc#ignore_globs())
  call denite#custom#source('file/rec,file/old', 'converters', ['converter/abbr_word'])

  " sorter
  call denite#custom#source('file/old', 'sorters', [])
  call denite#custom#source('_', 'sorters', ['sorter/sublime'])

  " matchers
  call denite#custom#source('file/old', 'matchers', ['matcher/ignore_current_buffer', 'matcher/substring'])
  call denite#custom#source('_', 'matchers', ['matcher/substring'])

  " option.
  call denite#custom#option('_', 'winheight', 10)
  call denite#custom#option('_', 'filter_updatetime', 500)
  call denite#custom#option('_', 'filter_split_direction', 'floating')
  call denite#custom#option('_', 'highlight_matched_char', 'None')
  call denite#custom#option('_', 'highlight_matched_range', 'None')

  " edit action.
  function! s:denite_edit_action(context)
    for target in a:context['targets']
      call vimrc#open('edit', {
      \   'filename': target['action__path'],
      \   'lnum': get(target, 'action__line', -1),
      \   'col': get(target, 'action__col', -1)
      \ })
    endfor
  endfunction
  call denite#custom#action('openable,file,buffer,gitto/status', 'edit', function('s:denite_edit_action'), { 'is_quit': v:true, 'is_redraw': v:false })

  " split action.
  function! s:denite_split_action(context)
    for target in a:context['targets']
      call vimrc#open('new', {
      \   'filename': target['action__path'],
      \   'lnum': get(target, 'action__line', -1),
      \   'col': get(target, 'action__col', -1)
      \ })
    endfor
  endfunction
  call denite#custom#action('openable,file,buffer,gitto/status', 'split', function('s:denite_split_action'), { 'is_quit': v:true, 'is_redraw': v:false })

  " vsplit action.
  function! s:denite_vsplit_action(context)
    for target in a:context['targets']
      call vimrc#open('vnew', {
      \   'filename': target['action__path'],
      \   'lnum': get(target, 'action__line', -1),
      \   'col': get(target, 'action__col', -1)
      \ })
    endfor
  endfunction
  call denite#custom#action('openable,file,buffer,gitto/status', 'vsplit', function('s:denite_vsplit_action'), { 'is_quit': v:true, 'is_redraw': v:false })

  if jetpack#tap('vim-qfreplace')
    function! s:denite_qfreplace_action(context)
      let qflist = []
      for target in a:context['targets']
        if !has_key(target, 'action__path') | continue | endif
        if !has_key(target, 'action__line') | continue | endif
        if !has_key(target, 'action__text') | continue | endif

        call add(qflist, {
              \ 'filename': target['action__path'],
              \ 'lnum': target['action__line'],
              \ 'text': target['action__text']
              \ })
      endfor
      call setqflist(qflist)
      call qfreplace#start('')
    endfunction
    call denite#custom#action('file', 'qfreplace', function('s:denite_qfreplace_action'))
  endif

  " delete action
  if jetpack#tap('vim-denite-gitto')
    function! s:denite_delete_action(context)
      if index(['y', 'ye', 'yes'], input('delete?(yes/no): ')) >= 0
        for target in a:context['targets']
          call delete(target['action__path'], 'rf')
        endfor
      endif
    endfunction
    call denite#custom#action('gitto/status', 'delete', function('s:denite_delete_action'), { 'is_quit': v:false, 'is_redraw': v:true })
  endif
  if jetpack#tap('vim-gitto') && jetpack#tap('vim-denite-gitto')
    nnoremap <Leader><BS> :<C-u>DeniteGitto gitto<CR>
  endif
endif

autocmd! vimrc FileType * call s:on_file_type()
function! s:on_file_type()
  for [k, v] in items({
  \   '.*\.d\.ts$': { 'filetype': 'typescript.dts' },
  \   '.*\.log$': { 'filetype': 'text', 'tabstop': 8 },
  \   '.*\.tpl$': { 'filetype': 'html' },
  \   '.*\.vim$': { 'filetype': 'vim' },
  \   '.*\.zig$': { 'filetype': 'zig' },
  \   '.*\.purs$': { 'filetype': 'purescript' },
  \   '.*\.\%(s\)\?css$': { 'iskeyword': '@,48-57,_,192-255' },
  \ })
    if bufname('%') =~ k
      for [l:name, l:value] in items(v)
        try
          execute printf('setlocal %s=%s', l:name, l:value)
        catch /.*/
        endtry
        break
      endfor
    endif
  endfor

  if exists(':Findent')
    Findent! --no-warnings
  endif

  if jetpack#tap('vim-quickhl')
    QuickhlManualEnable
  endif
endfunction

autocmd! vimrc VimLeave * call s:on_vim_leave()
function! s:on_vim_leave()
lua <<EOF
  if require('jetpack').tap('plenary.nvim') then
    local _, profile = pcall(require, 'plenary.profile')
    if profile then
      profile.stop()
    end
  end
EOF
endfunction

autocmd! vimrc ColorScheme * call s:on_color_scheme()
function! s:on_color_scheme() abort
endfunction
call s:on_color_scheme()

autocmd! vimrc BufRead * call s:on_buf_read()
function! s:on_buf_read()
  if line("'\"") > 0 && line("'\"") <= line('$')
    normal! g`""
    normal! zz
  endif
endfunction

if has('nvim')
  autocmd! vimrc TermOpen term://* call s:on_term_open()
  function! s:on_term_open()
    tnoremap <buffer><silent><Esc> <C-\><C-n>
  endfunction
else
  autocmd! vimrc TerminalOpen * call s:on_term_open()
  function! s:on_term_open()
    tnoremap <buffer><Esc> <C-w>N
  endfunction
endif

autocmd! vimrc BufWinEnter * call s:on_buf_win_enter()
function! s:on_buf_win_enter()
  if &previewwindow
    setlocal wrap
  endif
endfunction

if jetpack#tap('vim-lsp') && s:config.type ==# 'vim'
  " let g:lsp_log_file = '/tmp/lsp.log'
  let g:lsp_diagnostics_float_cursor = 1

  autocmd vimrc User lsp_setup call s:setup_vim_lsp()
  function s:setup_vim_lsp() abort
    call lsp#register_server({
    \   'nam': 'gopls',
    \   'cmd': { -> ['gopls'] },
    \   'allowlist': ['go'],
    \ })
    call lsp#rgister_server({
    \   'name': 'vim-language-server',
    \   'cmd': { -> ['vim-language-server', '--stdio'] },
    \   'allowlist': ['vim'],
    \   'initialization_options': {
    \    'iskeyword': &iskeyword . ',:',
    \    'vimruntime': $VIMRUNTIME,
    \    'runtimepath': &runtimepath,
    \    'diagnostic': {
    \      'enable': v:true,
    \    },
    \    'suggest': {
    \      'fromVimruntime': v:true,
    \      'fromRuntimepath': v:true,
    \    }
    \  }
    \ })
  endfunction

  autocmd! vimrc User lsp_buffer_enabled call s:lsp_buffer_enabled()
  function! s:lsp_buffer_enabled() abort
    nnoremap <Leader><CR>          :<C-u>LspCodeAction<CR>
    vnoremap <Leader><CR>          :LspCodeAction<CR>
    nnoremap <buffer> gf<CR>       :<C-u>LspDefinition<CR>
    nnoremap <buffer> gfv          :<C-u>vsplit \| LspDefinition<CR>
    nnoremap <buffer> gfs          :<C-u>split \| LspDefinition<CR>
    nnoremap <buffer> <Leader>i    :<C-u>LspHover<CR>
    nnoremap <buffer> <Leader>r    :<C-u>LspRename<CR>
    nnoremap <buffer> <Leader>g    :<C-u>LspReferences<CR>
    nnoremap <buffer> <Leader>f    :<C-u>LspDocumentFormat<CR>
    vnoremap <buffer> <Leader>f    :LspDocumentFormatRange<CR>
  endfunction
endif

if s:config.type ==# 'nvim'
lua <<EOF
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local on_init = function(client)
    client.config.flags = {}
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
      client.config.flags.debounce_text_changes = 200
    end
  end

  require'lspconfig'.gopls.setup {
    capabilities = capabilities,
    on_init = on_init;
    init_options = {
      gofumpt = true,
      usePlaceholders = true,
      semanticTokens = true,
      staticcheck = true,
      experimentalPostfixCompletions = true,
      hoverKind = 'Structured',
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
        fieldalignment = true
      },
      codelenses = {
        gc_details = true,
        tidy = true
      }
    }
  }
  require'lspconfig'.vimls.setup {
    on_init = on_init;
    capabilities = capabilities,
  }
  require'lspconfig'.tsserver.setup {
    on_init = on_init;
    capabilities = capabilities,
    on_attach = function(client)
      client.resolved_capabilities.documentFormattingProvider = false
    end,
  }
  -- require'lspconfig'.denols.setup {
  --   on_init = on_init;
  --   capabilities = capabilities,
  --   init_options = {
  --     suggest = {
  --       autoImports = true,
  --       completeFunctionCalls = true,
  --       names = true,
  --       paths = true,
  --       imports = {
  --         autoDiscover = false,
  --         hosts = {
  --           ['https://deno.land/'] = true,
  --         },
  --       },
  --     },
  --   }
  -- }
  require'lspconfig'.ansiblels.setup{
    on_init = on_init;
    capabilities = capabilities,
  }
  require'lspconfig'.rust_analyzer.setup {
    on_init = on_init;
    capabilities = capabilities,
  }
  require'lspconfig'.intelephense.setup {
    on_init = on_init;
    capabilities = capabilities,
    settings = {
      intelephense = {
        format = {
          braces = 'k&r'
        }
      }
    }
  }
  require'lspconfig'.cssls.setup {
    on_init = on_init;
    capabilities = capabilities,
  }
  require'lspconfig'.html.setup {
    on_init = on_init;
    capabilities = capabilities,
  }
  require'lspconfig'.jsonls.setup {
    on_init = on_init;
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  }
  require'lspconfig'.yamlls.setup {
    on_init = on_init;
    capabilities = capabilities,
    settings = {
      yaml = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  }
  require'lspconfig'.eslint.setup {
    on_init = on_init,
    capabilities = capabilities,
  }
  require'lspconfig'.sumneko_lua.setup {
    on_init = on_init,
    cmd = { vim.fn.expand('~/Develop/Repo/lua-language-server/bin/lua-language-server') },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = {
          globals = { 'vim', 'before_each', 'after_each', 'describe', 'it' },
        },
        workspace = {
          library = vim.tbl_values(vim.g.vimrc.pkg.paths),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }

  -- vim.lsp.set_log_level('DEBUG')

  vim.diagnostic.config({
    virtual_text = false,
  })
  vim.cmd([[
    nnoremap <silent> gf<CR>       <Cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gfv          <Cmd>vsplit<CR><Cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gfs          <Cmd>split<CR><Cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <Leader>i    <Cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <Leader>g    <Cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <Leader>f    <Cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <silent> <Leader>r    <Cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <Leader><CR> <Cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent> <C-k>        <Cmd>lua vim.diagnostic.goto_prev()<CR>
    nnoremap <silent> <C-j>        <Cmd>lua vim.diagnostic.goto_next()<CR>
  ]])

  if require('jetpack').tap('nvim-exp') == 1 then
    require('exp').setup({
      location = {
        window = function()
          local winnrs = vim.fn['vimrc#filter_winnrs'](vim.fn['vimrc#get_special_filetypes']())
          if vim.tbl_contains(winnrs, vim.fn.winnr()) then
            return vim.api.nvim_get_current_win()
          end
          if #winnrs == 1 then
            return vim.fn.win_getid(winnrs[1])
          end
          local winnr = vim.fn['choosewin#start'](winnrs, {
            auto_choose = 1,
            blink_on_land = 0,
            noop = 1
          })
          return vim.fn.win_getid(winnr[2])
        end
      }
    })
    vim.cmd([[
      nnoremap <silent> gf<CR> <Cmd>lua require('exp').goto_definition({ cmd = 'edit' })<CR>
      nnoremap <silent> gfv    <Cmd>lua require('exp').goto_definition({ cmd = 'vsplit' })<CR>
      nnoremap <silent> gfs    <Cmd>lua rqquire('exp').goto_definition({ cmd = 'split' })<CR>
    ]])
  end
EOF
endif
