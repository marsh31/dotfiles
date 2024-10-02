
let g:last_timer = 0

function! MyGreadFunction(...)
  echomsg a:000
  echomsg bufnr()
endfunction

function! On_last_event(callback)
  call timer_stop(g:last_timer)
  let g:last_timer = timer_start(200, a:callback)
endfunction


function! s:init()

  augroup WinSizeFixed
    autocmd! WinResized * call On_last_event('MyGreadFunction')
  augroup END

endfunction

