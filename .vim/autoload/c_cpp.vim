
function! c_cpp#CCppFileChange() abort
  let name = split(bufname("%"), '\.')
  if (name[1] =~# "\\(hpp\\|h\\)") 
    let edit_file_name = name[0] .".". substitute(name[1], "h", "c", "")
    if (filewritable(edit_file_name)) 
      execute "edit " . edit_file_name
    endif

    
  elseif (name[1] =~# "^\\(c\\|cpp\\)$")
    let edit_file_name = name[0] .".". substitute(name[1], "c", "h", "")
    if (filewritable(edit_file_name)) 
      execute "edit " . edit_file_name
    endif

  else
    echo "No match"
  endif
endfunction
