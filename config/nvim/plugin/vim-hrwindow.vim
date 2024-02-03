


command! TestStart           :call s:open_buffer()
command! TestStop            :call s:test_stop()


let s:timer_time_ms = 100
let s:timer_count   = 0

let s:timer_id = 0
let s:start_wid = 0
let s:buffer_wid  = 0
let s:bufname = '[hrwindow]'

function! s:open_buffer()
  augroup plugin_hrwindow
    autocmd! * <buffer>

    exec "autocmd FileType " .. s:bufname .. " echomsg 'FileType'"
    exec printf("autocmd BufNewFile %s echomsg 'BufNewFile'", s:bufname)

  augroup END
  exec '5new ' .. s:bufname


  let s:buffer_wid = win_getid(winnr())
  let s:timer_id = timer_start(s:timer_time_ms, 'UpdateBuffer', { 'repeat': -1 })
endfunction


function! s:test_stop()
  call timer_stop(s:timer_id)
endfunction


" deletebufline({buf}, {first} [, {last}])
"   {first} ~ {last}を含む行をバッファから削除する。
"   バッファが省略されていた場合は、{first}行だけを削除する。
"   これは、ロード されたバッファにたいしてのみ機能する。
"   必要であれば、最初に bufload を呼び出すこと。
"
"   {buf} 
" getbufline
" setbufline
function! UpdateBuffer(timer)
  let s:start_wid = win_getid(winnr())
  call win_gotoid(s:buffer_wid)

  let s:timer_count = s:timer_count + 1
  if s:timer_count > 1000
    let s:timer_count = 0
  endif

  %delete _
  exec "normal! A> " .. s:timer_count

  call win_gotoid(s:start_wid)
endfunction


