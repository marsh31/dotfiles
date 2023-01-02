
syntax match   customURLs "\(https\?\|ftp\)\(:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]\+\)" containedin=.*

" syntax match   customTodo "\(MARK\|TODO\|NOTE\):" containedin=.*Comment nextgroup=customTodoCon skipwhite
syntax match   customTodo "\(MARK\|TODO\|NOTE\):.*" containedin=.*Comment nextgroup=customTodoCon skipwhite contains=customTodoCon
" syntax match   customTodoCon "\-\ .*" contained

hi customTodoCon                          guifg=#a8abb0 guibg=bg      cterm=italic,bold
hi link customTodo    Todo

hi customURLs    ctermfg=11  ctermbg=None guifg=#64a0d2 guibg=bg      cterm=italic,underline

