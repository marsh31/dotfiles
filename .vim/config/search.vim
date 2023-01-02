" 15-search.vim
"
" Search setting. The vim grep change to rg.
set hlsearch
set ignorecase
set smartcase
set wrapscan

if executable('rg')
  let &grepprg = 'rg --vimgrep --hidden'
  set grepformat=%f:%l:%c:%m
endif

