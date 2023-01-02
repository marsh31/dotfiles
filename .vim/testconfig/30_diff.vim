" 15-diff.vim

" Diff options
set diffopt=filler

" DiffOrig is show difference between current buffer and the last saved state.
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthi
