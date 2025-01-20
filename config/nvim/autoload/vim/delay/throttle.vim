" NAME:   throttle
" AUTHOR: marsh
"
" NOTE:
"
"

" s:throttle_timers
" {
"   "<function name>" : {
"     "timer": timer handler,
"     "count": 0
"   }
" }
" {{{

let s:throttle_timers = {}

" }}}


" 
" Throttle
"   Throttleを稼働させるIF関数。
"   1 引数 a:fn     発火させる関数名、もしくは関数のfuncref値。
"   2 引数 a:wait   発火させる関数の待ち時間。
"   3 引数 a:first  最初の一回目を発火させるか、待機するか。
"   4 引数 a:args   発火させる関数の引数。
"
" もし、s:throttle_timers に関数が登録されていた場合、関数名のメンバに対してカウントを１上げる。
" s:throttle_timers に関数が登録されていない場合、
" 最初の一回を発火させる場合は、発火させる。
" 最初の一回を発火させない場合は、次回のタイマ起動時に繰り越すため、カウンタを１上げてその状態でカウンタを初期化する。
" {{{

fun! vim#delay#throttle#set(fn, wait, args = [], first = v:true) abort
  let timer_name = string(a:fn)
  let config = get(s:throttle_timers, timer_name, {})
  if config != {}
    let s:throttle_timers[timer_name].count = config.count + 1
    return
  endif

  let count = 0
  if a:first
    call call(a:fn, args)
  else
    let count = 1
  endif

  let s:throttle_timers[timer_name] = {
        \ "timer": timer_start(a:wait, {-> s:throttle_fire(a:fn, a:args) }),
        \ "count": count,
        \ }
endfun

" }}}


" 
" s:throttle_fire
" Throttleに渡された関数を発火させる関数。
" s:throttle_timers に 関数が登録されていない場合は、即座に発火する。
" 関数が登録されている場合は、イベントのカウント数が０より大きいとき発火する。
" {{{

fun! s:throttle_fire(fn, args) abort
  let timer_name = string(a:fn)
  let config = get(s:throttle_timers, timer_name, {})
  if config != {} && config.count > 0
    call call(a:fn, ([ config.count ] + a:args))
  endif

  unlet! s:throttle_timers[timer_name]
endfun

" }}}


" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker :
