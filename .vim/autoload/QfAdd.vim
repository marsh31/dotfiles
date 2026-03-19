" QfAdd
" Version: 0.0.1
" Author: 
" License: 

unlet g:loaded_QfAdd
if exists('g:loaded_QfAdd')
  finish
endif
let g:loaded_QfAdd = 1

let s:save_cpo = &cpo
set cpo&vim

"
let s:default_title = "QfAdd"

" 
let s:default_ctx   = {
      \ 'plugin': 'QfAdd'
      \ }

" デフォルトとして使う辞書。
" extend(l:dict, s:default_dict, 'keep') みたいな感じで辞書を作る。
let s:default_dict = {
      \ "bufnr":     -1,
      \ "filename":  "",
      \ "module":    "",
      \ "lnum":      0,
      \ "end_lnum":  0,
      \ "pattern":   "",
      \ "col":       0,
      \ "vcol":      0,
      \ "end_col":   0,
      \ "nr":        0,
      \ "text":      "",
      \ "type":      "I",
      \ "valid":     0,
      \ "user_data": {},
      \ }

let s:add_data = []

" 失敗出力をする。
fun! s:fail(msg) abort
  echohl ErrorMsg
  echomsg '[QfAdd] ' .. a:msg
  echohl None
  return 0
endfun


" Quickfix window
fun! QfAdd#new()
  call setqflist([], ' ', {
        \ 'context': s:default_ctx,
        \ 'nr': '$',
        \ 'title': s:default_title,
        \ })
endfun


" context            
" efm                linesをパースするときに使われるフォーマット
" id                 nr と同じ。ID。
" idx                id / nr で指定されたQFリスト内のエントリを取得する
" items              arg1{list}と同じ
" lines              efm or errorformatをつかってパースすること前提のデータ。
" nr                 0 は 現在。 '$' は最後のQFリスト
"
" qfbufnr
" size
" title
" winid
" all
"
" quickfixtextfunc   
" title              
fun! s:add(dict)
  call add(s:add_data, a:dict)
  call setqflist([a:dict], 'a')
endfun


fun! s:is_qf_add_window()
  if string(getqflist({"all": v:null}).context) ==# string(s:default_ctx)
    return v:true
  else
    return v:false
  endif
endfun


fun! QfAdd#sync()
  if s:is_qf_add_window()
    call setqflist(s:add_data, 'r')
  endif  
endfun


fun! QfAdd#add()
  if ! s:is_qf_add_window()
    call QfAdd#new()
    call QfAdd#sync()
  endif

  let l:dict = {
      \ "bufnr": bufnr(),
      \ "filename": bufname(bufnr()),
      \ "module": fnamemodify(bufname(bufnr()), ':t:r'),
      \ "lnum": line('.'),
      \ "end_lnum": line('.'),
      \ "col": col('.'),
      \ "end_col": col('.'),
      \ "nr": 0,
      \ "text": getline('.'),
      \ }

  call extend(l:dict, s:default_dict, 'keep')
  call s:add(l:dict)
endfun


fun! QfAdd#clear()
  if s:is_qf_add_window()
    call setqflist([], 'r')
    let s:add_data = []
  else
    call s:fail("Current window is not QfAdd window ")
  endif
endfun

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
