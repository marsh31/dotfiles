

fun! AlignMarkdownRuledline()
  let line = substitute(substitute(substitute(getline('.'), ' ', '-', 'g'), '|-', '| ', 'g'), '-|', ' |', 'g')
  call setline('.', line)
endfun
