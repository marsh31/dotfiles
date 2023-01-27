""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NAME:   init.vim
" AUTHOR: marsh
"
" NOTE:
"  TODO: 
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section: @initialize
"
"
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section: @plugin install
"
"
call jetpack#begin(g:vimrc.pkg.plugins)
call jetpack#add('~/.fzf')
call jetpack#add('andymass/vim-matchup')
call jetpack#add('bluz71/vim-nightfly-guicolors')
call jetpack#add('haya14busa/vim-asterisk')
call jetpack#add('hrsh7th/vim-effort-gf')
call jetpack#add('hrsh7th/vim-eft')
call jetpack#add('hrsh7th/vim-gindent')
call jetpack#add('hrsh7th/vim-searchx')
call jetpack#add('hrsh7th/vim-vsnip')
call jetpack#add('itchyny/lightline.vim')
call jetpack#add('junegunn/fzf.vim')
call jetpack#add('junegunn/gv.vim')
call jetpack#add('kana/vim-operator-user')
call jetpack#add('kana/vim-textobj-entire')
call jetpack#add('kana/vim-textobj-line')
call jetpack#add('kana/vim-textobj-user')
call jetpack#add('lambdalisue/fern-bookmark.vim')
call jetpack#add('lambdalisue/fern-git-status.vim')
call jetpack#add('lambdalisue/fern-hijack.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/fern.vim')
" call jetpack#add('lambdalisue/gina.vim') 
call jetpack#add('lambdalisue/glyph-palette.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('lambdalisue/suda.vim')
call jetpack#add('lambdalisue/vim-findent')
call jetpack#add('machakann/vim-sandwich')
call jetpack#add('machakann/vim-swap')
call jetpack#add('mattn/vim-textobj-url')
call jetpack#add('nanotee/luv-vimdocs')
call jetpack#add('sainnhe/everforest')
call jetpack#add('sk1418/QFGrep')
call jetpack#add('t9md/vim-choosewin')
call jetpack#add('t9md/vim-quickhl')
call jetpack#add('tani/vim-jetpack')
call jetpack#add('thinca/vim-qfreplace')
call jetpack#add('thinca/vim-quickrun')
call jetpack#add('thinca/vim-textobj-between')
call jetpack#add('thinca/vim-themis')
call jetpack#add('tweekmonster/helpful.vim')
call jetpack#add('tyru/open-browser.vim')
call jetpack#add('yuki-yano/vim-operator-replace')

call jetpack#add('cohama/lexima.vim')

call jetpack#add('NTBBloodbath/rest.nvim')                                   " editor 
call jetpack#add('antoinemadec/FixCursorHold.nvim')                          " Framework 
call jetpack#add('b0o/SchemaStore.nvim')
call jetpack#add('christianchiarulli/nvcode-color-schemes.vim')              " treesitter 
call jetpack#add('ethanholz/nvim-lastplace')                                 " editor 
call jetpack#add('folke/trouble.nvim')                                       " lsp config 
call jetpack#add('gennaro-tedesco/nvim-jqx')                                 " json 

" call jetpack#add('L3MON4D3/LuaSnip')                                       " Completion 
call jetpack#add('hrsh7th/cmp-buffer')                                       " Completion
call jetpack#add('hrsh7th/cmp-cmdline')                                      " Completion  
call jetpack#add('hrsh7th/cmp-nvim-lsp')                                     " Completion  
call jetpack#add('hrsh7th/cmp-nvim-lua')                                     " Completion 
call jetpack#add('hrsh7th/cmp-path')                                         " Completion 
call jetpack#add('hrsh7th/cmp-vsnip')
call jetpack#add('petertriho/cmp-git')                                       " Completion 
call jetpack#add('hrsh7th/nvim-cmp')                                         " Completion 

call jetpack#add('is0n/jaq-nvim')                                            " test 
call jetpack#add('jose-elias-alvarez/null-ls.nvim')                          " lsp config 
call jetpack#add('kevinhwang91/nvim-bqf')                                    " quickfix 
call jetpack#add('kyazdani42/nvim-web-devicons')                             " Framework 
call jetpack#add('lewis6991/gitsigns.nvim')                                  " git 
call jetpack#add('liuchengxu/vim-which-key')                                 " editor 
call jetpack#add('liuchengxu/vista.vim')                                     " lsp config 
call jetpack#add('mbbill/undotree')                                          " editor 
call jetpack#add('neovim/nvim-lspconfig')                                    " lsp config 
call jetpack#add('notomo/cmdbuf.nvim')                                       " editor 
call jetpack#add('numToStr/Comment.nvim')                                    " Comment 
call jetpack#add('nvim-lua/plenary.nvim')                                    " Framework 
call jetpack#add('nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' })   " treesitter 
call jetpack#add('nvim-treesitter/nvim-treesitter-refactor')                 " treesitter 
call jetpack#add('nvim-treesitter/nvim-treesitter-textobjects')              " treesitter 
call jetpack#add('onsails/lspkind-nvim')                                     " lsp config 
call jetpack#add('p00f/nvim-ts-rainbow')                                     " treesitter 
call jetpack#add('phaazon/hop.nvim')                                         " editor 
call jetpack#add('projekt0n/github-nvim-theme')                              " treesitter 
call jetpack#add('ray-x/lsp_signature.nvim')                                 " lsp config 
call jetpack#add('rmagatti/auto-session')                                    " editor 
call jetpack#add('simeji/winresizer')                                        " editor 
call jetpack#add('sindrets/diffview.nvim')                                   " editor 
call jetpack#add('skanehira/qfopen.vim')                                     " quickfix 
call jetpack#add('stevearc/qf_helper.nvim')                                  " quickfix 
call jetpack#add('tami5/lspsaga.nvim')                                       " lsp config 
call jetpack#add('tanvirtin/vgit.nvim')                                      " git 
call jetpack#add('theHamsta/nvim-treesitter-pairs')                          " treesitter 
call jetpack#add('williamboman/nvim-lsp-installer')                          " lsp config 
call jetpack#end()
"" call jetpack#add('nvim-lualine/lualine.nvim')                                " Statusline  
" call jetpack#add('steelsojka/pears.nvim')    " vs windwp/nvim-autopairs vs cohama/lexima.vim)
" call jetpack#add('ur4ltz/surround.nvim')     " TODO: surround.nvim vs vim-sandwich")
" call jetpack#add('Chiel92/vim-autoformat')   " vs sbdchd/neoformat vs lukas-reineke/format.nvim vs mhartington/formatter.nvim )


let $PATH = $PATH .. ':' .. g:vimrc.pkg.plugins . '/pack/jetpack/opt/_/bin'

for s:name in jetpack#names()
  let g:vimrc.pkg.paths[s:name] = jetpack#get(s:name).path
endfor
" Local plugins. 
for s:p in glob('~/Develop/Vim/*', v:false, v:true, v:false)
  let &runtimepath = escape(s:p, ',') .. ',' .. &runtimepath
  let g:vimrc.pkg.paths[fnamemodify(s:p, ':t')] = fnamemodify(s:p, ':p')
endfor
set runtimepath+=~/.fzf


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section: @basic config
"
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
set nowritebackup
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
set nocursorcolumn
set number
set modeline
set modelines=2
set wildmenu
set wildmode=longest:full
set wildchar=<Tab>
" set wildignorecase
" set wildignore=*.o,*.jpg,*.png,*.pdf,*.so,*.dll,tags
set pumheight=15
set showtabline=2
set cmdheight=1
set list
set noshowmode
set ambiwidth=single
set title
set shortmess+=I
set shortmess+=c
set listchars=tab:>-,trail:^,eol:↲
set background=dark
set splitright
set splitbelow
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
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set completeopt=menu,menuone,noselect
set startofline
set signcolumn=yes:1
set helplang=en
set formatoptions=croq

