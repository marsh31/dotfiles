
" 
" qfFileName     xxx match /^[^|]*/  nextgroup=qfSeparator
"                    links to Directory
" qfSeparator    xxx match /|/  contained nextgroup=qfLineNr
"
" qfLineNr       xxx match /[^|]*/  contained contains=qfError
"                    links to LineNr
" qfError        xxx match /error/  contained
"                    links to Error
"
"
"
"  a:info
"    quickfix   quickfix リストを呼ぶときは1が設定され、location リストのときは0が設定される。
"    winid      location リストの時、そのウィンドウIDが設定される。quickfixリストの時、0が設定される。
"               getloclist() で location リストの項目を取得するのに使える。
"    id         quickfix か location リストの識別子
"    start_idx  返されたテキストの最初の項目のインデックス
"    end_idx    返されたテキストの最後の項目のインデックス
" 
" test. test
" this is test
"
" test line.
"



" call setqflist([], ' ', {'lines' : v:oldfiles, 'efm' : '%f', 'quickfixtextfunc' : 'QfOldFiles'})
func! QfOldFiles(info)
  " quickfix の項目の対象範囲から情報を取得する
  let l = []
  let items = getqflist({'id' : a:info.id, 'items' : 1}).items

  for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
    " use the simplified file name
    let bufnr    = printf('%4d', items[idx].bufnr)
    let filename = printf('%-32s', fnamemodify(bufname(items[idx].bufnr), ':p:t'))
    let lnum_col = printf('%5d %5d', items[idx].lnum, items[idx].col)
    let text     = items[idx].text

    let msg      = printf("%s %s | %11s | %s", bufnr, filename, lnum_col, text)
    call add(l, msg)
  endfor
  return l
endfunc

set quickfixtextfunc=QfOldFiles



