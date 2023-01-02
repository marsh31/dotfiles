""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NAME:   init.vim
" AUTHOR: marsh
"
" NOTE:
"  TODO: 
"
"

" Section: @initialize {{{
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

augroup vimrc
  autocmd!
augroup END

" }}}
" Section: @plugins {{{
"
" NOTE: 
"
call jetpack#begin(g:vimrc.pkg.plugins)
" SubSection: @Framework {{{

call jetpack#add('tani/vim-jetpack')

call jetpack#add('nvim-lua/popup.nvim')
call jetpack#add('nvim-lua/plenary.nvim')
call jetpack#add('MunifTanjim/nui.nvim')
call jetpack#add('antoinemadec/FixCursorHold.nvim')

call jetpack#add('tpope/vim-repeat')
call jetpack#add('kana/vim-operator-user')
call jetpack#add('kana/vim-textobj-user')
call jetpack#add('kana/vim-submode')

call jetpack#add('lambdalisue/glyph-palette.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('kyazdani42/nvim-web-devicons')

call jetpack#add('rcarriga/nvim-notify')

call jetpack#add('~/.fzf')

" }}}
" SubSection: @LSP {{{

call jetpack#add('neovim/nvim-lspconfig')
call jetpack#add('jose-elias-alvarez/null-ls.nvim')
call jetpack#add('onsails/lspkind-nvim')
call jetpack#add('ray-x/lsp_signature.nvim')
call jetpack#add('tami5/lspsaga.nvim')
call jetpack#add('williamboman/nvim-lsp-installer')
call jetpack#add('folke/trouble.nvim')
call jetpack#add('j-hui/fidget.nvim')

" }}}
" SubSection: @Treesitter {{{

call jetpack#add('sainnhe/everforest')
call jetpack#add('bluz71/vim-nightfly-guicolors')
call jetpack#add('christianchiarulli/nvcode-color-schemes.vim')
call jetpack#add('projekt0n/github-nvim-theme')

call jetpack#add('nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' })

call jetpack#add('nvim-treesitter/nvim-treesitter-textobjects')
call jetpack#add('RRethy/nvim-treesitter-textsubjects')
call jetpack#add('mfussenegger/nvim-treehopper')
call jetpack#add('David-Kunz/treesitter-unit')

call jetpack#add('yioneko/nvim-yati')
call jetpack#add('nvim-treesitter/nvim-treesitter-refactor')
call jetpack#add('theHamsta/nvim-treesitter-pairs')
call jetpack#add('p00f/nvim-ts-rainbow')

" }}}

" SubSection: @Completion {{{

call jetpack#add('mattn/vim-sonictemplate')

call jetpack#add('kevinhwang91/nvim-hclipboard')
call jetpack#add('hrsh7th/vim-vsnip')
call jetpack#add('L3MON4D3/LuaSnip')

call jetpack#add('hrsh7th/cmp-nvim-lsp-signature-help')
call jetpack#add('hrsh7th/cmp-nvim-lsp-document-symbol')
call jetpack#add('hrsh7th/cmp-buffer')
call jetpack#add('hrsh7th/cmp-cmdline')
call jetpack#add('hrsh7th/cmp-nvim-lsp')
call jetpack#add('hrsh7th/cmp-nvim-lua')
call jetpack#add('hrsh7th/cmp-path')
call jetpack#add('hrsh7th/cmp-vsnip')
call jetpack#add('saadparwaiz1/cmp_luasnip')
call jetpack#add('petertriho/cmp-git')

call jetpack#add('hrsh7th/nvim-cmp')

" }}}
" SubSection: @FuzzyFinder {{{

call jetpack#add('junegunn/fzf.vim')

" }}}
" SubSection: @ReplaceFeature {{{

call jetpack#add('lambdalisue/suda.vim')
call jetpack#add('haya14busa/vim-asterisk')
call jetpack#add('ethanholz/nvim-lastplace')
call jetpack#add('simeji/winresizer')
call jetpack#add('rmagatti/auto-session')
call jetpack#add('t9md/vim-choosewin')
call jetpack#add('sindrets/diffview.nvim')
call jetpack#add('yutkat/history-ignore.nvim')

" }}}

" SubSection: @Appearance {{{
" SubSubSection: @Bufferline {{{
" }}}
" SubSubSection: @Indent {{{

call jetpack#add('hrsh7th/vim-gindent')

" }}}
" SubSubSection: @Highlight {{{

