
syntax enable
set t_Co=256
set synmaxcol=200
if exists('+termguicolors')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set background=dark

" color scheme
" colorscheme test
" colorscheme gruvbox


" default color scheme
" colorscheme gruvbox-material
" let g:gruvbox_material_background = 'soft'


augroup default_color
  autocmd!
  autocmd FileType * syntax include syntax/custom.vim
augroup END
