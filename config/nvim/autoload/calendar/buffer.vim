" NAME:   autoload/calendar/buffer.vim
" 
" バッファの作成、管理、変更を行う。
"
" バッファローカルな変数を用意してカレンダーの情報を記録する。  
"
" let b:calendar       : string
" let b:calendar_dir   : number
" let b:calendar_pos   : list<list<number>>
" let b:calendar_year  : number
" let b:calendar_month : number
" let b:calendar_count : number
"
"
" let b:calendar       : string
" カレンダーバッファを表す。  
"
" let b:calendar_dir   : number
" バッファの向きが垂直か、水平か表す。これにより内部情報が変わる。  
"
" let b:calendar_pos   : list<list<number>>
" let b:calendar_year  : number
" let b:calendar_month : number
" let b:calendar_count : number
"
"
"

let s:vertical_size = 32
let s:horizontal_size = 8

command! -range -nargs=*  Calopen  call calendar#buffer#open(<q-mods>, <f-args>)

"
" calendar#buffer#open
" バッファを開く
" デフォルトは split
" {{{

fun! calendar#buffer#open(mods, year, month)
  let l:dir = 0
  if a:mods =~ 'vertical'
    let l:dir = 1
  endif

  let l:info = calendar#ui#makeinfo(l:dir, a:year, a:month, 12)

  exec s:get_split_cmd(l:dir)
  call s:init_buffer_config()
  call s:update_buffer(l:info['ui'])
  call calendar#highlight#init()

  " call s:protect_buffer()

  let b:calendar       = "calendar"
  let b:calendar_dir   = l:dir
  let b:calendar_pos   = l:info['pos']
  let b:calendar_year  = a:year
  let b:calendar_month = a:month
  let b:calendar_count = 12
endfun

" }}}


"
" calendar#buffer#in_buffer()
" {{{

fun! calendar#buffer#in_buffer()
  if get(b:, "calendar", "")  == "calendar"
    return v:true
  endif
  return v:false
endfun

" }}}


" calendar#buffer#get_month
" {{{

fun! calendar#buffer#get_year_month()
  " b:calendar
  if get(b:, "calendar", "")  == "calendar"
    let l:cpos = getcurpos()
    let l:pos = b:calendar_pos

    let l:month = 0
    for l:p in l:pos
      if l:p[0] <= l:cpos[1] && l:cpos[1] <= l:p[1]
        break
      endif
      let l:month = l:month + 1
    endfor


    let l:calendar_year  = 0
    let l:calendar_month = 0
    let cWORD = expand('<cWORD>')
    if l:month != b:calendar_count
      let l:calendar_month = b:calendar_month + l:month - 1

      let l:calendar_year  = b:calendar_year + (l:calendar_month / 12)
      let l:calendar_month = (l:calendar_month % 12) + 1
    endif

    echomsg l:calendar_year .. '/' .. l:calendar_month .. '/' .. cWORD
    return l:calendar_month
  endif

  return -1
endfun

" }}}



"
" s:update_buffer
" {{{

fun! s:update_buffer(info)
  call setline(1, a:info)
endfun

" }}}


" s:get_split_cmd
" {{{

fun! s:get_split_cmd(dir)
  if a:dir == 1
    let cmd = 'bo ' .. s:vertical_size .. 'vnew vcalendar'
  else
    let cmd = 'bo ' .. s:horizontal_size .. 'new scalendar'
  endif
  return cmd
endfun

" }}}


" init_buffer_config
" バッファの初期設定を行う。
" {{{
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
  setlocal nonumber norelativenumber
  setlocal winfixheight winfixwidth
endfunction

" }}}


fun! s:protect_buffer()
  setlocal nomodified nomodifiable readonly
endfun

fun! s:unprotect_buffer()
  setlocal nomodified modifiable noreadonly
endfun