call jetpack#add('RRethy/vim-illuminate')
call jetpack#add('t9md/vim-quickhl')

" }}}
" SubSubSection: @Scrollbar {{{

call jetpack#add('petertriho/nvim-scrollbar')

" }}}
" SubSubSection: @Sidebar {{{

call jetpack#add('sidebar-nvim/sidebar.nvim')
call jetpack#add('folke/which-key.nvim')

" }}}
" SubSubSection: @Startup {{{

call jetpack#add('goolord/alpha-nvim')

" }}}
" SubSubSection: @Statusline {{{

call jetpack#add('itchyny/lightline.vim')
" call jetpack#add('nvim-lualine/lualine.nvim')
" call jetpack#add('SmiteshP/nvim-navic')
" call jetpack#add('kevinhwang91/nvim-hlslens')

" }}}
" SubSubSection: @Outline {{{

call jetpack#add('stevearc/aerial.nvim')
call jetpack#add('liuchengxu/vista.vim')
call jetpack#add('mbbill/undotree')

" }}}
" }}}
" SubSection: @CommandLineWindow {{{
"
call jetpack#add('notomo/cmdbuf.nvim')

" }}}
" SubSection: @Comment {{{

call jetpack#add('numToStr/Comment.nvim')

" }}}
" SubSection: @FileManager {{{

call jetpack#add('lambdalisue/fern-bookmark.vim')
call jetpack#add('lambdalisue/fern-git-status.vim')
call jetpack#add('lambdalisue/fern-hijack.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/fern.vim')

" }}}
" SubSection: @Movement {{{

call jetpack#add('bkad/CamelCaseMotion')
call jetpack#add('Bakudankun/BackAndForward.vim')

call jetpack#add('hrsh7th/vim-eft')
call jetpack#add('hrsh7th/vim-searchx')
call jetpack#add('phaazon/hop.nvim')

" }}}
" SubSection: @OpenBrowser {{{

call jetpack#add('tyru/open-browser.vim')
call jetpack#add('tyru/open-browser-github.vim')

" }}}
" SubSection: @Quickfix {{{

call jetpack#add('sk1418/QFGrep')
call jetpack#add('thinca/vim-qfreplace')
call jetpack#add('kevinhwang91/nvim-bqf')
call jetpack#add('skanehira/qfopen.vim')
call jetpack#add('stevearc/qf_helper.nvim')
call jetpack#add('gabrielpoca/replacer.nvim')

" }}}
" SubSection: @Tag {{{

" call jetpack#add('windwp/nvim-autopairs')
" call jetpack#add('windwp/nvim-ts-autotag')
call jetpack#add('cohama/lexima.vim')
call jetpack#add('andymass/vim-matchup')

" }}}
" SubSection: @Test {{{

call jetpack#add('NTBBloodbath/rest.nvim')
call jetpack#add('thinca/vim-quickrun')
call jetpack#add('is0n/jaq-nvim')

" }}}
" SubSection: @TextObjctOperator {{{

call jetpack#add('kana/vim-textobj-line')
call jetpack#add('kana/vim-textobj-entire')
call jetpack#add('mattn/vim-textobj-url')
call jetpack#add('thinca/vim-textobj-between')
call jetpack#add('machakann/vim-swap')

call jetpack#add('gbprod/substitute.nvim')
call jetpack#add('yuki-yano/vim-operator-replace')
call jetpack#add('machakann/vim-sandwich')

" }}}
" SubSection: @VCS {{{

call jetpack#add('junegunn/gv.vim')
call jetpack#add('lewis6991/gitsigns.nvim')
call jetpack#add('tanvirtin/vgit.nvim')
call jetpack#add('akinsho/git-conflict.nvim')
" call jetpack#add('lambdalisue/gina.vim')

" }}}

" SubSection: @EachLanguage {{{

" SubSubSection: @Binary {{{

call jetpack#add('Shougo/vinarise.vim')

" }}}
" SubSubSection: @json {{{

call jetpack#add('b0o/SchemaStore.nvim')
call jetpack#add('gennaro-tedesco/nvim-jqx')
" }}}
" SubSubSection: @markdown {{{

call jetpack#add('iamcco/markdown-preview.nvim')
call jetpack#add('dhruvasagar/vim-table-mode')

" }}}

" }}}

call jetpack#end()
" SubSection: @localplugin {{{

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

" }}}

