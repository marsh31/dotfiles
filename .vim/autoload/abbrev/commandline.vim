" commandline
" Version: 0.0.1
" Author: 
" License: 
"

if exists('g:loaded_abbrev_commandline')
  finish
endif
let g:loaded_abbrev_commandline = 1

let s:save_cpo = &cpo
set cpo&vim

" key / cmd dictionary
let s:command_dictionary = {}


" 失敗出力をする。
fun! s:fail(msg) abort
  echohl ErrorMsg
  echomsg '[abbrev#commandline] ' .. a:msg
  echohl None
  return 0
endfun


" abbrev cnoremap
" note: call only in abbrev#commandline#add
fun! s:make_cnoremap(key, cmd)
  exec    'cnoreabbrev <expr> ' .. a:key .. ' ' ..
        \ '(getcmdtype() ==# ":" && getcmdline() ==# "' .. a:key  .. '")' ..
        \ ' ? "' .. a:cmd .. '" : "' .. a:key .. '"'
endfun


" abbrev cnoremap
" note: call only in abbrev#commandline#add
fun! s:register_key(key, value)
  let s:command_dictionary[a:key] = a:value
endfun


" abbrev#commandline#add
" 
" @param rules list    登録データリスト
fun! abbrev#commandline#add(rules)
  let l:keys = keys(a:rules)
  for l:key in l:keys
    if empty(maparg(l:key, 'c', 1, 1))
      call s:make_cnoremap(l:key, a:rules[l:key].cmd)
      call s:register_key(l:key, a:rules[l:key])
    else
      call s:fail(l:key .. ' is used!')
    endif
  endfor
endfun


" abbrev#commandline#list
fun! abbrev#commandline#list()
  let l:lines = []
  call add(l:lines, '--- AbbrevCmd definitions ---')
  for l:key in sort(keys(s:command_dictionary))
    call add(l:lines, '  ' .. l:key .. ' -> ' .. s:command_dictionary[l:key].cmd)
  endfor

  if len(l:lines) == 1
    call add(l:lines, '(empty)')
  endif

  pclose
  execute 'pedit +setlocal\ buftype=nofile\ bufhidden=wipe\ nobuflisted\ noswapfile AbbrevCmdList'
  let l:preview_bufnr = bufnr('AbbrevCmdList')

  call setbufvar(l:preview_bufnr, '&modifiable', 1)
  call deletebufline(l:preview_bufnr, 1, '$')
  call setbufline(l:preview_bufnr, 1, l:lines)
  call setbufvar(l:preview_bufnr, '&modifiable', 0)
endfun


" abbrev#commandline#del
fun! abbrev#commandline#del(keys)
  for l:key in a:keys
    exec 'cunabbrev ' .. l:key
  endfor
endfun


" 
fun! abbrev#commandline#clear()
  call abbrev#commandline#del(keys(s:command_dictionary))
  let s:command_dictionary = {}
endfun


let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set et:
