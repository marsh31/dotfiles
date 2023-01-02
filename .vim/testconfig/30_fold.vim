" fold setting  
set signcolumn=yes

set foldmethod=marker
set foldcolumn=0
set foldlevel=0



" MARK: - Bellow the setting is test setting.
" NOTE: - fillchars hsa some fill char setting. [stl,stlnc,vert,fold,diff]
set fillchars=vert:\ ,fold:\ 

function! MyFoldText() " {{{1
  let line = getline(v:foldstart)
  let pattern = '[ ' . substitute(&commentstring, ' *%s', '', 'g') . ']*{{{\d\= *$' " }}}
  let sub = substitute(line, pattern, '', '')
  return sub . " {...}  [" . v:foldstart . "-" . v:foldend . "]" 
endfunction 
set foldtext=MyFoldText()
" }}}


