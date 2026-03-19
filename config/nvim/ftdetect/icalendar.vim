" NAME:   icalendar.vim
" AUTHOR: marsh
"
"

" ics ファイルを iCalendar として認識
augroup filetypedetect_icalendar
  autocmd!
  autocmd BufNewFile,BufRead *.ics setfiletype icalendar
augroup END

" vim: set ft=vim
