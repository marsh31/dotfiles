
let s:what = {
      \ 'lines':            v:oldfiles,
      \ 'efm':              '%f',
      \ 'quickfixtextfunc': 'QfOldfiles#qftextfunc'
      \ }

fun! QfOldfiles#open()
  call setqflist([], ' ', s:what)
endfun

fun! QfOldfiles#qftextfunc(info)
  " quickfix の項目の対象範囲から情報を取得する
  let items = getqflist({'id' : a:info.id, 'items' : 1}).items
  let l = []
  for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
    " ファイル名をシンプルにして利用する
    call add(l, fnamemodify(bufname(items[idx].bufnr), ':p:.'))
  endfor
  return l
endfun



