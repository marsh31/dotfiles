
" buffer local
if ! exists('b:date_match_ids')
  let b:date_match_ids = []
endif 

" script local
let s:dt_pattern = '\d\{4\}-\d\{2\}-\d\{2\}\( \d\d:\d\d:\d\d\)\?'


" highlight
hi DateTimeOverdue   ctermfg=Red         guifg=#ff5f5f
hi DateTimeUpcoming  ctermfg=Green       guifg=#5fd787
hi DateTimeSoon      ctermfg=Yellow      guifg=#ffd75f
hi DateTimeDone      ctermfg=DarkGray    guifg=#666666


fun! s:clear_matches() abort
  if exists('b:date_match_ids')
    for id in b:date_match_ids
      silent! call matchdelete(id)
    endfor
  endif
  let b:date_match_ids = []
endfun


fun! s:parse_epoch(dt) abort
  if a:dt =~# '^\d\{4\}-\d\{2\}-\d\{2\}$'
    return strptime('%Y-%m-%d %H:%M:%S', a:dt . ' 23:59:59')
  endif
  return strptime('%Y-%m-%d %H:%M:%S', a:dt)
endfun


fun! s:highlight_date() abort
  call s:clear_matches()

  let lstart = line('w0')
  let lend   = line('w$')

  for lnum in range(lstart, lend)
    let l = getline(lnum)
    
    let m = matchstrpos(l, s:dt_pattern)
    if m[1] < 0
      continue
    endif
    
    let dt_text = m[0]
    let col = m[1] + 1
    let len = strlen(dt_text)
    
    let t = s:parse_epoch(dt_text)
    if t <= 0
      continue
    endif

    call add(b:date_match_ids, matchaddpos('DateTimeDone', [[lnum, col, len]]))
  endfor
endfun
call s:highlight_date()


" 
