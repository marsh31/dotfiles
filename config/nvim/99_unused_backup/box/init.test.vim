""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NAME:   init.vim
" AUTHOR: marsh
"
" NOTE:
"
"
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
       \ 'type':  'nvim',
       \ 'filer': 'fern',
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

let g:jetpck#ignore_patterns = [
      \ '**/.*',
      \ '**/.*/**',
      \ '**/*.{toml,yaml,yml}',
      \ '**/t/**',
      \ '**/test/**',
      \ '**/doc/tags',
      \ '**/Makefile*',
      \ '**/Gemfile*',
      \ '**/Rakefile*',
      \ '**/VimFlavor*',
      \ '**/README*',
      \ '**/LICENSE*',
      \ '**/LICENCE*',
      \ '**/CONTRIBUTING*',
      \ '**/CHANGELOG*',
      \ '**/NEWS*',
      \ '**/VERSION',
      \ ]
  

if isdirectory(g:vimrc.pkg.jetpack)
call jetpack#begin(g:vimrc.pkg.plugins)

" fuzzy finder 
call jetpack#add('~/.fzf')
call jetpack#add('junegunn/fzf.vim')

call jetpack#add('junegunn/gv.vim')
" call jetpack#add('lambdalisue/gina.vim')


call jetpack#add('tani/vim-jetpack')
call jetpack#add('kana/vim-textobj-user')
call jetpack#add('kana/vim-textobj-line')
call jetpack#add('mattn/vim-textobj-url')
call jetpack#add('thinca/vim-textobj-between')
call jetpack#add('kana/vim-textobj-entire')

call jetpack#add('kana/vim-operator-user')
call jetpack#add('yuki-yano/vim-operator-replace')
call jetpack#add('hrsh7th/vim-vsnip')

" TODO: vim-eft" 
" TODO: vim-searchx
" TODO: vim-candle

" file explorer
if s:config.filer ==# 'nvim-tree'
call jetpack#add('kyazdani42/nvim-tree.lua')

elseif s:config.filer ==# 'fern'
call jetpack#add('lambdalisue/fern.vim')
  call jetpack#add('lambdalisue/nerdfont.vim')
  call jetpack#add('lambdalisue/fern-bookmark.vim')
  call jetpack#add('lambdalisue/fern-git-status.vim')
  call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
  call jetpack#add('lambdalisue/fern-hijack.vim')

endif
if s:config.type ==# 'vim'
  call jetpack#add('hrsh7th/vim-vsnip-integ')
  call jetpack#add('mattn/vim-lsp-settings')
  call jetpack#add('prabirshrestha/asyncomplete-lsp.vim')
  call jetpack#add('prabirshrestha/asyncomplete.vim')
  call jetpack#add('prabirshrestha/vim-lsp')

endif

