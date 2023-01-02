

" syntax match   cTodo "\(MARK\|TODO\|NOTE\):.*" containedin=.*Comment nextgroup=customTodoCon skipwhite contains=customTodoCon
" syntax match   customTodoCon "\-\ .*" containedin=Todo

hi customTodoCon                          guifg=#a8abb0 guibg=bg      cterm=italic,bold
hi link cTodo    Todo
