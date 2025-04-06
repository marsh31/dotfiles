" NAME:   vim-note
" AUTHOR: marsh
" NOTE: 
" 
" 

fun! NoteFileNameUsingDate()
  return strftime('%Y%m%d%H%M%S') . '.md'
endfun


fun! NoteNewEdit()
  execute "edit " . NoteFileNameUsingDate()
endfun


