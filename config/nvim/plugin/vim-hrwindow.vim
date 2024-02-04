" >   11: buffer = 0
" open -> jump other
" BufAdd
" BufCreate
" BufNewFile
" BufEnter
" BufLeave
" WinLeave
"
" open -> close
" BufAdd
" BufCreate
" BufNewFile
" BufEnter
" BufLeave
" WinLeave
" BufHidden 
"
" enter -> leave
" WinEnter
" BufEnter
" BufLeave
" WinLeave
"
"




command! TestStart           :call s:open_buffer()
command! TestStop            :call s:test_stop()


let s:timer_time_ms = 100
" let s:timer_id = 0

let s:bufname   = '[hrwindow]'
let s:bufnr     = 0


let s:timer_count   = 0

augroup plugin_hrwindow
  autocmd! *

  autocmd FileType     \[hrwindow]   setlocal ft=hrwindow

  autocmd BufEnter     \[hrwindow]   call s:enter_buffer()
  autocmd BufHidden    \[hrwindow]   call s:hide_buffer()

augroup END

function! s:open_buffer()
  exec '5new ' .. s:bufname

endfunction


function! s:test_stop()
  call timer_stop(s:timer_id)
endfunction














" backend function


"
" call BufEnter Event
"
function! s:enter_buffer()
  echomsg "Enter Buffer"

  if ! exists("s:timer_id")
    call s:init_buffer()
  endif
endfunction


"
" call BufEnter Event AND unhidden buffer
"
function! s:init_buffer()
  echomsg "Init Buffer. call updater"
  let s:timer_id = timer_start(s:timer_time_ms, 'UpdateBuffer', { 'repeat': -1 })
  let s:bufnr    = bufnr()
endfunction


"
" call BufHidden Event
"
function! s:hide_buffer()
  echomsg "Hide Buffer. stop updater"
  call timer_stop(s:timer_id) | unlet s:timer_id
endfunction


function! UpdateBuffer(timer)
  echomsg "update"
  let s:timer_count = s:timer_count + 1
  if s:timer_count > 1000
    let s:timer_count = 0
  endif

  call setbufline(s:bufnr, 1, printf("> %4d: buffer = %d", s:timer_count, s:bufnr))
endfunction


