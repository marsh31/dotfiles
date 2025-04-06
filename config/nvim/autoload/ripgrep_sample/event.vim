" NAME:   event
" AUTHOR: marsh
"
" NOTE:
"
" ripgrep#event#raw()
" ripgrep#event#error()
" ripgrep#event#other()
" ripgrep#event#match()
" ripgrep#event#file_begin()
" ripgrep#event#file_end()
" ripgrep#event#finish()
"

" ripgrep#event#raw  {{{

fun! ripgrep#event#raw()
  return 'raw'
endfun

" }}}
" ripgrep#event#error {{{

fun! ripgrep#event#error()
  return 'error'
endfun

" }}}
" ripgrep#event#other {{{

fun! ripgrep#event#other()
  return 'other'
endfun

" }}}
" ripgrep#event#match {{{

fun! ripgrep#event#match()
  return 'match'
endfun

" }}}
" ripgrep#event#file_begin {{{

fun! ripgrep#event#file_begin()
  return 'file_begin'
endfun

" }}}
" ripgrep#event#file_end {{{

fun! ripgrep#event#file_end()
  return 'file_end'
endfun

" }}}
" ripgrep#event#finish {{{

fun! ripgrep#event#finish()
  return 'finish'
endfun

" }}}
" END {{{
" vim: set foldmethod=marker :
