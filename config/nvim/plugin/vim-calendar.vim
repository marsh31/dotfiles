

command! -nargs=* CaleTest1 call <SID>show(2024, 9, 6)
command! -nargs=* CaleTest2 call <SID>show(2024, 8, 6)
command! -nargs=* CaleAction call <SID>action()


let s:directionN = 0
let s:directionH = 1
let s:directionT = 2
let s:directionV = 3
let s:window_name = "Calendar"

let s:window_dir_current = 0
let s:window_dir_left    = 1
let s:window_dir_right   = 2
let s:window_dir_bottom  = 3
let s:window_dir_top     = 4
let s:window_dir_tab     = 5

let s:window_partition   = '	'    " tab char

let s:calendar_days = [
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

let s:macro_word = ['<Prev', 'Today', 'Next>' ]
let s:macro_function = {
      \ "<Prev": "JumpPreviousMonth",
      \ "Next>": "JumpNextMonth",
      \ "Today": "JumpToday"
      \ }


let s:pre_hook  = ""
let s:post_hook = ""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:action()
  let [cbuf, clnum, ccol, coff]  = getpos('.')
  let cWORD = expand('<cWORD>')

  if cWORD =~ '\*\d\{1,2\}'
    echo "today"

  elseif cWORD =~ '\d\{1,2\}'
    for view in b:calendar_views
      if view.cols <= ccol && ccol <= view.cole
        echo printf("%s/%s/%s", view.year, view.month, cWORD)
      endif
    endfor

  else
    echo cWORD

  endif

endfunction


function! s:show(year, month, forward)

  call s:try_call(s:pre_hook)

  let [buffer, calendar_views] = s:make_calendar_buffer(a:year, a:month, a:forward)
  call Init_window(s:window_dir_bottom)
  call s:init_buffer_config()
  call s:init_syntax()
  call s:setup_buffer(buffer)

  let b:calendar_views = calendar_views

  hi! def link  CalNavi      Type
  hi! def link  WeekS2       Type

  hi!           CalHeader    guifg=#fdac54 ctermfg=178 " 
  hi!           CalSaturday  guifg=#0086CC ctermfg=25  " 
  hi!           CalSunday    guifg=#E2421F ctermfg=196 " 紅葉色
  hi!           CalToday     guifg=#BB42F6

  hi! def link  CalWSun      CalSunday
  hi! def link  CalWSat      CalSaturday

  nnoremap <buffer><nowait> q :<C-u>bd!<CR>
  nnoremap <buffer><nowait> <CR> :<C-u>CaleAction<CR>

  call s:try_call(s:post_hook)

endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local Functions
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! s:try_call(func)
  try
    let res = function(a:func)()
  catch
    let res = v:false
  endtry

  return res
endfunction


" setup_buffer
" 
" バッファの設定を行う。
function! s:setup_buffer(buffer)
  call setline(1, a:buffer)
  setlocal nomodifiable
endfunction


" make_iso_wk_num
"
" ISO式週番号を返す。
function! MakeISOWKNum(year, month, day)
  let sumday = (s:calendar_days[a:month][1] + a:day) - 1

  if s:is_leap_year(a:year) && a:month >= 2
    let sumday = sumday + 1
  endif

  let isowk = (s:zellers_congruence(a:year, 1, 1) + 6) % 7

  let total = (sumday + isowk)
  let result = total / 7 + (total % 7 + 6) / 7

  if isowk >= 4
    let result = result - 1
  endif
  
  if result < 1
    let result = MakeISOWKNum(a:year - 1, 12, 31)
  endif
  return result
endfunction


" make_usa_wk_num
"
" USA式週番号を返す。
function! MakeUSAWKNum(year, month, day)
  let sumday = (s:calendar_days[a:month][1] + a:day) - 1

  if s:is_leap_year(a:year) && a:month >= 2
    let sumday = sumday + 1
  endif

  let total = (sumday + s:zellers_congruence(a:year, 1, 1))
  let result = total / 7 + (total % 7 + 6) / 7
  return result
endfunction


" init_window
"
" ウィンドウを作成する。
function! Init_window(dir)
  let calendar_bufnr = bufnr('^' . s:window_name . '$')
  let calendar_winnr = bufwinnr(calendar_bufnr)

  if calendar_winnr >= 0
    exe printf('%s wincmd w', calendar_winnr)
    setlocal modifiable
    silent %d_

  else
    if     a:dir == s:window_dir_current
      silent exec printf('edit %s', s:window_name)
      setlocal winfixheight

    elseif a:dir == s:window_dir_left
      silent exec printf('to %s vsplit %s', 10, s:window_name)
      setlocal winfixheight

    elseif a:dir == s:window_dir_right
      silent exec printf('bo %s vsplit %s', 10, s:window_name)
      setlocal winfixheight

    elseif a:dir == s:window_dir_bottom
      silent exec printf('bo %s split %s', 10, s:window_name)
      setlocal winfixheight

    elseif a:dir == s:window_dir_top
      silent exec printf('to %s split %s', 10, s:window_name)
      setlocal winfixheight

    elseif a:dir == s:window_dir_tab
      silent exec printf('tabnew %s', s:window_name)

    endif
  endif

  let b:calendar_windir = a:dir
endfunction



" init_buffer_config
"
" バッファの初期設定を行う。
function! s:init_buffer_config()
  setlocal noswapfile
  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal nowrap
  setlocal norightleft
  setlocal noexpandtab
  setlocal modifiable
  setlocal nolist
  setlocal conceallevel=1
  setlocal concealcursor=nvic
  setlocal ft=__calendar__
endfunction



" init_syntax
"
" カレンダーバッファのシンタックスを設定する。
function! s:init_syntax()
  syn keyword   CalWSun     Su
  syn keyword   CalWSat     Sa

  syn match     CalBar                / \?| \?/
  syn match     CalNavi     display   '\(<Prev\|Today\|Next>\)'
  syn match     CalHeader   display   '[^ ]*\d\+\/\d\+([^)]*)'

  syn match     CalSaturday display   '|.\{18}\s\([0-9\ ]\d\)'hs=e-1 contains=ALL
  syn match     CalSunday   display   '|\s\([0-9\ ]\d\)'hs=e-1       contains=ALL
  syn match     CalToday    display   '\*\d\{,2\}'                   contains=ALL

  syn match     CalWK        contained /\t\(WK\d\d\)/
  syn match     CalToday     contained /\(\*\d\d\| \*\d\)/
  syn match     CalSunday    contained /\t\(WK\d\d\)\?\( \d\d\|  \d\)/                     contains=CalWK,CalToday
  syn match     CalSaturday  contained /\t\(WK\d\d\)\?.\{18\}\s\([0-9\ ]\d\)/hs=e-1        contains=CalSunday,CalWK,CalToday

  syn match     CalWeek                /\t\(WK\d\d\)\?\([\* ]\d\d\| [\* ]\d\|   \)\{7\}/   contains=CalWK,CalSunday,CalSaturday,CalToday
endfunction


" make_calendar_buffer
"
" args
"   year
"   month
"   forward
"
" return
"   buffer         カレンダーのバッファに書くデータ
"   calendar_views カレンダーの情報
function! s:make_calendar_buffer(year, month, forward) abort
  if a:month < 1 || 12 < a:month
    echoe "Error: month is less than 0 or bigger than 12."
    return
  endif
  let year = a:year
  let month = a:month

  let mh = ''
  let mwlh = ''
  let mw1 = ''
  let mw2 = ''
  let mw3 = ''
  let mw4 = ''
  let mw5 = ''
  let mw6 = ''

  let buffer = []
  call add(buffer, '	 ' . join(s:macro_word, ' '))
  call add(buffer, '')

  let calendar_views = []

  let add_count = 0
  let prev_lenght = 1
  while add_count < a:forward
    let mh   = mh   . s:make_month_head(year, month)
    let mwlh = mwlh . s:make_day_of_the_week_head()
    let mw1  = mw1  . s:make_line_of_month(year, month, 1)
    let mw2  = mw2  . s:make_line_of_month(year, month, 2)
    let mw3  = mw3  . s:make_line_of_month(year, month, 3)
    let mw4  = mw4  . s:make_line_of_month(year, month, 4)
    let mw5  = mw5  . s:make_line_of_month(year, month, 5)
    let mw6  = mw6  . s:make_line_of_month(year, month, 6)

    let view = {
          \ "year":  year,
          \ "month": month,
          \ "cols":  prev_lenght,
          \ "cole":  len(mw1),
          \ }
    call add(calendar_views, view)

    let prev_lenght = len(mw1) + 1
    let add_count = add_count + 1
    let month = month + 1
    if month > 12
      let month = 1
      let year = year + 1
    endif
  endwhile
  call extend(buffer, [mh, mwlh, mw1, mw2, mw3, mw4, mw5, mw6])

  return [buffer, calendar_views]
endfunction


" make_line_of_month
"
" arg
"   year  number
"   month number
"   week  number the number of week of the month
" 
" return
"   buffer: string
"
" 年と月とその第何周かを指定してその週の文字列を返す。
" 
function! s:make_line_of_month(year, month, week)
  let buffer = s:window_partition
  let ws = (a:week - 1) * 7 + 1
  let ws = ws - s:zellers_congruence(a:year, a:month, ws)
  let wd = ws

  let wdmax = s:calendar_days[a:month][0]
  if s:is_leap_year(a:year) && a:month == 2
    let wdmax = wdmax + 1
  endif

  let [y, m, d] = s:get_today()

  let cnt = 0
  while cnt < 7
    if wd <= 0 || wdmax < wd
      let buffer = buffer . '   '

    else
      let spacer = ' '
      if y == a:year && m == a:month && d == wd
        let spacer = '*'
      endif

      let insert = spacer . wd
      let buffer = buffer . printf('%3s', insert)
    endif
    
    let wd = wd + 1
    let cnt = cnt + 1
  endwhile
  let buffer = buffer . ' '

  return buffer
endfunction


" get_today
"
" return
"   array: array of string
"
" 今日の年、月、日をそれぞれ文字列で配列に格納して返す。
function! s:get_today()
  return [ str2nr(strftime('%Y')), str2nr(strftime('%m')), str2nr(strftime('%d')) ]
endfunction


" make_moth_header
"
" return
"   str: string
"
" 月の見出しを作る
"
function! s:make_month_head(year, month)
  return printf('%s     %4d/%02d(%s)     ', s:window_partition, a:year, a:month, s:calendar_days[a:month][2])
endfunction


" make_day_of_the_week_head
"
" return
"   str: string
"
" 月の曜日の見出しを作る
"
function! s:make_day_of_the_week_head()
  return printf('%s Su Mo Tu We Th Fr Sa ', s:window_partition)
endfunction



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
"
function! s:zellers_congruence(year, month, day) abort
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
endfunction


" is_leap_year
"
" arg
"   year:  year
"
" return is_leap boolean v:false or v:true
"
" a:year で指定した年が閏年であれば v:true 、そうでなければ v:false を返す。
"
function! s:is_leap_year(year)
  let is_leap = v:false
  if ((a:year % 400 == 0) || (a:year % 4 == 0) && (a:year != 0))
    let is_leap = v:true
  endif
  return is_leap
endfunction
