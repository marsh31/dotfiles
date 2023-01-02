" 10-base.vim

" Base setting
" Use vim setting, not use vi.
if &compatible
	set nocompatible
endif

set helplang& helplang=en,ja

" MARK: - File encoding {{{1
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8


" MARK: - View
" set whichwrap=b,s,h,l,<,>,[,],~
set whichwrap=<,>,[,],b,s
set modeline
set number
set nowrap

set title
set list
set listchars=tab:»-,trail:-,eol:↲
set showcmd
set cursorcolumn
set cursorline
set showmatch
set matchtime=1
set matchpairs& matchpairs+=<:>

set textwidth=0
set completeopt=menu,longest
set updatetime=100
set backspace=indent,eol,start

" MARK: - Split view direction. If you split a view vertically, the view appeares below {{{1
" direction. If you split a view horizontally, the view appeares right direction.
set splitbelow
set splitright


" MARK: - Display single character letter regulary. {{{1
set ambiwidth=single


" MARK: - Mouse and clipboard {{{1
set mouse=a

set clipboard=unnamedplus
set vb t_vb=
set noerrorbells


" MARK: - Undo tree {{{1
set undodir=$HOME/.vim/undodir
set undofile


"   When open vim, change directory the file parent directory from current
" directory.
" augroup ChangeCurrentDir
"   autocmd!
"   autocmd vimEnter * call s:changeCurrentDir('', '')
" augroup END
" function! s:changeCurrentDir(directory, bang)
"   if a:directory == ''
"     lcd %:p:h
"   else
"     execute 'lcd' . a:directory
"   endif
"
"   if a:bang == ''
"     pwd
"   endif
" endfunction


"   Keep last position.
augroup KeepLastPos
  autocmd!
  autocmd Bufread * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"zz" | endif
augroup END
