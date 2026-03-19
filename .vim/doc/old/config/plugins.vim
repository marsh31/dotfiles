""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File: plugins.vim
" Author: marsh31
" Description: vimrc
" Last Modified: August 15, 2020
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load plugins.
call plug#begin('~/.vim/plugged/')
  " begin [ ToyBox ] {{{
  " Plug 'vim-jp/vital.vim'
  Plug 'mattn/webapi-vim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-operator-user'
  Plug 'vim-jp/vimdoc-ja'

  Plug 'lambdalisue/nerdfont.vim'
  " end   [ ToyBox ] }}}

  " begin [ text-object ] {{{
  Plug 'coderifous/textobj-word-column.vim'
  Plug 'thinca/vim-textobj-between'
  Plug 'kana/vim-textobj-datetime'
  Plug 'kana/vim-textobj-line'
  Plug 'paulhybryant/vim-textobj-path'
  " end   [ text-object ] }}}

  " begin [ operation ] {{{
  Plug 'kana/vim-operator-replace'
  " end   [ operation ] }}}

  " begin [ Completion plugins ] {{{
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'

  " For async complete
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
  Plug 'prabirshrestha/asyncomplete-file.vim'

  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  " }}}
  
  " begin [ Syntax ] {{{
  Plug 'cespare/vim-toml'
  " end   [ Syntax ] }}}

  " begin [ Color ] {{{
  Plug 'morhetz/gruvbox'
  Plug 'sainnhe/gruvbox-material'

  Plug 'joshdick/onedark.vim'
  Plug 'jacoborus/tender.vim'
  Plug 'cocopon/iceberg.vim'
  " end   [ Color ] }}}

  " begin [ motion ] {{{
  Plug 'yuttie/comfortable-motion.vim'
  Plug 'easymotion/vim-easymotion'
  " end   [ motion ] }}}

  " begin [ Edit ] {{{
  Plug 'tomtom/tcomment_vim'
  Plug 'osyo-manga/vim-over'
  Plug 'simnalamburt/vim-mundo'
  Plug 'simeji/winresizer'
  Plug 'liuchengxu/vista.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'andymass/vim-matchup'
  " Plug 'airblade/vim-rooter'
  Plug 'luochen1990/rainbow'
  Plug 'Shougo/vimproc.vim'
  Plug 'skywind3000/asynctasks.vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'chiel92/vim-autoformat'
  Plug 'cohama/lexima.vim'
  Plug 'markonm/traces.vim'
  Plug 'glidenote/memolist.vim'
  " end   [ Edit ] }}}

  " begin [ File explorer ] {{{
  " Plug 'scrooloose/nerdtree'
  " Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-bookmark.vim'
  Plug 'lambdalisue/fern-git-status.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/fern-hijack.vim'
  " end   [ File explorer ] }}}

  " begin [ Quickfix ] {{{
  Plug 'sk1418/QFGrep'
  Plug 'romainl/vim-qf'
  " end   [ Quickfix ] }}}

  " begin [ Status line ] {{{
  Plug 'itchyny/lightline.vim'
  " end   [ Status line ] }}}

  " begin [ Searcher ] {{{
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Plug '/usr/share/doc/fzf/examples'
  Plug 'junegunn/fzf.vim'
  " end   [ Searcher ] }}}

  " begin [ Git ] {{{
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'lambdalisue/gina.vim'
  " end   [ Git ] }}}

  " begin [ Markdown ] {{{
  Plug 'ujihisa/neco-look',       { 'for': ['markdown', 'md', 'txt'] }
  Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }
  Plug 'godlygeek/tabular',       { 'for': ['markdown', 'md'] }
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  " end   [ Markdown ] }}}

  " begin [ PlantUML ] {{{
  Plug 'aklt/plantuml-syntax',    { 'for': ['plantuml'] }
  Plug 'tyru/open-browser.vim',   { 'for': ['plantuml'] }
  Plug 'weirongxu/plantuml-previewer.vim', { 'for': ['plantuml'] }
  " end   [ PlantUML ] }}}

  " begin [ rust ] {{{
  Plug 'rust-lang/rust.vim'
  " end   [ rust ] }}}

  " begin [ custom ] {{{
  Plug '~/.vim/custom/enhancedfzf'
  Plug '~/.vim/custom/msector'
  Plug '~/.vim/custom/todo'
  Plug '~/.vim/custom/acomplete-file'
  " end   [ custom ] }}}
call plug#end()
filetype plugin indent on

