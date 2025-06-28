
augroup MRU_AUTO_CMDS
  au!
  autocmd BufRead      * call mru#mru#add_file('<abuf>')
  autocmd BufWritePost * call mru#mru#add_file('<abuf>')
  autocmd BufEnter     * call mru#mru#add_file('<abuf>')
augroup END