" }}}
" Section: @config {{{
" SubSection: @base {{{
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
set pumheight=15
set showtabline=2
set cmdheight=1
set list
set listchars=tab:>-,trail:^,eol:↲
set noshowmode
set ambiwidth=single
set title
set shortmess+=I
set shortmess+=c
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
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set completeopt=menu,menuone,noselect
set startofline
set signcolumn=yes:1
set helplang=en
set formatoptions=croq

let g:vim_indent_cont = 0
let g:markdown_fenced_languages = ['ts=typescript']

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


set foldlevel=0
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldtext=MyFoldText()
function MyFoldText()
  let line = getline(v:foldstart)
  let pattern = '[ ' . substitute(&commentstring, ' *%s', '', 'g') . ']*{{{\d\= *$' " }}}

  let left = substitute(line, pattern, '', '') . " "
  let right = " [" . v:foldlevel . ":" . v:foldstart . "-" . v:foldend . "]"
  let middlesize = vimrc#get_current_win_width() - len(left) - len(right)
  let middle = repeat("-", middlesize)

  return left . middle . right
endfunction

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

" }}}
" SubSection: @LSP {{{

" ~/.config/nvim/lua/rc/lsp.lua
lua require('rc.lsp')

" }}}
" SubSection: @Treesitter {{{

if jetpack#tap('nvim-treesitter')
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
colorscheme github_dark

" }}}
" SubSection: @Highlight {{{

if jetpack#tap('vim-quickhl')
  let g:quickhl_manual_keywords = [
  \   { 'pattern': '\<\(TODO\|FIXME\|NOTE\|INFO\)\>', 'regexp': 1 },
  \ ]
  " nmap @ <Plug>(quickhl-manual-this)
endif

" }}}
" SubSection: @Completion {{{

if jetpack#tap('nvim-cmp') && jetpack#tap('vim-vsnip') && jetpack#tap('LuaSnip')

  " $HOME/dotfiles/.config/nvim/lua/rc/completion.lua
  lua require('rc.completion')

endif

" }}}
" SubSection: @FuzzyFinder {{{

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
" SubSection: @ReplaceFeature {{{

if jetpack#tap('vim-asterisk')
  let g:asterisk#keeppos = 1
  map * <Plug>(asterisk-gz*)
endif

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
" SubSection: @Appearance {{{

" SubSubSection: @Bufferline {{{
" }}}
" SubSubSection: @Indent {{{

if jetpack#tap('vim-gindent')
  let g:gindent = {}
  let g:gindent.enabled = { -> index(['html', 'yaml'], &filetype) == -1 }
endif

" }}}
" SubSubSection: @Statusline {{{

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
" SubSubSection: @Outline {{{


" }}}

" }}}
" SubSection: @CommandLineWindow {{{

augroup cmdbuf_setting
  autocmd!
  autocmd User CmdbufNew call s:cmdbuf()
augroup END
function! s:cmdbuf() abort
  normal! G

  nnoremap <nowait> <buffer> q <cmd>quit<CR>
  nnoremap <buffer> dd <cmd>lua require('cmdbuf').delete()<CR>
endfunction

nnoremap q: <cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight)<CR>
nnoremap ql <cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {type = "lua/cmd"})<CR>
nnoremap q/ <cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {type = "vim/search/forward"})<CR>
nnoremap q? <cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, {type = "vim/search/backward"})<CR>

" }}}
" SubSection: @Comment {{{

if jetpack#tap('Comment.nvim')
  lua require('rc.comment-nvim')
endif

" }}}
" SubSection: @FileManager {{{
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

    nmap <silent><nowait><buffer> %     <Plug>(fern-action-new-file)

    nmap <silent><nowait><buffer> .     <Plug>(fern-action-repeat)
    nmap <silent><nowait><buffer> ?     <Plug>(fern-action-help)
  endfunction
endif
" }}}
" SubSection: @Movement {{{

if jetpack#tap('vim-eft')
  let g:eft_index_function = get(g:, 'eft_index_function', {
  \   'head'  : function('eft#index#head'),
  \   'tail'  : function('eft#index#tail'),
  \   'camel' : function('eft#index#camel'),
  \   'space' : function('eft#index#space'),
  \   'symbol': function('eft#index#symbol'),
  \ })

  " nmap ; <Plug>(eft-repeat)
  " xmap ; <Plug>(eft-repeat)
  " omap ; <Plug>(eft-repeat)
  "
  " nmap f <Plug>(eft-f-repeatable)
  " xmap f <Plug>(eft-f-repeatable)
  " omap f <Plug>(eft-f-repeatable)
  "
  " nmap t <Plug>(eft-t-repeatable)
  " xmap t <Plug>(eft-t-repeatable)
  " omap t <Plug>(eft-t-repeatable)
  "
  " nmap F <Plug>(eft-F-repeatable)
  " xmap F <Plug>(eft-F-repeatable)
  " omap F <Plug>(eft-F-repeatable)
  "
  " nmap T <Plug>(eft-T-repeatable)
  " xmap T <Plug>(eft-T-repeatable)
  " omap T <Plug>(eft-T-repeatable)
