
let s:jobid = 0
let s:matchlist = []

fun! QfFiles#start()
  call s:reset_handler()
  let s:jobid = ripgrep#job#start('--files', '.', {
        \ 'reset':     function('s:reset_handler'),
        \ 'on_stdout': function('s:stdout_handler'),
        \ 'on_stderr': function('s:stderr_handler'),
        \ 'on_exit':   function('s:exit_handler'),
        \ })

  if s:jobid <= 0
    echoerr 'Failed to be call ripgrep'
  endif
endfun


fun! s:reset_handler() abort
  let s:matchlist = []
endfun


fun! s:stdout_handler(id, data, event_type)
  for l:line in a:data
    call add(s:matchlist, l:line)
  endfor
endfun


fun! s:stderr_handler(id, data, event_type)
  echomsg "error"
endfun


fun! s:exit_handler(id, data, event_type) abort
  call setqflist([], ' ', {
        \ 'context': 'QfFiles',
        \ 'lines':   s:matchlist,
        \ 'efm':     '%f',
        \ 'quickfixtextfunc': 'QfFiles#qftextfunc',
        \ })
endfun


fun! QfFiles#qftextfunc(info)
  " quickfix の項目の対象範囲から情報を取得する
  let items = getqflist({'id' : a:info.id, 'items' : 1}).items
  let l = []
  for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
    " ファイル名をシンプルにして利用する
    call add(l, fnamemodify(bufname(items[idx].bufnr), ':p:.'))
  endfor
  return l
endfun
