" NAME:   pomodoro
" AUTHOR: marsh
"
" NOTE:
" 

" config {{{

let s:pomodoro_config_index = 0
let s:pomodoro_current_type = 'wait'
let s:pomodoro_config = [
      \ { 'name': 'work', 'time': [ 0, 20, 0 ] },
      \ { 'name': 'rest', 'time': [ 0,  5, 0 ] },
      \ { 'name': 'work', 'time': [ 0, 20, 0 ] },
      \ { 'name': 'rest', 'time': [ 0,  5, 0 ] },
      \ { 'name': 'work', 'time': [ 0, 20, 0 ] },
      \ { 'name': 'rest', 'time': [ 0, 15, 0 ] },
      \ ]

let s:pomodoro_stopwatch_id = 'pomodoro'

let s:pomodoro_timer_id = 0
let s:pomodoro_timer_ms = 0
let s:pomodoro_is_run   = v:false

let s:HOUR_MS = 60 * 60 * 1000
let s:MIN_MS  = 60 * 1000
let s:SEC_MS  = 1000


" }}}
" vim#pomodoro#routine                                          {{{

fun! vim#pomodoro#routine() abort
  if s:pomodoro_config_index >= len(s:pomodoro_config)
    tabnew
    normal! AAll routine finish!!
    return
  endif

  let l:config = s:pomodoro_config[s:pomodoro_config_index]

  call vim#pomodoro#start(config.time[0], config.time[1], config.time[2])
  let s:pomodoro_current_type = config.name

  let s:pomodoro_config_index += 1
endfun

" }}}
" vim#pomodoro#start                                            {{{

fun! vim#pomodoro#start(hour, min, sec) abort
  if s:pomodoro_is_run()
    call vim#pomodoro#stop()
  endif

  let s:pomodoro_timer_ms = (a:hour * s:HOUR_MS) + (a:min * s:MIN_MS) + (a:sec * s:SEC_MS)
  let s:pomodoro_timer_id = timer_start(1000, 'vim#pomodoro#run', { 'repeat': -1 })
  call vim#stopwatch#start(s:pomodoro_stopwatch_id)
endfun

" }}}
" s:pomodoro_is_run                                             {{{

fun! s:pomodoro_is_run() 
  return s:pomodoro_timer_id > 0
endfun

" }}}
" vim#pomodoro#stop                                             {{{

fun! vim#pomodoro#stop() abort
  if s:pomodoro_is_run()
    call timer_stop(s:pomodoro_timer_id)
    call vim#stopwatch#stop(s:pomodoro_stopwatch_id)
  endif

  let s:pomodoro_timer_id = 0
  let s:pomodoro_timer_ms = 0
  let s:pomodoro_is_run = v:false
endfun

" }}}
" vim#pomodoro#pause                                            {{{

fun! vim#pomodoro#pause() abort
  if s:pomodoro_is_run()
    let s:pomodoro_is_run = v:false
    call vim#stopwatch#pause(s:pomodoro_stopwatch_id)
    call timer_pause(s:pomodoro_timer_id, 1)
  endif
endfun

" }}}
" vim#pomodoro#restart                                          {{{

fun! vim#pomodoro#restart() abort
  if !s:pomodoro_is_run()
    call timer_pause(s:pomodoro_timer_id, 0)
    call vim#stopwatch#restart(s:pomodoro_stopwatch_id)
    let s:pomodoro_is_run = v:true
  endif
endfun

" }}}
" vim#pomodoro#info                                             {{{

fun! vim#pomodoro#info() abort
  if s:pomodoro_is_run()
    let l:remaining_ms = s:pomodoro_timer_ms - float2nr(round(vim#stopwatch#info(s:pomodoro_stopwatch_id) * 1000))
    let l:remaining_hour = l:remaining_ms / s:HOUR_MS
    let l:remaining_min =  (l:remaining_ms % s:HOUR_MS) / s:MIN_MS
    let l:remaining_sec =  (l:remaining_ms % s:MIN_MS) / s:SEC_MS
    return {
          \ "id": s:pomodoro_timer_id,
          \ "timer": s:pomodoro_timer_ms,
          \ "type" : s:pomodoro_current_type,
          \ "remaining": l:remaining_ms,
          \ "remaining_hour": l:remaining_hour,
          \ "remaining_min":  l:remaining_min,
          \ "remaining_sec":  l:remaining_sec,
          \ }

  else
    return {}
  endif
endfun

" }}}
" vim#pomodoro#run                                              {{{

fun! vim#pomodoro#run(t) abort
  let info = vim#pomodoro#info()
  if info.remaining <= 0
    echomsg $'{s:pomodoro_current_type} Fin'
    call vim#pomodoro#stop()
    tabnew
    normal! Afinish!!

    call vim#pomodoro#routine()
  endif
endfun

" }}}

" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