let g:vim_indent_cont = 0
let g:markdown_fenced_languages = ['ts=typescript']

if has('nvim')
  set wildoptions=pum
  set scrollback=2000
  set clipboard=unnamedplus
  set fillchars+=vert:\│,eob:\ 
  set inccommand=split
  set undodir=~/.local/share/nvim/undos
  set undolevels=1000
  augroup SaveUndoFile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
else
  set clipboard=unnamed
  set fillchars+=vert:\│
  set undodir=~/.vim/vimundo
endif


set foldlevel=10
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldtext=MyFoldText()
function MyFoldText()
  " let line = getline(v:foldstart)
  " return line
  let line = getline(v:foldstart)
  let pattern = '[ ' . substitute(&commentstring, ' *%s', '', 'g') . ']*{{{\d\= *$' " }}}
  let sub = substitute(line, pattern, '', '')
  return sub . " [" . v:foldstart . "-" . v:foldend . "]" 
endfunction

augroup GrepCmd
  autocmd!
  " autocmd QuickFixCmdPost vim,grep,make if len(getqflist()) != 0 | cwindow | endif
  autocmd QuickFixCmdPost vimgrep,grep,grepadd,make if len(getqflist()) != 0 | copen | endif
augroup END


if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l:%c:%m
endif


function! MyTabLine()
    let s = ""
    for i in range(tabpagenr("$"))
        if i + 1 == tabpagenr()
            let s .= "%#TabLineSel#"
        else
            let s .= "%#TabLine#"
        endif
        let s .= "%" . (i + 1) . "T"
        let s .= " %{MyTabLabel(" . (i + 1) . ")} "
    endfor
    let s .= "%#TabLineFill#%T"
    return s
endfunction

function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])
    if name == ""
        let name = "[No Name]"
    endif
    return a:n . "." . name
endfunction
set tabline=%!MyTabLine()


nnoremap <expr> , reg_recording() == '' ? 'qq' : 'q'
nnoremap ! @q
xnoremap ! <Esc><Cmd>call <SID>visual_macro()<CR>
function! s:visual_macro() abort
  for l:l in range(getpos("'>")[1], getpos("'<")[1], -1)
    call cursor(l:l, 1)
    normal! @q
  endfor
endfunction


command! ToggleSearchHighlight setlocal hlsearch!
command! ToggleWrap setlocal wrap!
command! ToggleRelativeNumber setlocal relativenumber!


function! s:grep(word) abort
  cexpr system(printf('%s "%s"', &grepprg, a:word)) | cw
  echo printf('Search "%s"', a:word)
endfunction
command! -nargs=1 Grep       :call <SID>grep(<q-args>)
command! -nargs=1 GrepTab    :tabnew | :silent grep --sort-files <args>
command! -nargs=1 GrepTabNSF :tabnew | :silent grep <args>

command! Tig :tabnew term://tig

command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

function! s:toggleQuickfix() abort
  let nr = winnr('$')
  cwindow
  let nr2 = winnr('$')
  if nr == nr2
    cclose
  endif
endfunction
command! ToggleQuickfix :silent call s:toggleQuickfix()<CR>

" augroup term_open_config; always start in insert mode.
augroup term_open_config
  autocmd!
  autocmd TermOpen * startinsert
augroup END

" command
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>

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


