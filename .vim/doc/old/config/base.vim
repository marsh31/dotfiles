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

set vb t_vb=
set noerrorbells



