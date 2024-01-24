" NAME:   vim-sample.vim
" AUTHOR: marsh
" サンプルのコマンドとか、テストコンフィグを追加。
"

com! -range -nargs=1 OrderNum  call setline('.', map(range(<line1>, <line2>), 'printf(<f-args>, v:val)'))




com! Calendar call s:calendar()

let s:magic_26m1per10 = [ 1, 4, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5]
function! s:date2weekno(year, month, day)
  " h = (d + 26(m+1) / 10 + Y + int( Y / 4 ) - 2 * y / 100 + y / 400) mod 7
  "      ^   ^^^^^^^^^^^^                    ^^^^^^^^^^^^^^^^^^^^^^^
  "          magic_26m1per10  
  let y = a:year
  let m = a:month
  if m == 1 || m == 2
    let m = m + 12
    let y = y - 1
  endif
  let Y2 = float2nr(ceil(y/100))
  let Y = y % 100
  let Yper4 = float2nr(ceil(Y/4))
  let xx = float2nr(ceil(-2*Y2+ceil(Y2/4)))
  return (a:day + s:magic_26m1per10[a:month-1] + Y + Yper4 + xx) % 7
endfunction

function! s:calendar() abort
  let opener = "vsplit"
  let filename = "calendar"
  " noautocmd hide execute opener filename

  echo s:date2weekno(2024, 1, 24)
endfunction
