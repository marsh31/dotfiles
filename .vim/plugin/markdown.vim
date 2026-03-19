"
" NAME: 
"
" NOTE:
"   markdownファイルのチェックボックスに任意の１文字をチェックとして
" 入れるプラグイン。"- [.]" の . の文字を任意の文字に変える。
" 
"

let s:last_checkbox_ch = ''
let s:checkbox_pat = '^\s*-\s\+\[\zs.\ze\]'
fun! s:change_checkbox_line(lnum, ch) abort
  let l:line = getline(a:lnum)
  if l:line !~# s:checkbox_pat
    return
  endif
  call setline(a:lnum, substitute(l:line, s:checkbox_pat, a:ch, ''))
endfun

fun! s:change_checkbox_range(first, last, ch) abort
  " TODO: ２バイト文字もOKにするから、崩れる可能性がある。
  if strchars(a:ch) != 1
    echoerr 'checkbox item must be exactly 1 char'
    return
  endif
  for lnum in range(a:first, a:last)
    call s:change_checkbox_line(lnum, a:ch)
  endfor
endfun

fun! s:prompt_change_checkbox(type, ch) abort
  let l:ch = a:ch
  if empty(l:ch)
    let l:ch = nr2char(getchar())
    if empty(l:ch)
      return
    endif
  endif

  let s:last_checkbox_ch = l:ch

  if a:type ==# 'line'
    call s:change_checkbox_range(line('.'),  line('.'), l:ch)
  elseif a:type ==# 'visual'
    call s:change_checkbox_range(line("'<"), line("'>"), l:ch)
  else
    call s:change_checkbox_range(line('.'),  line('.'), l:ch)
  endif

  if exists('*repeat#set')
    call repeat#set("\<Plug>(ChangeCheckboxRepeat)")
  endif
endfun

fun! s:repeat_change_checkbox() abort
  if empty(s:last_checkbox_ch)
    echoerr 'No previous ChangeCheckbox'
    return
  endif
  call s:change_checkbox_range(line('.'), line('.'), s:last_checkbox_ch)
endfun


" key map
nnoremap <silent> <Space>dp  :<C-u>call <SID>prompt_change_checkbox('line',   '')<CR>
xnoremap <silent> <Space>dp  :<C-u>call <SID>prompt_change_checkbox('visual', '')<CR>

nnoremap <silent> <Space>dr  :<C-u>call <SID>prompt_change_checkbox('line',   '/')<CR>
xnoremap <silent> <Space>dr  :<C-u>call <SID>prompt_change_checkbox('visual', '/')<CR>

nnoremap <silent> <Space>dd  :<C-u>call <SID>prompt_change_checkbox('line',   'x')<CR>
xnoremap <silent> <Space>dd  :<C-u>call <SID>prompt_change_checkbox('visual', 'x')<CR>

nnoremap <silent> <Space>d1  :<C-u>call <SID>prompt_change_checkbox('line',   '!')<CR>
xnoremap <silent> <Space>d1  :<C-u>call <SID>prompt_change_checkbox('visual', '!')<CR>

nnoremap <silent> <Space>di  :<C-u>call <SID>prompt_change_checkbox('line',   'い')<CR>
xnoremap <silent> <Space>di  :<C-u>call <SID>prompt_change_checkbox('visual', 'い')<CR>

" dot repeat
nnoremap <silent> <Plug>(ChangeCheckboxRepeat)
      \ :<C-u>call <SID>repeat_change_checkbox()<CR>

" command
command! -range -nargs=1 ChangeCheckbox
      \ call <SID>change_checkbox_range(<line1>, <line2>, <f-args>)

command! -range -nargs=0 ClearCheckbox
      \ call <SID>change_checkbox_range(<line1>, <line2>, ' ')
