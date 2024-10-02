
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" edit_cmd
" 
" args
"   mods: string
"
" return
"   cmd: string
"
"   <q-mods> の値を渡して、editコマンドを返す。
"   有効な<q-mods:horizontal,vertical,tab>の場合、
" <q-mods:horizontal,vertical,tab> split を返す。
"   無効な<q-mods>の場合、edit を返す。
"
function! vim#command#utils#mod_split(mods)
  if a:mods =~ '\(horizontal\|vertical\|tab\)'
    let cmd = a:mods .. ' split '
  else
    let cmd = "edit "
  endif
  return cmd
endfunction
