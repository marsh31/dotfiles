" NAME:   root
" AUTHOR: marsh
"
" NOTE:
"
"

" vim#root#search(path, keywords) {{{

fun! vim#root#search(path, keywords) abort
  let l:path = vim#path#trim_last_separator(a:path)
  if type(a:keywords) != v:t_list || len(a:keywords) == 0
    return [ l:path, '' ]
  endif

  let l:found = s:traverse(l:path, '', a:keywords)
  if l:found is v:null
    return [ l:path, '' ]
  endif

  return l:found
endfun

" }}}
" s:traverse(path, rel, keywords) {{{

fun! s:traverse(path, rel, keywords) abort
  if a:path ==# ''
    return [ a:path, a:rel ]
  endif

  for l:keyword in a:keywords
    let l:path = vim#path#join([a:path, l:keyword])
    if filereadable(l:path) || isdirectory(l:path)
      return [ a:path, a:rel ]
    endif
  endfor

  let l:parent = fnamemodify(a:path, ':h')
  if l:parent ==# a:path
    return v:null
  endif

  return s:traverse(l:parent, vim#path#join([a:rel, '..']), a:keywords)
endfun

" }}}

" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
