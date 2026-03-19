" g:MRU_File    => s:mru_file_path
" g:MRU_Exclude => s:mru_exclude_pattern
"
"

let s:mru_file_path       = ""

let s:mru_files           = []
let s:mru_is_locked       = v:false
let s:mru_is_loaded       = v:false

" regex pattern. ex. "\(.*vim\|.*\.git\)
let s:mru_exclude_pattern = []


" 
" s:mru_file_path
" {{{

if !exists('g:MRU_File')
  if has('unix') || has('macunix')
    let s:mru_file_path = $HOME . '/.vim_mru_files.json'
  else
    let s:mru_file_path = $VIM . '/_vim_mru_files.json'
    if has('win32')
      " MS-Windows
      if !empty($USERPROFILE)
        let s:mru_file_path = $USERPROFILE . '\_vim_mru_files.json'
      endif
    endif
  endif
else
  let s:mru_file_path = expand(g:MRU_File)
endif

" }}}


" s:mru_exclude_pattern
" {{{

" TODO: s:mru_exclude_pattern = g:MRU_Exclude

" }}}


" mru#mru#load
" read json data from mru file
" {{{

fun! mru#mru#load() abort
  if !s:mru_is_loaded
    let json_object = []
    if filereadable(s:mru_file_path)
      let file_lines = readfile(s:mru_file_path)

      if empty(file_lines)
        let json_object = []

      else
        let json_object = json_decode(join(file_lines, ""))

      endif
    else
      let json_object = []
    endif
    let s:mru_files = json_object

    " TODO: filter readable files.

    " TODO: set callback for notification
  endif
endfun

" }}}


" mru#mru#save
" write json data to mru file
" {{{

fun! mru#mru#save() abort
  let json_object = []
  call extend(json_object, s:mru_files)
  call writefile([json_encode(json_object)], s:mru_file_path)
endfun

" }}}


" mru#mru#add_file
" autoload から呼び出される関数。  
" バッファロードされたタイミングで呼び出される。  
" それ以外のタイミングからは動作保証をしない。  
" {{{

fun! mru#mru#add_file(bufnr) abort
  if s:mru_is_locked
    return
  endif

  let fname = fnamemodify(bufname(a:bufnr + 0), ':p')
  if empty(fname)
    return
  endif

  if !empty(&buftype)
    return
  endif

  if !filereadable(fname)
    return
  endif


  " TODO: add exclude pattern

  " 
  let insert_object = {
        \   "file": fname,
        \   "date": strftime('%Y%m%d%H%M%S'),
        \ }
  call mru#mru#load()
  call filter(s:mru_files, "v:val.file !=# insert_object.file")
  call insert(s:mru_files, insert_object, 0)

  " TODO: trim s:mru_files using max size


  call mru#mru#save()

  " TODO: call callback function
endfun

" }}}


" mru#mru#delete_file(file)  
" file 文字列 ファイルパス  
" ファイルパスを入力することでMRUリストから削除する。  
" {{{

fun! mru#mru#delete_file(file) abort
  if s:mru_is_locked
    return
  endif

  call mru#mru#load()
  call filter(s:mru_files, "v:val.file !=# a:file")
  call mru#mru#save()
endfun

" }}}


" mru#mru#lock
" {{{

fun! mru#mru#lock() abort
  let s:mru_is_locked = v:true
endfun

" }}}


" mru#mru#unlock
" {{{

fun! mru#mru#unlock() abort
  let s:mru_is_locked = v:false
endfun

" }}}


" mru#mru#get_data
" {{{

fun! mru#mru#get_data() abort
  call mru#mru#load()
  return deepcopy(s:mru_files)
endfun

" }}}

" END {{{
" vim: set foldmethod=marker :
