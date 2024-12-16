
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


function! vim#command#utils#trim_path(path) abort
  if a:path[-1:-1] == vim#command#utils#get_shellslashchar()
    return a:path[0:-2]
  endif
  return a:path
endfunction


function! vim#command#utils#get_shellslashchar()
  let char = '/'
  
  if has('win32') && ! &shellslash
    let char = '\'

  endif

  return char
endfunction
