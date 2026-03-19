" 
" NAME: line2checkbox.vim
" 
" NOTE: 
"   markdownファイルで行に対してチェックボックスをつける。
" List 表記であれば、"- [ ]" に入れ替える。
" すでにチェックボックスがついていれば何もしない。
" 


let s:line_pat = '^\s*[\-\*+]\?\zs\S.\+\ze'

