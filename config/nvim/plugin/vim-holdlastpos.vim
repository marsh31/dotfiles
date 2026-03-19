" NAME:   vim-holdlastpos
" AUTHOR: marsh
"
" NOTE:
"
"



" let s:log = LogConfig("hold_last_pos")
" call s:log.debug("OK", "-- HoldLastPositionStart --")


"
" HoldLastPositionStart
" {{{

fun! HoldLastPositionStart() abort
  " call s:log.info("OK", printf("(%4s) -- HoldLastPositionStart --", bufnr()))
  call HoldLastPosConfig(1000)
  call b:hold_last_pos_config.Start()
endfun

" }}}


"
" HoldLastPositionStop
" {{{

fun! HoldLastPositionStop() abort
  " call s:log.info("OK", printf("(%4s) -- HoldLastPositionStop --", bufnr()))
  call b:hold_last_pos_config.Stop()
endfun

" }}}


"
" HoldLastPositionState
" {{{

fun! HoldLastPositionState() abort
  " call s:log.info("OK", printf("(%4s) -- HoldLastPositionState --", bufnr()))
  if exists("b:hold_last_pos_config")
    if b:hold_last_pos_config.timer_handler == 0
      echomsg "Not Running"

    else
      echomsg "Running"

    endif
  else
    echomsg "HoldLastPosition Not Initialized"
  endif
endfun

" }}}



let s:HoldLastPosConfig = {
      \ "bufnr": -1,
      \ "timer_handler": 0,
      \ "timer_ms": 0,
      \ "filename": "",
      \ "timestamp": 0,
      \ }


"
" HoldLastPosConfig
" {{{

fun! HoldLastPosConfig(wait) abort
  " call s:log.info("OK", printf("(%4s) -- HoldLastPositionConstructor --", bufnr()))
  if !exists("b:hold_last_pos_config")
    " call s:log.debug("OK", printf("(%4s) b:hold_last_pos_config not exists", bufnr()))
    let b:hold_last_pos_config = deepcopy(s:HoldLastPosConfig)
    let b:hold_last_pos_config.bufnr = bufnr()
    let b:hold_last_pos_config.timer_ms = a:wait
    let b:hold_last_pos_config.filename = expand('%:p')
  endif
  return b:hold_last_pos_config
endfun

" }}}


" HoldLastPosConfig.Start
" {{{

fun! s:HoldLastPosConfig.Start() abort
  " call s:log.info("OK", printf("(%4s) -- HoldLastPosConfig.Start --", bufnr()))
  " call s:log.debug("OK", printf("(%4s) handler: %s", bufnr(), self.timer_handler))

  call self.Do()
  if self.timer_handler == 0
    " call s:log.debug("OK", printf("(%4s) set timer handler", bufnr()))
    let self.timer_handler = timer_start(self.timer_ms, {t ->
          \ self.Do()
          \ },
          \ {'repeat': -1})
    " call s:log.debug("OK", printf("(%4s) handler: %s", bufnr(), self.timer_handler))
  endif
endfun

" }}}


" HoldLastPosConfig.Stop
" {{{

fun! s:HoldLastPosConfig.Stop() abort
  " call s:log.info("OK", printf("(%4s) -- HoldLastPosConfig.Stop --", bufnr()))
  " call s:log.debug("OK", printf("(%4s) handler: %s", bufnr(), self.timer_handler))
  if self.timer_handler != 0
    call timer_stop(self.timer_handler)
    unlet self.timer_handler
    let self.timer_handler = 0
    " call s:log.debug("OK", printf("(%4s) handler: %s", bufnr(), self.timer_handler))
  endif
endfun

" }}}



"
" s:HoldLastPosConfig.Do
" {{{

fun! s:HoldLastPosConfig.Do() abort
  if self.timestamp != getftime(self.filename)
    " call s:log.info("OK", printf("(%4s) -- HoldLastPosConfig.Do --", bufnr()))
    call execute(printf('checktime %s', self.bufnr))

    let change_winids = []
    for winid in win_findbuf(self.bufnr)
      if line('.', winid) == line('$', winid)
        call add(change_winids, winid)
      endif
    endfor

    for winid in change_winids
      call win_execute(winid, 'normal! Gzb')
    endfor
  endif

  let self.timestamp = getftime(self.filename)
endfun

" }}}


" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
