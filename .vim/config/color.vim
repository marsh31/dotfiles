
syntax enable
" set synmaxcol=400

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors

else
  set t_Co=256

endif

set background=dark

" color scheme
" colorscheme test
" colorscheme gruvbox


" default color scheme


function s:gruvbox_material()
  let g:gruvbox_material_background = 'hard'
  let g:gruvbox_material_enable_bold = 1
  let g:gruvbox_material_enable_italic = 1

  let g:gruvbox_material_transparent_background = 1

  colorscheme gruvbox-material
endfunction


function s:onedark()
  let g:onedark_hide_endofbuffer = 1
  let g:onedark_terminal_italics = 1
  colorscheme onedark
endfunction


function s:tender()
  colorscheme tender
endfunction


augroup default_color
  autocmd!
  autocmd FileType * syntax include syntax/custom.vim
augroup END


call s:gruvbox_material()
" call s:onedark()
" call s:tender()