function! s:cmdlineAbbreviation(input, replace) abort
  exec printf("cabbrev <expr> %s (getcmdtype() ==# \":\" && getcmdline() ==# \"%s\") ? \"%s\" : \"%s\"", a:input, a:input, a:replace, a:input)
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section: @keymap config, abbriviation and plugin config
"
"
" NOTE:
"-------------------------------------------------------------------------|
"  Modes     | Nor | Ins | Cmd | Visual | Select | Oper | Term | Lang-Arg |
" [nore]map  |  @  |  -  |  -  |   @    |   @    |  @   |  -   |    -     |
" n[nore]map |  @  |  -  |  -  |   -    |   -    |  -   |  -   |    -     |
" n[orem]ap! |  -  |  @  |  @  |   -    |   -    |  -   |  -   |    -     |
" i[nore]map |  -  |  @  |  -  |   -    |   -    |  -   |  -   |    -     |
" c[nore]map |  -  |  -  |  @  |   -    |   -    |  -   |  -   |    -     |
" v[nore]map |  -  |  -  |  -  |   @    |   @    |  -   |  -   |    -     |
" x[nore]map |  -  |  -  |  -  |   @    |   -    |  -   |  -   |    -     |
" s[nore]map |  -  |  -  |  -  |   -    |   @    |  -   |  -   |    -     |
" o[nore]map |  -  |  -  |  -  |   -    |   -    |  @   |  -   |    -     |
" t[nore]map |  -  |  -  |  -  |   -    |   -    |  -   |  @   |    -     |
" l[nore]map |  -  |  @  |  @  |   -    |   -    |  -   |  -   |    @     |
"-------------------------------------------------------------------------|
let mapleader="\<Space>"
inoremap jj <ESC>
inoremap jk <ESC>

nnoremap j gj
nnoremap k gk


nnoremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'
nnoremap <C-c><C-c> <cmd>nohlsearch<CR>
nnoremap <C-o> <C-o>0zz
nnoremap <C-i> <C-i>0zz
nnoremap <Leader>*  *:<C-u>%s/<C-r>///g<C-f><Left><Left>
xnoremap <Leader>*  y:<C-u>%s/<C-r>"//g<C-f><Left><Left>

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


try
  colorscheme nightfly
catch /.*/
  colorscheme ron
endtry


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@vim-eft
" {{{
if jetpack#tap('vim-eft')
  let g:eft_index_function = get(g:, 'eft_index_function', {
  \   'head': function('eft#index#head'),
  \   'tail': function('eft#index#tail'),
  \   'space': function('eft#index#space'),
  \   'symbol': function('eft#index#symbol'),
  \ })

  nmap ; <Plug>(eft-repeat)
  xmap ; <Plug>(eft-repeat)
  omap ; <Plug>(eft-repeat)

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
" }}}
" EndSection:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@fzf.vim
" {{{
if jetpack#tap('fzf.vim')
  function! s:build_quickfix_list(lines)
    call setreg("+", a:lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action              = { 'ctrl-q': function('s:build_quickfix_list'),
                                  \ 'ctrl-t': 'tab split',
                                  \ 'ctrl-s': 'split',
                                  \ 'ctrl-v': 'vsplit' }
  let g:fzf_buffers_jump        = 1
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
  let g:fzf_layout              = { 'down': '20%' }
  let g:fzf_preview_window      = ['up:40%:hidden', 'ctrl-/']
  let g:fzf_tags_command        = 'ctags -R'

  command! -bang -nargs=? -complete=dir Memo call fzf#vim#files("~/Memo", <bang>0)
endif
" }}}
" EndSection:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@lexima
" {{{
if jetpack#tap('lexima.vim')
  let g:lexima_accept_pum_with_enter = v:false
  let g:lexima_no_default_rules = v:true
  call lexima#set_default_rules()

  call lexima#add_rule({ 'char': '<', 'input_after': '>' })
  call lexima#add_rule({ 'char': '>', 'at': '\%#>', 'leave': 1 })
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
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@vim-searchx
" {{{
if jetpack#tap('vim-searchx')
  nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
  nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
  xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
  xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
  nnoremap n <Cmd>call searchx#next()<CR>
  nnoremap N <Cmd>call searchx#prev()<CR>
  xnoremap n <Cmd>call searchx#next()<CR>
  xnoremap N <Cmd>call searchx#prev()<CR>
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
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@vim-sandwich
" {{{
"
" default key mapping:
"   sa{obj} : add surround
"   sd{obj} : delete surround
"   sr{obj} : replace surround
if jetpack#tap('vim-sandwich')
  let g:sandwich#magicchar#f#patterns = [{
  \   'header' : '\<\%(\h\k*\%(\.\|::\)\)*\h\k*',
  \   'bra'    : '(',
  \   'ket'    : ')',
  \   'footer' : '',
  \ }]
