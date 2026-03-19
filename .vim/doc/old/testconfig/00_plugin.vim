" 00-plugin.vim
"
" Setting for loading plugins.

" Load plugins.
call plug#begin('~/.vim/plugged/')
  " custom {{{
  Plug '~/.vim/custom/enhancedfzf'
  Plug '~/.vim/custom/msector'
  Plug '~/.vim/custom/todo'
  " }}}
  " Completion plugins {{{
  " For language server protocol.
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
  " Color {{{
  Plug 'morhetz/gruvbox'
  Plug 'sainnhe/gruvbox-material'
  " }}}
  " Edit {{{
  Plug 'w0rp/ale'
  Plug 'tomtom/tcomment_vim'
  Plug 'Shougo/vimproc.vim'
  Plug 'osyo-manga/vim-over'
  Plug 'simnalamburt/vim-mundo'
  Plug 'simeji/winresizer'
  Plug 'liuchengxu/vista.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'chiel92/vim-autoformat'
  Plug 'andymass/vim-matchup'

  " }}}
  " File explorer {{{
  " Plug 'scrooloose/nerdtree'
  " Plug 'Xuyuanp/nerdtree-git-plugin'

  Plug 'lambdalisue/fern.vim'
  " }}}
  " Status line {{{
  Plug 'itchyny/lightline.vim'
  " }}}
  " Searcher {{{
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " }}}
  " Git {{{
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'lambdalisue/gina.vim'
  " }}}
  " Markdown {{{
  Plug 'ujihisa/neco-look',       { 'for': ['markdown', 'md', 'txt'] }
  Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }
  Plug 'godlygeek/tabular',       { 'for': ['markdown', 'md'] }
  " Plug 'kannokanno/previm',       { 'for': ['markdown', 'md'] }
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  " }}}
  " begin [ PlantUML ] {{{
  Plug 'aklt/plantuml-syntax',    { 'for': ['plantuml'] }
  Plug 'tyru/open-browser.vim',   { 'for': ['plantuml'] }
  Plug 'weirongxu/plantuml-previewer.vim', { 'for': ['plantuml'] }
  " end   [ PlantUML ] }}}
  " begin [ rust ] {{{
  Plug 'rust-lang/rust.vim'
  " end   [ rust ] }}}
call plug#end()
filetype plugin indent on
