" NAME:   plugin/date.vim
" AUTHOR: marsh
" NOTE:
"
" 日付・時刻の表示や挿入、補完などをサポートするプラグイン
" 以下の形式はサポートする。やんわりISO8601に従う。
"
" 2026-03-27T01:23:25
" 2026-03-27T06:07:08+09:00
" 2026-03-26T09:00:00
" 2026-03-28T09:00
" 2026-03-28
" 09:00:00
" 09:00
"
" TODO:
" - DatetimeInitをデフォルトで実行する
"
" - DatetimeEnableを実行時に行変更やカーソル移動などをトリガーにして
"   再度マッチを計算するように変更する
"
" - DatetimeEnableを実行時に時間だけの場合は、今日の時間であるという
"   過程で色付けをする
"
" - DatetimeEnableの色付けをもう少しいい感じに変更したい。
"   例えば、今日は過去は赤、今日は黄色、未来は緑、みたいな感じ。
"
"

" variables {{{1
" 
"
"

let s:pat_tz       = '\%(Z\|[+-]\d\{2\}:\d\{2\}\)'
let s:pat_time     = '\d\{2\}:\d\{2\}\%(:\d\{2\}\)\?'
let s:pat_datetime = '\d\{4\}-\d\{2\}-\d\{2\}\%([T ]\d\{2\}:\d\{2\}\%(:\d\{2\}\)\?\)\?\%('..s:pat_tz..'\)\?'


" }}}
" function utils {{{1
" 
"

fun! s:get_current_datetime()
  return strftime("%Y-%m-%dT%H:%M:%S")
endfun

fun! s:get_current_date()
  return strftime("%Y-%m-%d")
endfun

fun! s:get_current_time()
  return strftime("%H:%M:%S")
endfun


fun! s:define_highlight() abort
  highlight! default link IsoDatetime SpecialKey
  highlight! default link IsoTime     IsoDatetime

  highlight! default link IsoT        SpellLocal 

  highlight! default link IsoPast     SpellBad   
  highlight! default link IsoToday    SpellCap   
  highlight! default link IsoFuture   SpellRare  
endfun


fun! s:define_syntax() abort
  call s:define_highlight()

  exec 'syntax match IsoDatetime  /'..s:pat_datetime..'/   contains=IsoT,IsoTZ containedin=ALL'
  exec 'syntax match IsoTime      /'..s:pat_time..'/                           containedin=ALL'
  exec 'syntax match IsoTZ        /'..s:pat_tz..'/         contained'
  syntax       match IsoT         /T/                      contained conceal cchar= 

  setlocal conceallevel=2
  setlocal concealcursor=nc

  " call s:enable()
endfun


fun! s:tz_offset_seconds(tz) abort
  if a:tz ==# ''  | return 0 | endif
  if a:tz ==# 'Z' | return -9 * 3600 | endif

  let l:sign = a:tz[0] ==# '-' ? -1 : 1
  let l:hh   = str2nr(a:tz[1:2])
  let l:mm   = str2nr(a:tz[4:5])
  return (l:sign * (l:hh * 3600 + l:mm * 60))
endfun


fun! s:iso_to_local_epoch(iso) abort
  " date, time, tz
  let l:m = matchlist(a:iso, '\v^(\d{4}-\d{2}-\d{2})([T ](\d{2}:\d{2})(:\d{2})?)?((Z|[+-]\d{2}:\d{2}))?$')
  if empty(l:m) | return -1 | endif

  let l:date = l:m[1]
  let l:time = l:m[3] ==# '' ? '00:00' : l:m[3]
  let l:sec  = l:m[4] ==# '' ? ':00'   : l:m[4]
  let l:tz   = l:m[5]
  let l:dt   = l:date .. ' ' .. l:time .. l:sec

  let l:local_epoch_assumed = strptime('%Y-%m-%d %H:%M:%S', l:dt)
  if l:local_epoch_assumed <= 0 | return -1 | endif

  if l:tz !=# ''
    let l:input_off = s:tz_offset_seconds(l:tz)
    let l:jst_off   = 9 * 3600
    let l:delta     = l:jst_off - l:input_off

    return l:local_epoch_assumed + l:delta
  endif

  return l:local_epoch_assumed