endif

if jetpack#tap('vim-searchx')
  " https://github.com/hrsh7th/vim-searchx
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


if jetpack#tap('hop.nvim')
lua <<EOF
require('hop').setup {  }
EOF
endif

" }}}
" SubSection: @OpenBrowser {{{

if jetpack#tap('open-browser.vim')
  " nmap <Leader><Leader><CR> <Plug>(openbrowser-smart-search)
endif

" }}}
" SubSection: @Quickfix {{{


" }}}
" SubSection: @Tag {{{

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

if jetpack#tap('vim-matchup')
  let g:matchup_matchparen_enabled = 0
  let g:matchup_matchparen_fallback = 0
  let g:matchup_matchparen_offscreen = {}
endif
" }}}
" SubSection: @Test {{{

if jetpack#tap('vim-quickrun')
  let g:quickrun_no_default_key_mappings = 1
  " nnoremap <Leader><Leader>r :<C-u>QuickRun<CR>
endif


" }}}
" SubSection: @TextObjectOperator {{{
" kana/vim-operator-user
" yuki-yano/vim-operator-replace
" kana/vim-textobj-user
" kana/vim-textobj-entire
" kana/vim-textobj-line
" mattn/vim-textobj-url
" thinca/vim-textobj-between
" machakann/vim-swap

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

if jetpack#tap('vim-textobj-user')
  if jetpack#tap('vim-swap')
    omap i, <Plug>(swap-textobject-i)
    xmap i, <Plug>(swap-textobject-i)
    omap a, <Plug>(swap-textobject-a)
    xmap a, <Plug>(swap-textobject-a)
  endif
endif

if jetpack#tap('vim-operator-user')
  if jetpack#tap('vim-operator-replace')
    nmap r <Plug>(operator-replace)
    xmap r <Plug>(operator-replace)
  endif
endif



" }}}
" SubSection: @VCS {{{



" }}}
" SubSection: @enhanced {{{
command! ToggleSearchHighlight setlocal hlsearch!
command! ToggleWrap            setlocal wrap!
command! ToggleRelativeNumber  setlocal relativenumber!

augroup GrepCmd
  autocmd!
  " autocmd QuickFixCmdPost vim,grep,make if len(getqflist()) != 0 | cwindow | endif
  autocmd QuickFixCmdPost vimgrep,grep,grepadd if len(getqflist()) != 0 | copen | endif
augroup END


if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l:%c:%m
endif

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


augroup term_open_config
  autocmd!
  autocmd TermOpen * startinsert
augroup END

" command
command! -nargs=* T split | wincmd j | resize 20 | terminal <args>

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

" }}}
" }}}
" Section: @map {{{
let mapleader="\<Space>"

" Nop keys {{{

function! s:keyToNop(types, key) abort
  for type in a:types
    execute printf('%snoremap %s <Nop>', type, a:key)
  endfor
endfunction
call s:keyToNop(["n", "i", "c", "v", "t"], "<MiddleMouse>")
call s:keyToNop(["n", "i", "c", "v", "t"], "<2-MiddleMouse>")
call s:keyToNop(["n", "i", "c", "v", "t"], "<3-MiddleMouse>")
call s:keyToNop(["n", "i", "c", "v", "t"], "<4-MiddleMouse>")

" }}}
" normal map {{{
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


" }}}
" insert map {{{

inoremap jj <ESC>
inoremap jk <ESC>

" }}}
" commandline map {{{
"
cnoremap <C-a> <HOME>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" }}}
" terminal map {{{

tnoremap <A-j><A-j> <C-\><C-n>
tnoremap <A-[>      <C-\><C-n>
tnoremap <A-]>      <C-\><C-n>

" }}}

call s:cmdlineAbbreviation("tig", "Tig")

" END {{{
" vim: sw=2 sts=2 expandtab fenc=utf-8 foldmethod=marker
