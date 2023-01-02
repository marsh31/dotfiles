"=======================================
" FILE:   editor.vim
" AUTHOR: marsh
" 
" Initial config file.
"=======================================

" clipboard
set clipboard+=unnamedplus


" editor ui
set number
set nowrap
set cursorline
set nocursorcolumn
set list
set listchars=tab:»-,trail:-,eol:↲

set showtabline=2
set hidden

set mouse=nvh

set splitbelow
set splitright

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

set wildignorecase
set wildignore=*.o,*.jpg,*.png,*.pdf,*.so,*.dll,tags

set nobackup
set noswapfile
set nowritebackup

set signcolumn=yes:1
set helplang=en

" search
set scrolloff=10
set nohlsearch
set ignorecase
set wrapscan
set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8
set whichwrap=<,>,[,],b,s

set showmatch
set matchpairs=(:),{:},[:],<:>
set matchtime=1


if has('persistent_undo')
  set undodir=~/.local/share/nvim/undos
  set undolevels=1000
  augroup SaveUndoFile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif


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






" vim: sw=2 sts=2 expandtab fenc=utf-8