if s:config.type ==# 'nvim'
  " frameworks
  call jetpack#add('nvim-lua/plenary.nvim')
  call jetpack#add('kyazdani42/nvim-web-devicons')
  call jetpack#add('antoinemadec/FixCursorHold.nvim')

  " comment 
  call jetpack#add('numToStr/Comment.nvim')
  " call jetpack#add('folke/todo-comments.nvim'  " require (ripgrep, trouble, and telescope))

  " UI 
  call jetpack#add('nvim-lualine/lualine.nvim')
  " call jetpack#add('lukas-reineke/indent-blankline.nvim')
  " call dein#add('machakann/vim-highlightedyank', {'on_event': ['TextYankPost']}))
  
  " completion
  call jetpack#add('hrsh7th/vim-vsnip')
  call jetpack#add('hrsh7th/cmp-buffer')
  call jetpack#add('hrsh7th/cmp-cmdline')
  call jetpack#add('hrsh7th/cmp-nvim-lsp')
  call jetpack#add('hrsh7th/cmp-nvim-lua')
  call jetpack#add('hrsh7th/cmp-path')
  call jetpack#add('petertriho/cmp-git')
  " call jetpack#add('L3MON4D3/LuaSnip')
  call jetpack#add('hrsh7th/nvim-cmp')
  " call jetpack#add('saadparwaiz1/cmp_luasnip')
  " call jetpack#add('hrsh7th/vim-vsnip-integ')

  " lsp config 
  call jetpack#add('neovim/nvim-lspconfig')
  call jetpack#add('onsails/lspkind-nvim')
  call jetpack#add('tami5/lspsaga.nvim')
  call jetpack#add('ray-x/lsp_signature.nvim')
  call jetpack#add('folke/trouble.nvim')
  call jetpack#add('liuchengxu/vista.vim')
  call jetpack#add('williamboman/nvim-lsp-installer')
  call jetpack#add('jose-elias-alvarez/null-ls.nvim')
  
  " treesitter  
  call jetpack#add('nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' })
  call jetpack#add('nvim-treesitter/nvim-treesitter-textobjects')
  call jetpack#add('nvim-treesitter/nvim-treesitter-refactor')
  call jetpack#add('p00f/nvim-ts-rainbow')
  call jetpack#add('theHamsta/nvim-treesitter-pairs')
  call jetpack#add('christianchiarulli/nvcode-color-schemes.vim')
  call jetpack#add('projekt0n/github-nvim-theme')
  

  " git
  call jetpack#add('lewis6991/gitsigns.nvim')
  call jetpack#add('tanvirtin/vgit.nvim')
  " git-blame.nvim


  call jetpack#add('stevearc/qf_helper.nvim')
  call jetpack#add('skanehira/qfopen.vim')
  call jetpack#add('kevinhwang91/nvim-bqf')
  call jetpack#add('thinca/vim-qfreplace', { 'on': 'Qfreplace' })
  call jetpack#add('thinca/vim-quickrun')
  " call jetpack#add('romainl/vim-qf')
  " call jetpack#add('sk1418/QFGrep')


  call jetpack#add('phaazon/hop.nvim')
  call jetpack#add('simeji/winresizer')
  call jetpack#add('sindrets/diffview.nvim')
  call jetpack#add('rmagatti/auto-session')
  call jetpack#add('notomo/cmdbuf.nvim')
  call jetpack#add('ethanholz/nvim-lastplace')
  call jetpack#add('steelsojka/pears.nvim')    " vs windwp/nvim-autopairs vs cohama/lexima.vim)
  call jetpack#add('Chiel92/vim-autoformat')   " vs sbdchd/neoformat vs lukas-reineke/format.nvim vs mhartington/formatter.nvim )
  call jetpack#add('NTBBloodbath/rest.nvim')
  call jetpack#add('mbbill/undotree') " vs simnalamburt/vim-mudo)
  call jetpack#add('liuchengxu/vim-which-key')

  " TODO: surround.nvim vs vim-sandwich")
  call jetpack#add('ur4ltz/surround.nvim')
  " call dein#add('machakann/vim-sandwich', {'depends': ['vim-textobj-entire', 'vim-textobj-line', 'vim-textobj-functioncall', 'vim-textobj-url', 'vim-textobj-cursor-context']}) " ib, ab, is, as)
endif


call jetpack#add('is0n/jaq-nvim')

" Each extension)
"=================================================)
" json)
call jetpack#add('gennaro-tedesco/nvim-jqx')



" TODO: below plugins are not used!!!!" 
" TODO: util notify https://github.com/rcarriga/nvim-notify)
" TODO: code runner")
"=================================================)
" markdown)
" call jetpack#add('plasticboy/vim-markdown')
" call jetpack#add('iamcco/markdown-preview.nvim', { 'do': 'mkdp#util#install()' })
" call jetpack#add('mattn/vim-maketable')

"=================================================)
" flutter)
" call jetpack#add('akinsho/flutter-tools.nvim')


"=================================================)
" dap)
")
" https://github.com/Pocco81/DAPInstall.nvim)
" https://github.com/rcarriga/nvim-dap-ui)
" https://github.com/sakhnik/nvim-gdb)
" https://github.com/mfussenegger/nvim-dap)
" )

