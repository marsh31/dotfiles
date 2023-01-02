"=======================================
" FILE:   plugin/plugins.vim
" AUTHOR: marsh
" 
" Config file to load plugins.
"=======================================

" Load plugins
"
call plug#begin('$HOME/.config/nvim/plugged')
" call jetpack#begin()
" call plug#begin()
"=================================================
" frameworks
"

Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'antoinemadec/FixCursorHold.nvim'

"=================================================
" lsp(language server protocol)
"

Plug 'neovim/nvim-lspconfig'
  Plug 'tami5/lspsaga.nvim'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'liuchengxu/vista.vim'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'jose-elias-alvarez/null-ls.nvim'


"=================================================
" treesitter
"

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  Plug 'p00f/nvim-ts-rainbow'
  Plug 'theHamsta/nvim-treesitter-pairs'

  Plug 'christianchiarulli/nvcode-color-schemes.vim'
  Plug 'projekt0n/github-nvim-theme'
  Plug 'mhartington/oceanic-next'
  " Plug 'RRethy/nvim-base16'
  " Plug 'Mofiqul/vscode.nvim'
  " Plug 'sainnhe/sonokai'



"=================================================
" completion and snippets.
" > snippets selection (vsnip, luasnip, ultisnips, snippy)
Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  " Plug 'saadparwaiz1/cmp_luasnip'
  " Plug 'L3MON4D3/LuaSnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'hrsh7th/vim-vsnip'

  " > luasnip


"=================================================
" Fuzzy Finder
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'


"=================================================
" Comment
"
Plug 'numToStr/Comment.nvim'
" Plug 'folke/todo-comments.nvim'  " require (ripgrep, trouble, and telescope)


"=================================================
" ui
"
Plug 'nvim-lualine/lualine.nvim'
" Plug 'lukas-reineke/indent-blankline.nvim'
" call dein#add('machakann/vim-highlightedyank', {'on_event': ['TextYankPost']})



"=================================================
" file explorer
"
if g:enable_nvim_tree
  Plug 'kyazdani42/nvim-tree.lua'

elseif g:enable_fern
  Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/nerdfont.vim'
    Plug 'lambdalisue/fern-bookmark.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    Plug 'lambdalisue/fern-renderer-nerdfont.vim'
    Plug 'lambdalisue/fern-hijack.vim'
endif


"=================================================
" git
"
Plug 'lewis6991/gitsigns.nvim'
Plug 'tanvirtin/vgit.nvim'
" Plug 'lambdalisue/gina.vim'
"
Plug 'junegunn/gv.vim'

" blamer
" git-blame.nvim

"=================================================
" quickfix
"
Plug 'stevearc/qf_helper.nvim'
Plug 'skanehira/qfopen.vim'
Plug 'thinca/vim-qfreplace', { 'on': 'Qfreplace' }
Plug 'kevinhwang91/nvim-bqf'
" Plug 'romainl/vim-qf'
" Plug 'sk1418/QFGrep'



"=================================================
" editor
"
Plug 'phaazon/hop.nvim'
Plug 'simeji/winresizer'
Plug 'sindrets/diffview.nvim'
Plug 'rmagatti/auto-session'
Plug 'notomo/cmdbuf.nvim'
Plug 'ethanholz/nvim-lastplace'
Plug 'steelsojka/pears.nvim'    " vs windwp/nvim-autopairs vs cohama/lexima.vim
Plug 'Chiel92/vim-autoformat'   " vs sbdchd/neoformat vs lukas-reineke/format.nvim vs mhartington/formatter.nvim 
Plug 'NTBBloodbath/rest.nvim'
Plug 'mbbill/undotree' " vs simnalamburt/vim-mudo
Plug 'liuchengxu/vim-which-key'

" TODO: surround.nvim vs vim-sandwich"
Plug 'ur4ltz/surround.nvim'
" call dein#add('machakann/vim-sandwich', {'depends': ['vim-textobj-entire', 'vim-textobj-line', 'vim-textobj-functioncall', 'vim-textobj-url', 'vim-textobj-cursor-context']}) " ib, ab, is, as


Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'mattn/vim-textobj-url'
  Plug 'thinca/vim-textobj-between'
  Plug 'kana/vim-textobj-entire'
  " Plug 'romgrk/equal.operator'
  " call dein#add('romgrk/equal.operator') " i=h a=h i=l a=l

Plug 'kana/vim-operator-user'
  Plug 'yuki-yano/vim-operator-replace'

" TODO: indent guide
" https://github.com/lukas-reineke/indent-blankline.nvim
" https://github.com/glepnir/indent-guides.nvim

" TODO: util notify https://github.com/rcarriga/nvim-notify

"=================================================
" code runner
"
" TODO: code runner"
Plug 'is0n/jaq-nvim'

" json: https://github.com/gennaro-tedesco/nvim-jqx


