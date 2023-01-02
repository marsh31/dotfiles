"=======================================
" FILE:   plugins/fold.vim
" AUTHOR: marsh
"
" NOTE:
" - zo, zO: Open
"
" - zc, zC: Close
"
" - za, zA: Toggle
"
" - [z, ]z: Move start/end of fold
"
" - zj, zk: Move to downwards to the start/upwards to
"   the end of the next/previous fold.
" 
" TODO: customize fold text and replace lua.
"=======================================


set foldlevel=1
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldtext=MyFoldText()
function MyFoldText()
  " let line = getline(v:foldstart)
  " return line
  let line = getline(v:foldstart)
  let pattern = '[ ' . substitute(&commentstring, ' *%s', '', 'g') . ']*{{{\d\= *$' " }}}
  let sub = substitute(line, pattern, '', '')
  return sub . " [" . v:foldstart . "-" . v:foldend . "]" 
endfunction

" vim: sw=2 sts=2 expandtab fenc=utf-8