endif
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if jetpack#tap('vim-quickhl')
  nmap @ <Plug>(quickhl-manual-this)

  let g:quickhl_manual_keywords = [
  \   { 'pattern': '\<\(TODO\|FIXME\|NOTE\|INFO\)\>', 'regexp': 1 },
  \ ]
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@treesitter
" {{{
if s:config.type ==# 'nvim' && jetpack#tap('nvim-treesitter')
lua <<EOF
  require('nvim-treesitter.configs').setup {
      ensure_installed = "all",
      highlight = {
          enable = true,
          disable = { "markdown" },
      },


      incremental_selection = {
          enable = true,
          keymaps = {
              init_selection    = "gnn",
              node_incremental  = "grn",
              node_decremental  = "grm",
              scope_incremental = "grc",
          },
      },
      indent = { enable = false },

      refactor = {
          highlight_definitions   = { enable = false },
          highlight_current_scope = { enable = false },
          smart_rename = {
              enable = true,
              keymaps = {
                  smart_rename = "grr",
              },
          },

          navigation = {
              enable = true,
              keymaps = {
                  goto_definition = "gnd",
                  list_definitions = "gnD",
                  list_definitions_toc = "gO",
                  goto_next_usage = "gnu",
                  goto_previous_usage = "gpu",
              },
          },
      },

      textobjects = {
          select = {
              enable = true,
              keymaps = {
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
              },
          },
      },

      rainbow = {
          enable = true,
          extended_mode = true,
      },

      pairs = {
          enable = true,
          disable = {},
      },
  }
EOF
endif
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@vim-operator-user
" SubSection: plugins@vim-textobj-user
" {{{
" kana/vim-operator-user
" yuki-yano/vim-operator-replace
" kana/vim-textobj-user
" kana/vim-textobj-entire
" kana/vim-textobj-line
" mattn/vim-textobj-url
" thinca/vim-textobj-between
" machakann/vim-swap
if jetpack#tap('vim-operator-user')
  if jetpack#tap('vim-operator-replace')
    nmap r <Plug>(operator-replace)
    xmap r <Plug>(operator-replace)
  endif
endif


if jetpack#tap('vim-textobj-user')
  if jetpack#tap('vim-swap')
    omap i, <Plug>(swap-textobject-i)
    xmap i, <Plug>(swap-textobject-i)
    omap a, <Plug>(swap-textobject-a)
    xmap a, <Plug>(swap-textobject-a)
  endif
endif
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@vim-mutchup
" {{{
if jetpack#tap('vim-matchup')
  let g:matchup_matchparen_enabled = 0
  let g:matchup_matchparen_fallback = 0
  let g:matchup_matchparen_offscreen = {}
endif
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@winresizer
" {{{
if jetpack#tap('winresizer')
  let g:winresizer_enable             = 1
  let g:winresizer_start_key          = "<C-w><C-e>"
  let g:winresizer_gui_enable         = 1
  let g:winresizer_gui_start_key      = "<C-w><C-e>"
  let g:winresizer_vert_resize        = 5
  let g:winresizer_horiz_resize       = 5
  let g:winresizer_finish_with_escape = 1

endif
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@nvim-cmp
" SubSection: plugins@vsnip
" {{{
if jetpack#tap('vim-vsnip')
endif

if s:config.type ==# 'nvim' 
  \ && jetpack#tap('nvim-cmp') && jetpack#tap('vim-vsnip')
  
  " $HOME/dotfiles/.config/nvim/lua/rc/completion.lua
  lua require('rc.completion')
