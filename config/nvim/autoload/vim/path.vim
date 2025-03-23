" NAME:   vim#path
" AUTHOR: marsh
"
" NOTE:
"
" 20250111131137.md
"
" functions
" - vim#path#get_separator()
" - vim#path#trim_last_separator(path)
" - vim#path#rel(path)
" - vim#path#join(paths)
"


" vim#path#get_separator {{{


" Get the directory separator.
let s:sep = v:null
fun! vim#path#get_separator() abort
  return s:separator()
endfun

fun! s:separator() abort
    if s:sep is v:null
        let s:sep = fnamemodify('.', ':p')[-1 :]
    endif
    return s:sep
endfun


" }}}
" vim#path#trim_last_separator {{{


fun! vim#path#trim_last_separator(path) abort
  return s:trim_last_separator(a:path)
endfun

" Trim end the separator of a:path.
fun! s:trim_last_separator(path) abort
    let l:sep = vim#path#get_separator()
    let l:pat = escape(l:sep, '\') . '\+$'
    return substitute(a:path, l:pat, '', '')
endfun


" }}}
" vim#path#rel {{{


fun! vim#path#rel(path) abort
    return fnamemodify(a:path, ':~:.')
endfun


"  }}}
" vim#path#join {{{


fun! vim#path#join(paths) abort
  if empty(a:paths)
    return ''
  endif

  let l:result = vim#path#trim_last_separator(a:paths[0])
  for i in range(1, (len(a:paths) - 1))
    let l:result .= (vim#path#get_separator() . a:paths[i])
  endfor

  return l:result
endfun


" }}}
" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