" call dein#add('mattn/vim-maketable', {'on_cmd': ['MakeTable']}))
" call dein#add('monaqa/dps-dial.vim', {'on_map': ['<Plug>']}))
" call dein#add('osyo-manga/vim-anzu', {'on_map': ['<Plug>']}))
" call dein#add('osyo-manga/vim-jplus', {'on_map': ['<Plug>']}))
" call dein#add('terryma/vim-expand-region', {'on_map': ['<Plug>(expand_region_']}))
" call dein#add('tommcdo/vim-exchange', {'on_map': ['<Plug>(Exchange']}))
" call dein#add('tyru/caw.vim', {'on_map': ['<Plug>']}))
" call dein#add('booperlv/nvim-gomove', {'on_map': ['<Plug>Go'], 'hook_post_source': 'call SetupGomove()'}))
" call dein#add('kevinhwang91/nvim-hlslens'))
" call dein#add('nacro90/numb.nvim', {'on_event': ['CmdlineEnter'], 'hook_post_source': 'call SetupNumb()'}))
" call dein#add('windwp/nvim-ts-autotag') )
")
")
" call dein#add('folke/todo-comments.nvim'))
" call dein#add('kevinhwang91/nvim-bqf', {'on_ft': ['qf']}))
" call dein#add('kwkarlwang/bufresize.nvim'))
" call dein#add('norcalli/nvim-colorizer.lua'))
" call dein#add('rcarriga/nvim-notify', {'lazy': 1}))
" call dein#add('AndrewRadev/linediff.vim', {'on_cmd': ['Linediff']}))
" call dein#add('aiya000/aho-bakaup.vim', {'on_event': ['BufWritePre', 'FileWritePre']}))
" call dein#add('farmergreg/vim-lastplace'))
" call dein#add('glidenote/memolist.vim', {'on_cmd': ['MemoNew', 'MemoList']}))
" call dein#add('iamcco/markdown-preview.nvim', {'on_cmd': 'MarkdownPreview', 'build': 'sh -c "cd app && yarn install"'}))
" call dein#add('itchyny/vim-qfedit', {'on_ft': ['qf']}))
" call dein#add('jsfaint/gen_tags.vim'))
" call dein#add('kana/vim-niceblock', {'on_event': ['InsertEnter']}))
" call dein#add('lambdalisue/guise.vim'))
" call dein#add('lambdalisue/suda.vim', {'on_cmd': ['SudaRead', 'SudaWrite']}))
" call dein#add('lambdalisue/vim-manpager', {'on_cmd': ['Man'], 'on_map': ['<Plug>']}))
" call dein#add('mbbill/undotree', {'on_cmd': ['UndotreeToggle']}))
" call dein#add('moll/vim-bbye', {'on_cmd': ['Bdelete']}))
" call dein#add('segeljakt/vim-silicon', {'on_cmd': ['Silicon']}))
" call dein#add('thinca/vim-editvar', {'on_cmd': ['Editvar']}))
" call dein#add('thinca/vim-quickrun', {'depends': ['vim-quickrun-neovim-job', 'open-browser', 'nvim-notify']}))
" call dein#add('tyru/capture.vim'))
" call dein#add('tyru/open-browser.vim', {'lazy': 1}))
" call dein#add('vim-test/vim-test', {'lazy': 1}))
" call dein#add('wesQ3/vim-windowswap', {'on_func': ['WindowSwap#EasyWindowSwap']}))
")
" call dein#add('akinsho/toggleterm.nvim', {'on_cmd': ['ToggleTerm'], 'hook_post_source': 'call SetupToggleterm()'}))
" call dein#add('gelguy/wilder.nvim', {'on_event': ['CmdlineEnter'], 'hook_post_source': 'call SetUpWilder()'}))
" call dein#add('rcarriga/vim-ultest', {'on_cmd': ['Ultest', 'UltestNearest', 'UltestSummary'], 'depends': ['vim-test']}))
" call jetpack#add('sk1418/QFGrep')

" call jetpack#add('puremourning/vimspector')
" call jetpack#add('rcarriga/nvim-notify')
" call jetpack#add('Shougo/vimproc.vim', {'do' : 'make'})

call jetpack#end()
end

let $PATH = $PATH .. ':' .. g:vimrc.pkg.plugins . '/pack/jetpack/opt/_/bin' 

for s:name in jetpack#names()
  let g:vimrc.pkg.paths[s:name] = jetpack#get(s:name).path
