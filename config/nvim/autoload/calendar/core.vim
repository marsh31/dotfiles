" NAME:   autoload/calendar/core.vim
" AUTHOR: marsh
"
" Calendarとしてのコア機能、ロジック、計算をまとめる。


" calendar#core#get_month_info
" {{{

let s:calendar_month_info_no_leap_year = [
        \ [ 0,  0,   '---'],
        \ [ 31, 1,   'Jan'],
        \ [ 28, 32,  'Feb'],
        \ [ 31, 60,  'Mar'],
        \ [ 30, 91,  'Apr'],
        \ [ 31, 121, 'May'],
        \ [ 30, 152, 'Jun'],
        \ [ 31, 182, 'Jul'],
        \ [ 31, 213, 'Aug'],
        \ [ 30, 244, 'Sep'],
        \ [ 31, 274, 'Oct'],
        \ [ 30, 305, 'Nov'],
        \ [ 31, 335, 'Dec']
        \ ]

let s:calendar_month_info_leap_year = [
        \ [ 0,  0,   '---'],
        \ [ 31, 1,   'Jan'],
        \ [ 29, 33,  'Feb'],
        \ [ 31, 61,  'Mar'],
        \ [ 30, 92,  'Apr'],
        \ [ 31, 122, 'May'],
        \ [ 30, 153, 'Jun'],
        \ [ 31, 183, 'Jul'],
        \ [ 31, 214, 'Aug'],
        \ [ 30, 245, 'Sep'],
        \ [ 31, 275, 'Oct'],
        \ [ 30, 306, 'Nov'],
        \ [ 31, 336, 'Dec']
        \ ]

fun! calendar#core#get_month_info(year)
  if calendar#core#is_leap_year(a:year)
    return s:calendar_month_info_leap_year
  else
    return s:calendar_month_info_no_leap_year
  endif
endfun

" }}}


" get_today
" 今日の年、月、日をそれぞれ数字で配列に格納して返す。
" return
"   array: array of string
" {{{
fun! calendar#core#get_today()
  return [ str2nr(strftime('%Y')), str2nr(strftime('%m')), str2nr(strftime('%d')) ]
endfun

" }}}

"
" calendar#core#is_leap_year
" うるう年の計算
" {{{

fun! calendar#core#is_leap_year(year) 
  let is_leap = v:false
  if ((a:year % 400 == 0) || (a:year % 4 == 0) && (a:year != 0))
    let is_leap = v:true
  endif
  return is_leap
endfun

" }}}



" zeller's congruence
"
" arg
"   year:  year 
"   month: month 1-12
"   day:   day 1-n
"
" h = (d + 26(m+1) / 10 + Y + int( Y / 4 ) - 2 * y / 100 + y / 400) mod 7
"      ^   ^^^^^^^^^^^^                    ^^^^^^^^^^^^^^^^^^^^^^^
"          magic_26m1per10  
"
" return h
"  1: Mon, 2: Tue, 3: Wed, 4: Thu, 5: Fri, 6: Sat, 0: Sun
" {{{
fun! calendar#core#zellers_congruence(year, month, day) abort
  let magic_26m1per10 = [ 1, 4, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5]
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
  let res = ((a:day + magic_26m1per10[a:month-1] + Y + Yper4 + xx + 5) % 7 + 1) % 7
  if res <= 0
    let res = (res + 7) % 7
  endif
  
  return res
endfun

" }}}



"
" calendar#core#get_weeks_in_month
" {{{

fun! calendar#core#get_weeks_in_month(year, month)
  let weekday = str2nr(strftime('%w', strptime('%Y-%m-%d', printf('%04d-%02d-01', a:year, a:month))))
  let days_in_month = calendar#core#get_month_info(a:year)[a:month][0]

  return float2nr(ceil((weekday + days_in_month) / 7.0))
endfun

" }}}


" vim: set nowrap foldmethod=marker :