endfun


fun! s:today_range() abort
  let l:today = strftime('%Y-%m-%d', localtime())
  let l:start = strptime('%Y-%m-%d %H:%M:%S', l:today .. ' 00:00:00')
  let l:end   = l:start + 24*3600
  return [l:start, l:end]
endfun


let s:timer = -1
fun! s:clear_matches() abort
  if exists('b:datetime_match_ids')
    for l:id in b:datetime_match_ids
      silent! call matchdelete(l:id)
    endfor
  endif

  let b:datetime_match_ids = []
endfun


fun! s:apply_classification() abort
  call s:clear_matches()

  let [l:today_start, l:today_end] = s:today_range()
  let l:now = localtime()

  let l:l0 = line('w0')
  let l:l1 = line('w$')

  for lnum in range(l:l0, l:l1)
    let l:line = getline(lnum)
    let l:pos = 0

    while 1
      let l:ms = matchstrpos(l:line, s:pat_datetime, l:pos)
      if l:ms[1] < 0 | break | endif

      let l:txt      = l:ms[0]
      let l:startcol = l:ms[1] + 1
      let l:len      = strlen(l:txt)
      let l:epoch    = s:iso_to_local_epoch(l:txt)

      if l:epoch >= 0
        if l:epoch < l:today_start
          let l:grp = 'IsoPast'
        elseif l:epoch < l:today_end
          let l:grp = 'IsoToday'
        else
          let l:grp = 'IsoFuture'
        endif

        let l:id = matchaddpos(l:grp, [[lnum, l:startcol, l:len]], 10)
        call add(b:datetime_match_ids, l:id)
      endif

      let l:pos = l:ms[2] + 1
    endwhile
  endfor
endfun


fun! s:enable() abort
  call s:apply_classification()

  " TODO: augroup

  if s:timer != -1
    call timer_stop(s:timer)
  endif

  let s:timer = timer_start(60000, {-> execute('call <sid>apply_classification()')}, {'repeat': -1})
endfun

fun! s:disable() abort
  call s:clear_matches()

  " TODO: augroup

  if s:timer != -1
    call timer_stop(s:timer)
    let s:timer = -1
  endif
endfun


" }}}
" autocmd {{{1
" 




" }}}
" command & mapping {{{1
" 
"


command! DatetimeInit    call <sid>define_syntax()
command! DatetimeEnable  call <sid>enable()
command! DatetimeDisable call <sid>disable()


nnoremap  <plug>(npaste-datetime-p)  "=<sid>get_current_datetime()<cr>p
nnoremap  <plug>(npaste-datetime-P)  "=<sid>get_current_datetime()<cr>P

nnoremap  <plug>(npaste-date-p)      "=<sid>get_current_date()<cr>p
nnoremap  <plug>(npaste-date-P)      "=<sid>get_current_date()<cr>P

nnoremap  <plug>(npaste-time-p)      "=<sid>get_current_time()<cr>p
nnoremap  <plug>(npaste-time-P)      "=<sid>get_current_time()<cr>P

inoremap  <plug>(ipaste-datetime)    <c-r>=<sid>get_current_datetime()<cr>
inoremap  <plug>(ipaste-date)        <c-r>=<sid>get_current_date()<cr>
inoremap  <plug>(ipaste-time)        <c-r>=<sid>get_current_time()<cr>


" }}}
" UserSettings {{{1
"

inoremap  <c-f>;  <plug>(ipaste-datetime)
inoremap  <c-f>:  <plug>(ipaste-date)



" }}}
" END: {{{
" vim: set ft=vim et ts=2 tw=78 :
