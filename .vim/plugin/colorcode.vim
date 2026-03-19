" NAME:   colorcode.vim
" AUTHOR: marsh
" NOTE:
"
"
"
"
"


" variables {{{1

" global {{{2
let g:colorcode_bg_enabled    = get(g:, 'colorcode_bg_enabled', 1)
let g:colorcode_bg_debounce   = get(g:, 'colorcode_bg_debounce', 30)
let g:colorcode_bg_max_groups = get(g:, 'colorcode_bg_max_groups', 512)


" s:hl_cache                      {{{2
"
" {
"   "#RRGGBB": "ColorCodeBG_RRGGBB",
"   "#00FF00": "ColorCodeBG_00FF00",
"   "#123456": "ColorCodeBG_123456",
" }

let s:hl_cache = {}


" s:win_state =                   {{{2
" {             
"   winid = {
"     bufnr:
"     top:
"     bot:
"     tick: 
"     lines: {
"       lnum: {
"         text: 
"         tokens: 
"         match_ids: []
"       },
"       lnum: {
"         text: 
"         tokens: 
"         match_ids: []
"       },...
"     }
"   },...
" }
"

let s:win_state = {}



" s:timers {{{2
"
" {
"   1: -1,
"   2: timernum
" }

let s:timers = {}



" let b:changedtick



" function {{{1

fun! s:fg_for_bg(hex) abort " {{{2
  let l:h = substitute(toupper(a:hex), '^#', '', '')
  if l:h !~# '^\x\{6}$'
    return '#000000'
  endif
  let l:r = str2nr(l:h[0:1], 16)
  let l:g = str2nr(l:h[2:3], 16)
  let l:b = str2nr(l:h[4:5], 16)

  let l:yiq = (l:r * 299 + l:g * 587 + l:b * 114) / 1000
  return l:yiq >= 128 ? '#000000' : '#FFFFFF'
endfun


fun! s:ensure_hl(hex) abort " {{{2
  let l:hex = '#' .. substitute(toupper(a:hex), '^#', '', '')
  if has_key(s:hl_cache, l:hex)
    return s:hl_cache[l:hex]
  endif
  if len(keys(s:hl_cache)) >= g:colorcode_bg_max_groups
    return ''
  endif

  let l:name = 'ColorCodeBG_' .. substitute(l:hex, '^#', '', '')
  let l:fg   = s:fg_for_bg(l:hex)
  exec printf('hi %s guifg=%s guibg=%s ctermfg=NONE ctermbg=NONE',
        \ l:name, l:fg, l:hex)
  let s:hl_cache[l:hex] = l:name
  return l:name
endfun


fun! s:parse_color_tokens(text) abort " {{{2
  let l:tokens = []
  let l:from = 0

  while 1
    let l:m = matchstrpos(a:text, '#\x\{6}', l:from)
    let l:hex = l:m[0]
    let l:idx = l:m[1]
    if l:idx < 0
      break
    endif

    let l:group = s:ensure_hl(l:hex)
    if ! empty(l:group)
      call add(l:tokens, {
            \ 'col': l:idx + 1,
            \ 'len': strlen(l:hex),
            \ 'hex': toupper(l:hex),
            \ 'group': l:group,
            \ })
    endif
    let l:from = l:idx + strlen(l:hex)
  endwhile
  return l:tokens
endfun


fun! s:clear_line_matches(winid, lnum) abort " {{{2
  let l:state = get(s:win_state, a:winid, {})
  let l:line_state = get(get(l:state, 'lines', {}), a:lnum, {})
  for l:id in get(l:line_state, 'match_ids', [])
    try
      call matchdelete(l:id, a:winid)
    catch
    endtry
  endfor
endfun


