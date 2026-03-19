


command! -nargs=0 QfOldfiles  call QfOldfiles#open()
command! -nargs=0 QfAddNew    call QfAdd#new()
command! -nargs=0 QfAddItem   call QfAdd#add()
command! -nargs=0 QfAddClear  call QfAdd#clear()


command! -nargs=+ Rgrep       call ripgrep_qf#search#search(<q-args>)
command! -nargs=+ Rgrepcf     call ripgrep_qf#search#search(<q-args> . ' ' . expand('%'))


