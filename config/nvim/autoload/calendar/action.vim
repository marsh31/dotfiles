" NAME:   autoload/calendar/action.vim
" AUTHOR: marsh
"
" Calendarバッファ内のアクション制御を行う。


"
" calendar#action#move_to_today
" {{{

fun! calendar#action#move_to_today()
  if calendar#buffer#in_buffer()
    call search('\*\zs\d\{1,2}\ze', 'cw')
  endif
endfun

" }}}



"
" move_to_nnday
" {{{

fun! move_to_nnday(count)
  if calendar#buffer#in_buffer()
    call search('\*\zs\d\{1,2}\ze', 'cw')
  endif

nndfun

" }}}







" vim: set foldmethod=marker