" Each extension
"=================================================
" json
Plug 'gennaro-tedesco/nvim-jqx'


"=================================================
" markdown
" Plug 'plasticboy/vim-markdown'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'mkdp#util#install()' }
" Plug 'mattn/vim-maketable'

"=================================================
" flutter
" Plug 'akinsho/flutter-tools.nvim'


"=================================================
" dap
"
" https://github.com/Pocco81/DAPInstall.nvim
" https://github.com/rcarriga/nvim-dap-ui
" https://github.com/sakhnik/nvim-gdb
" https://github.com/mfussenegger/nvim-dap
" 

" call dein#add('mattn/vim-maketable', {'on_cmd': ['MakeTable']})
" call dein#add('monaqa/dps-dial.vim', {'on_map': ['<Plug>']})
" call dein#add('osyo-manga/vim-anzu', {'on_map': ['<Plug>']})
" call dein#add('osyo-manga/vim-jplus', {'on_map': ['<Plug>']})
" call dein#add('terryma/vim-expand-region', {'on_map': ['<Plug>(expand_region_']})
" call dein#add('tommcdo/vim-exchange', {'on_map': ['<Plug>(Exchange']})
" call dein#add('tyru/caw.vim', {'on_map': ['<Plug>']})
" call dein#add('booperlv/nvim-gomove', {'on_map': ['<Plug>Go'], 'hook_post_source': 'call SetupGomove()'})
" call dein#add('kevinhwang91/nvim-hlslens')
" call dein#add('nacro90/numb.nvim', {'on_event': ['CmdlineEnter'], 'hook_post_source': 'call SetupNumb()'})
" call dein#add('windwp/nvim-ts-autotag') 
"
"
" call dein#add('folke/todo-comments.nvim')
" call dein#add('kevinhwang91/nvim-bqf', {'on_ft': ['qf']})
" call dein#add('kwkarlwang/bufresize.nvim')
" call dein#add('norcalli/nvim-colorizer.lua')
" call dein#add('rcarriga/nvim-notify', {'lazy': 1})
" call dein#add('AndrewRadev/linediff.vim', {'on_cmd': ['Linediff']})
" call dein#add('aiya000/aho-bakaup.vim', {'on_event': ['BufWritePre', 'FileWritePre']})
" call dein#add('farmergreg/vim-lastplace')
" call dein#add('glidenote/memolist.vim', {'on_cmd': ['MemoNew', 'MemoList']})
" call dein#add('iamcco/markdown-preview.nvim', {'on_cmd': 'MarkdownPreview', 'build': 'sh -c "cd app && yarn install"'})
" call dein#add('itchyny/vim-qfedit', {'on_ft': ['qf']})
" call dein#add('jsfaint/gen_tags.vim')
" call dein#add('kana/vim-niceblock', {'on_event': ['InsertEnter']})
" call dein#add('lambdalisue/guise.vim')
" call dein#add('lambdalisue/suda.vim', {'on_cmd': ['SudaRead', 'SudaWrite']})
" call dein#add('lambdalisue/vim-manpager', {'on_cmd': ['Man'], 'on_map': ['<Plug>']})
" call dein#add('mbbill/undotree', {'on_cmd': ['UndotreeToggle']})
" call dein#add('moll/vim-bbye', {'on_cmd': ['Bdelete']})
" call dein#add('segeljakt/vim-silicon', {'on_cmd': ['Silicon']})
" call dein#add('thinca/vim-editvar', {'on_cmd': ['Editvar']})
" call dein#add('thinca/vim-quickrun', {'depends': ['vim-quickrun-neovim-job', 'open-browser', 'nvim-notify']})
" call dein#add('tyru/capture.vim')
" call dein#add('tyru/open-browser.vim', {'lazy': 1})
" call dein#add('vim-test/vim-test', {'lazy': 1})
" call dein#add('wesQ3/vim-windowswap', {'on_func': ['WindowSwap#EasyWindowSwap']})
"
" call dein#add('akinsho/toggleterm.nvim', {'on_cmd': ['ToggleTerm'], 'hook_post_source': 'call SetupToggleterm()'})
" call dein#add('gelguy/wilder.nvim', {'on_event': ['CmdlineEnter'], 'hook_post_source': 'call SetUpWilder()'})
" call dein#add('rcarriga/vim-ultest', {'on_cmd': ['Ultest', 'UltestNearest', 'UltestSummary'], 'depends': ['vim-test']})
"
" Trash
"
" Plug 'junegunn/gv.vim
"
" Plug 'sk1418/QFGrep'

" Plug 'puremourning/vimspector'
" Plug 'rcarriga/nvim-notify'
" Plug 'thinca/vim-quickrun'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" call jetpack#end()

call plug#end()

" vim: sw=2 sts=2 expandtab fenc=utf-8
