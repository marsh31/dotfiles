" NAME:   stopwatch
" AUTHOR: marsh
"
" NOTE:
" 
" TODO:
"   - [ ] vim#stopwatch#info で取得できる情報が経過時間だけだが、他情報も出す。
" 

" s:stopwatch_configs                                             {{{
" {
"   "id": {
"     "base":    [ 0, 0 ], // 計測の起点
"     "elapsed": 0,        // 経過時間
"     "is_run":  1         // 0 or 1, 1 is running, 0 is pause
"   }
" }

let s:stopwatch_configs = {}

" }}}
" vim#stopwatch#start                                           {{{

fun! vim#stopwatch#start(id) abort
  if s:has_id(a:id)
    return a:id
  endif

  let s:stopwatch_configs[a:id] = {
        \ "base": reltime(),
        \ "elapsed": 0,
        \ "is_run": 1,
        \ }
  return a:id
endfun

" }}}
" s:has_id                                                      {{{
"
" | id is empty | has key | id is not empty | id is not empty and has key |
" | true        | true    | false           | false                       |
" | true        | false   | false           | false                       |
" | false       | true    | true            | true                        |
" | false       | false   | true            | false                       |

fun! s:has_id(id) abort
  if !empty(a:id) && has_key(s:stopwatch_configs, a:id)
    return v:true
  endif
  return v:false
endfun

" }}}
" vim#stopwatch#pause                                           {{{

fun! vim#stopwatch#pause(id) abort
  if s:has_id(a:id)
    call s:update_elapsed(a:id)
    let s:stopwatch_configs[a:id].is_run = 0
    return v:true
  endif
  return v:false
endfun

" }}}
" s:update_elapsed                                              {{{

fun! s:update_elapsed(id) abort
  let l:config = s:stopwatch_configs[a:id]
  if l:config.is_run ==# 1
    let s:stopwatch_configs[a:id].elapsed = l:config.elapsed + reltimefloat(reltime(l:config.base))
    let s:stopwatch_configs[a:id].base = reltime()
  endif
endfun

" }}}
" vim#stopwatch#restart                                         {{{

fun! vim#stopwatch#restart(id) abort
  if s:has_id(a:id)
    let s:stopwatch_configs[a:id].base = reltime()
    let s:stopwatch_configs[a:id].is_run = 1
    return v:true
  endif
  return v:false
endfun

" }}}
" vim#stopwatch#stop                                            {{{

fun! vim#stopwatch#stop(id) abort
  if s:has_id(a:id)
    call s:update_elapsed(a:id)
    let elapsed = s:stopwatch_configs[a:id].elapsed

    unlet s:stopwatch_configs[a:id]
    return elapsed
  endif
  return 0
endfun

" }}}
" vim#stopwatch#info                                            {{{

fun! vim#stopwatch#info(id) abort
  if s:has_id(a:id)
    call s:update_elapsed(a:id)
    let elapsed = s:stopwatch_configs[a:id].elapsed
    return elapsed
  endif
  return 0
endfun

" }}}


" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
