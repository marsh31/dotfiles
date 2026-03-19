" NAME:   autoload/calendar/ui.vim
" AUTHOR: marsh
"
" バッファにレンダリングされるUIの作成を行う。  



let s:fill_week          = '	                      '
let s:window_partition   = '	'    " tab char


" calendar#ui#makeinfo(int)
" 0 = horizontal , 1 = vertical
"
" {{{

fun! calendar#ui#makeinfo(dir, year, month, count)
  echo a:dir
  if a:dir == 0
    return {
          \ 'ui':  s:make_horizontal_calendar(a:year, a:month, a:count),
          \ 'pos': []
          \ }

  elseif a:dir == 1
    return {
          \ 'ui':  s:make_vertical_calendar(a:year, a:month, a:count),
          \ 'pos': s:make_vertical_calendar_pos(a:year, a:month, a:count)
          \ }

  else
    return {
          \ 'ui':  s:make_horizontal_calendar(a:year, a:month, a:count),
          \ 'pos': []
          \ }
  endif
endfun

" }}}

"
" make_vertical_calendar
" {{{

fun! s:make_vertical_calendar(year, month, count)
  let l:year = a:year
  let l:month = a:month

  let l:lines = [ s:fill_week ]
  for idx in range(1, a:count)
    let l:month_lines = s:make_month(l:year, l:month)

    call extend(l:lines, l:month_lines)
    call extend(l:lines, [ s:fill_week ])

    let l:month = l:month + 1
    if l:month > 12
      let l:month = 1
      let l:year = l:year + 1
    endif
  endfor

  return l:lines
endfun


fun! s:make_vertical_calendar_pos(year, month, count)
  let l:year  = a:year
  let l:month = a:month

  let l:month_info = []
  let l:month_start = 4  " 1 + 3, 3 is header size

  for idx in range(1, a:count)
    let l:month_size  = calendar#core#get_weeks_in_month(l:year, l:month)
    call add(l:month_info, [l:month_start, l:month_start + l:month_size - 1])

    let l:month_start = l:month_start + l:month_size + 3
    let l:month = l:month + 1
    if l:month > 12
      let l:month = 1
      let l:year  = l:year + 1
    endif
  endfor
  return l:month_info
endfun

" }}}





"
" s:make_horizontal_calendar(year, month, count)
" {{{

fun! s:make_horizontal_calendar(year, month, count)
  let l:year = a:year
  let l:month = a:month

  let l:lines = [ "", "", "", "", "", "", "", "" ]
  for idx in range(1, a:count)
    let l:month_lines = s:make_month(l:year, l:month)

    for lidx in range(0, 7)
      let l:lines[lidx] = l:lines[lidx] . get(l:month_lines, lidx, s:fill_week)
    endfor

    let l:month = l:month + 1
    if l:month > 12
      let l:month = 1
      let l:year = l:year + 1
    endif
  endfor

  return l:lines
endfun

" }}}



"
" s:make_month
" 月のデータを作る。
" {{{

fun! s:make_month(year, month)
  let l:month = [
        \ s:make_month_head(a:year, a:month),
        \ s:make_day_of_the_week_head()
        \ ]
  call extend(l:month, s:make_month_days(a:year, a:month))
  return l:month
endfun

" }}}


" make_moth_header
" return
"   str: string
"
" 月の見出しを作る
" {{{

fun! s:make_month_head(year, month)
  let l:info = calendar#core#get_month_info(a:year)
  return printf('%s     %4d/%02d(%.3s)     ', s:window_partition, a:year, a:month, l:info[a:month][2])
endfun

" }}}



" make_day_of_the_week_head
"
" return
"   str: string
"
" 月の曜日の見出しを作る
" {{{

fun! s:make_day_of_the_week_head()
  return printf('%s Su Mo Tu We Th Fr Sa ', s:window_partition)
endfun

" }}}


" make_month( year, month )
" 月のデータを作る。
" {{{

fun! s:make_month_days(year, month)
  let l:info = calendar#core#get_month_info(a:year)
  let l:month_max = l:info[a:month][0]
  let l:month_name = l:info[a:month][2]
  let l:month = a:month
  let l:year = a:year

  let l:today = calendar#core#get_today()
  let l:start_day = str2nr(strftime('%w', strptime('%Y-%m-%d', printf('%04d-%02d-01', l:year, l:month))))
  let l:week = repeat(['   '], l:start_day)
  let l:lines = []
  for l:day in range(1, l:month_max)
    if l:year == l:today[0] && l:month == l:today[1] && l:day == l:today[2]
      let l:day_tmp = '*' .. l:day
      call add(l:week, printf("%3s", l:day_tmp))
    else
      call add(l:week, printf(" %2d", l:day))
    endif
    if len(l:week) == 7
      call add(l:lines, s:window_partition . join(l:week, '') . ' ')
      let l:week = []
    endif
  endfor

  if len(l:week) > 0
    while len(l:week) < 7
      call add(l:week, '   ')
    endwhile
    call add(l:lines, s:window_partition . join(l:week, '') . ' ')
  endif

  return l:lines
endfun

" }}}