endfor

for s:p in glob('~/src/vim/*', v:false, v:true, v:false)
  let &runtimepath = escape(s:p, ',') .. ',' .. &runtimepath 
  g:vimrc.pkg.paths[fnamemodify(s:p, ':t')] = fnamemodify(s:p, ':p')
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
set backspace=2
set whichwrap=b,s,h,l,<,>,[,]
set completeopt=menuone,noselect,noinsert
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


if jetpack#tap('vim-vsnip')
  let g:vsnip_namespace = 'snip_'
"   imap <silent><expr> <Tab> vsnip#available(1)    ? '<Plug>(vsnip-expand-or-jump)' : minx#expand('<LT>Tab>')
"   smap <silent><expr> <Tab> vsnip#jumpable(1)     ? '<Plug>(vsnip-jump-next)'      : minx#expand('<LT>Tab>')
"   imap <silent><expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : minx#expand('<LT>S-Tab>')
"   smap <silent><expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : minx#expand('<LT>S-Tab>')
endif

if s:config.type ==# 'nvim' && jetpack#tap('nvim-cmp') 
lua<<EOF
  -- local lspkind = require'lspkind'

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
  let g:loadedcmp = v:true
endif


" if s:config.type ==# 'nvim' && jetpack#tap('nvim-treesitter') 
" lua<<EOF
" local configs = require('nvim-treesitter.configs')
" configs.setup {
"     ensure_installed = "all",
"     highlight = {
"         enable = true,
"         disable = { "markdown" },
"     },
" 
"     incremental_selection = {
"         enable = true,
"         keymaps = {
"             init_selection    = "gnn",
"             node_incremental  = "grn",
"             node_decremental  = "grm",
"             scope_incremental = "grc",
"         },
"     },
"     indent = { enable = false },
" 
" 
"     -- treesitter external plugins.
"     --
"     -- external plugins:
"     -- * 'nvim-treesitter/nvim-treesitter-refactor'
"     -- * 'nvim-treesitter/nvim-treesitter-textobjects'
"     -- * 'p00f/nvim-ts-rainbow'
"     -- * 'theHamsta/nvim-treesitter-pairs'
" 
"     refactor = {
"         highlight_definitions   = { enable = false },
"         highlight_current_scope = { enable = false },
"         smart_rename = {
"             enable = true,
"             keymaps = {
"                 smart_rename = "grr",
"             },
"         },
" 
"         navigation = {
"             enable = true,
"             keymaps = {
"                 goto_definition = "gnd",
"                 list_definitions = "gnD",
"                 list_definitions_toc = "gO",
"                 goto_next_usage = "gnu",
"                 goto_previous_usage = "gpu",
"             },
"         },
"     },
" 
"     textobjects = {
"         select = {
"             enable = true,
"             keymaps = {
"                 ["af"] = "@function.outer",
"                 ["if"] = "@function.inner",
"                 ["ac"] = "@class.outer",
"                 ["ic"] = "@class.inner",
"             },
"         },
"     },
" 
"     rainbow = {
"         enable = true,
"         extended_mode = true,
"     },
" 
"     pairs = {
"         enable = true,
"         disable = {},
"     },
" }
" 
" require('github-theme').setup()
" 
" EOF
" else
"   let g:loadedtreesitter = v:true
" end

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'


if jetpack#tap('vim-quickrun')
  let g:quickrun_no_default_key_mappings = 1
  nnoremap <Leader><Leader>r :<C-u>QuickRUn<CR>
endif    

let g:mapleader = "\<Space>"
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


tnoremap <A-j><A-j> <C-\><C-n>
tnoremap <A-[>      <C-\><C-n>
tnoremap <A-]>      <C-\><C-n>
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


function! s:cmdlineAbbreviation(input, replace) abort
  exec printf("cabbrev <expr> %s (getcmdtype() ==# \":\" && getcmdline() ==# \"%s\") ? \"%s\" : \"%s\"", a:input, a:input, a:replace, a:input)
endfunction

call s:cmdlineAbbreviation("tig", "Tig")




" vim: sw=2 sts=2 expandtab fenc=utf-8