fun! s:apply_line(winid, lnum, text) abort " {{{2
  let l:new_tokens = s:parse_color_tokens(a:text)

  if !has_key(s:win_state, a:winid)
    let s:win_state[a:winid] = { 'lines': {} }
  endif
  if !has_key(s:win_state[a:winid], 'lines')
    let s:win_state[a:winid].lines = {}
  endif

  let l:old = get(s:win_state[a:winid].lines, a:lnum, {})

  if get(l:old, 'text', '') ==# a:text
        \ && string(get(l:old, 'tokens', [])) ==# string(l:new_tokens)
    return
  endif

  call s:clear_line_matches(a:winid, a:lnum)

  let l:ids = []
  for l:t in l:new_tokens
    let l:id = matchaddpos(l:t.group, [[a:lnum, l:t.col, l:t.len]], 10, -1, {'window': a:winid})
    call add(l:ids, l:id)
  endfor
  let s:win_state[a:winid].lines[a:lnum] = {
        \ 'text': a:text,
        \ 'tokens': l:new_tokens,
        \ 'match_ids': l:ids,
        \ }
endfun


fun! s:refresh_win(winid) abort " {{{2
  echomsg '== refresh win =='
  if !g:colorcode_bg_enabled
    return
  endif
  if !has('termguicolors') || !&termguicolors
    return
  endif
  if win_getid() != a:winid
    return
  endif

  let l:bufnr = bufnr('%')
  let l:top   = line('w0')
  let l:bot   = line('w$')
  let l:tick  = b:changedtick

  if !has_key(s:win_state, a:winid)
    let s:win_state[a:winid] = {
          \ 'bufnr': l:bufnr,
          \ 'top': 0,
          \ 'bot': 0,
          \ 'tick': -1,
          \ 'lines': {},
          \ }
  endif

  let l:st = s:win_state[a:winid]
  if l:st.bufnr != l:bufnr
    for lnum in keys(l:st.lines)
      call s:clear_line_matches(a:winid, str2nr(lnum))
    endfor
    let l:st.lines = {}
  endif


  for lnum in keys(l:st.lines)
    let l:n = str2nr(lnum)
    if l:n < l:top || l:bot < l:n
      call s:clear_line_matches(a:winid, l:n)
      call remove(l:st.lines, lnum)
    endif
  endfor


  for lnum in range(l:top, l:bot)
    let l:text = getline(lnum)

    if !has_key(l:st.lines, lnum) || get(l:st.lines[lnum], 'text', '') !=# l:text
      call s:apply_line(a:winid, lnum, l:text)
      continue
    endif
  endfor

  let l:st.top = l:top
  let l:st.bot = l:bot
  let l:st.tick = l:tick
  let l:st.bufnr = l:bufnr
endfun


fun! s:refresh_current_win() abort " {{{2
  call s:refresh_win(win_getid())
endfun


fun! s:schedule_refresh(winid) abort " {{{2
  if !has_key(s:timers, a:winid)
    let s:timers[a:winid] = -1
  endif

  if s:timers[a:winid] != -1
    call timer_stop(s:timers[a:winid])
  endif

  let s:timers[a:winid] = timer_start(g:colorcode_bg_debounce, {-> execute('call <sid>refresh_current_win()')})
endfun


fun! s:clear_win(winid) abort " {{{2
  let l:st = get(s:win_state, a:winid, {})
  for lnum in keys(get(l:st, 'lines', {}))
    call s:clear_line_matches(a:winid, str2nr(lnum))
  endfor
  call remove(s:win_state, a:winid)
endfun


fun! s:enable() abort " {{{2
  let g:colorcode_bg_enabled = 1
  call s:refresh_current_win()
endfun


fun! s:disable() abort " {{{2
  let g:colorcode_bg_enabled = 0
  call s:clear_win(win_getid())
endfun


 " augroup ColorCodeBG {{{2
 "

augroup ColorCodeBG
  autocmd!
  autocmd BufWinEnter,WinEnter     * call <sid>schedule_refresh(win_getid())
  autocmd TextChanged,TextChangedI * call <sid>schedule_refresh(win_getid())
  autocmd WinScrolled              * call <sid>schedule_refresh(win_getid())
  autocmd WinClosed                * call <sid>clear_win(str2nr(expand('<amatch>')))
augroup END



 " IF {{{1
 "
fun! ColorCodeBG() abort
  call s:refresh_current_win()
endfun

fun! ColorCodeState() abort
  echomsg '== hl cache =='
  echomsg s:hl_cache

  echomsg '== win state =='
  echomsg s:win_state

  echomsg '== timers =='
  echomsg s:timers
endfun


" #ff00ff
" #ff0000
" #00ff00
" #0000ff

" #38b48b

" END {{{1
" vim: ft=vim
