" NAME:   vim-throttle
" AUTHOR: marsh
"
" NOTE:
"
"

if exists('loaded_vim_throttle')
  finish
endif
let g:loaded_vim_throttle = 1


" s:throttle_timers {{{
"
" {
"   "<function name>" : {
"     "timer": timer handler
"     "count": 0
"   }
" }
"

let s:throttle_timers = {}

" }}}


" 
" Throttle
"
" {{{

function! Throttle(fn, wait, args = []) abort
  let timer_name = string(a:fn)
  if count(keys(s:throttle_timers), timer_name) > 0
    let count = s:throttle_timers[timer_name]["count"]
    let s:throttle_timers[timer_name]["count"] = count + 1
    return
  endif

  call s:throttle_fire(a:fn, a:args)
  let s:throttle_timers[timer_name] = {
        \ "timer": timer_start(a:wait, {t -> [
        \     s:throttle_fire(a:fn, a:args),
        \     execute('unlet! s:throttle_timers[timer_name]'),
        \   ]},
        \   {'repeat': 1}),
        \ "count": 0,
        \ }
endfunction

" }}}

function! s:throttle_fire(fn, args) abort
  let timer_name = string(a:fn)
  if count(keys(s:throttle_timers), timer_name) == 0
    call call(a:fn, a:args)
    return
  endif

  let data = s:throttle_timers[timer_name]
  if data["count"] > 0
    call call(a:fn, a:args)
  endif
endfunction

" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker :
