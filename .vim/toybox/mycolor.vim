




" Exntend color function
fun! ExtendHighlight(base, new, extra)
  redir => attrs | sil! exec 'highlight' a:base | redir END
  let attrs = substitute(split(attrs, '\n')[0], '^\S\+\s\+xxx\s*', '', '')
  sil exec 'highlight' a:new attrs a:extra
endfun