else
  let g:loaded_cmp = v:true
endif
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@fern
" {{{
if jetpack#tap('fern.vim')
  let g:fern#default_hidden                               = 1
  let g:fern#disable_default_mappings                     = v:true
  let g:fern#drawer_width                                 = 30
  let g:fern#hide_cursor                                  = 0
  let g:fern#mapping#fzf#disable_default_mappings         = 1
  let g:fern#renderer                                     = 'nerdfont'
  let g:fern#renderer#nerdfont#padding                    = '  '
  let g:fern#scheme#file#show_absolute_path_on_root_label = 1

  autocmd! vimrc FileType fern call s:setup_fern()
  function! s:setup_fern() abort
    let &l:statusline = '%{getline(1)}'
    setlocal nolist
    " nmap <silent><nowait><buffer>K               <Plug>(fern-action-new-dir)
    " nmap <silent><nowait><buffer>N               <Plug>(fern-action-new-file)
    " nmap <silent><nowait><buffer>r               <Plug>(fern-action-rename)
    " nmap <silent><nowait><buffer>D               <Plug>(fern-action-remove)
    " nmap <silent><nowait><buffer>c               <Plug>(fern-action-clipboard-copy)
    " nmap <silent><nowait><buffer>m               <Plug>(fern-action-clipboard-move)
    " nmap <silent><nowait><buffer>p               <Plug>(fern-action-clipboard-paste)
    " nmap <silent><nowait><buffer>@               <Plug>(fern-action-mark:toggle)j
    nmap <silent><buffer><expr>   <Plug>(fern-my-expand-or-enter)
                                        \ fern#smart#leaf(
                                        \   "<Plug>(fern-action-open)",
                                        \   "<Plug>(fern-action-expand)",
                                        \   ""
                                        \ )

    nmap <silent><nowait><buffer> <C-c> <Plug>(fern-action-cancel)
    nmap <silent><nowait><buffer> <C-i> <Plug>(fern-action-mark:toggle)
    nmap <silent><nowait><buffer> <C-l> <Plug>(fern-action-reload)
    nmap <silent><nowait><buffer> <CR>  <Plug>(fern-action-open-or-expand)

    nmap <silent><nowait><buffer> os    <Plug>(fern-action-open:split)
    nmap <silent><nowait><buffer> ov    <Plug>(fern-action-open:vsplit)
    nmap <silent><nowait><buffer> ot    <Plug>(fern-action-open:tabedit)
    nmap <silent><nowait><buffer> oo    <Plug>(fern-action-open:select)

    nmap <silent><nowait><buffer> h     <Plug>(fern-action-collapse)
    nmap <silent><nowait><buffer> l     <Plug>(fern-my-expand-or-enter)
    nmap <silent><nowait><buffer> p     <Plug>(fern-action-open)<C-w>p
    nmap <silent><nowait><buffer> q     <cmd>close<CR>
    nmap <silent><nowait><buffer> y     <Plug>(fern-action-yank:bufname)
    nmap <silent><nowait><buffer> r     <Plug>(fern-action-reload:all)
    

    nmap <silent><nowait><buffer> .     <Plug>(fern-action-repeat)
    nmap <silent><nowait><buffer> ?     <Plug>(fern-action-help)
  endfunction
endif
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@lightline
" {{{
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
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SubSection: plugins@nvim-builtin-lsp
" SubSection: lsp-config
" {{{
if s:config.type ==# 'nvim'
  " $HOME/dotfiles/.config/nvim/lua/rc/
  lua require('rc.lsp')
endif
" }}}
" EndSection:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" SubSection: numToStr/Comment.nvim {{{
if jetpack#tap('Comment.nvim')
  lua require('rc.comment-nvim')
endif
" }}}

" vim: sw=2 sts=2 expandtab fenc=utf-8 foldmethod=marker
