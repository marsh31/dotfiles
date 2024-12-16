" NAME:   vim-sample.vim
" AUTHOR: marsh
" サンプルのコマンドとか、テストコンフィグを追加。
"

com! -range -nargs=1 OrderNum  call setline('.', map(range(<line1>, <line2>), 'printf(<f-args>, v:val)'))


function! Default_sample(fn, wait, args = []) abort
  echo a:fn a:wait a:args
endfunction


com! -nargs=+ Calendar call s:calendar(<f-args>)

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
  let Y2 = float2nr(y/100)
  let Y = y % 100
  let Yper4 = float2nr(Y/4)
  let xx = float2nr(-2*Y2+float2nr(Y2/4))
  let res = (a:day + s:magic_26m1per10[a:month-1] + Y + Yper4 + xx) % 7

  if res <= 0
    let res = res + 7
  endif
  return res
endfunction


let s:each_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
function s:daysOfManth(year, month)
  let days = 31
  if a:month == 2
    if ((a:year % 400 == 0) || (a:year % 4 == 0) && (a:year != 0))
      let days = s:each_days[a:month-1] + 1
    else
      let days = s:each_days[a:month-1]
    endif
  else
    let days = s:each_days[a:month-1]
  endif
  return days
endfunction

function! s:calendar(year, month) abort
  let weekno = s:date2weekno(a:year, a:month, 1)
  let days = s:daysOfManth(a:year, a:month)

  execute "normal! A Sun Mon Tue Wed Thu Fri Sat"
  execute "normal! o"
  let blank = "    "
  for i in range(1, weekno-1)
    execute "normal! A" .. blank
  endfor

  let start = weekno
  let fin = v:false
  let day = 1
  while v:true
    for i in range(start, 7)
      execute "normal! A" .. printf("%4d", day)

      let day = day + 1
      if day > days
        let fin = v:true
        break
      endif
    endfor
    let start = 1

    if fin
      break
    endif
    execute "normal! o"
  endwhile
endfunction


command! -bar TimerStart let start_time = reltime()
command! -bar TimerNow   echo reltimestr(reltime(start_time))
command! -bar TimerEnd   echo reltimestr(reltime(start_time)) | unlet start_time


function! s:disp(timer)
  echo "callback"
endfunction
command! -nargs=1 IntervalTimerStart call timer_start(1000 * 60 * str2nr(<f-args>), function("s:disp"))





