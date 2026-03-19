" NAM:     mru_window
" AUTHOR:  marsh
" 
"                                      |
"                                      | * mru_window.vim
"                                      |
"                                      | mru#mru#get_data()
" +----------+                         | ------------------------------------------> s:mru_latest_data  [source]
" | mru.vim  |                         |      _______________________________________/
" |          | mru#mru#get_data()      |      |
" |          | ----------------------> |      | call
" |          |                         |      |-------> [ s:mru_init_callback ]
" |          |                         |      |
" |          |                         |      | call
" +----------+                         |      `-------> [ s:mru_update_callback ] -> s:mru_updated_data [transform]
"                                      |      _______________________________________/
"                                      |      |
"                                      |      | call
"                                      |      `-------> [ s:mru_show_callback ] ---> s:mru_lines        [sink]
"                                      |
"
"           s:mru_lines  1:1  s:mru_updated_data    1:1+a  s:mru_latest_data
"           1 AAAAAAAA        1 { "file": "xxx" }          1 { ... object ... }
" SELECT -> 2 BBBBBBBB        2 { "file": "xxx" }          2 { ... object ... }
"  |        3 CCCCCCCC        3 { "file": "xxx" }          3 { ... object ... }
"  |        4 DDDDDDDD        4 { "file": "xxx" }          4 { ... object ... }
"  |        5 EEEEEEEE        5 { "file": "xxx" }          5 { ... object ... }
"  |                                                       6 { ... object ... }
"  |                                                       7 { ... object ... }
"  |                                                       ....
"  `---> return 2 { ... object ... }
"
"
" mru://<detail>?<param>
"   <detail> : this/is/test
"   <param>  : this=is&test=param
"

let s:mru_latest_data  = []
let s:mru_updated_data = []
let s:mru_lines        = []

let s:mru_last_buffer  = 0
let s:mru_buffer_num   = 0

let s:mru_init_callback = {
      \ }

let s:mru_update_callback = {
      \ }

let s:mru_show_callback = {
      \ }


" mru#mru_window#register
" {{{

fun! mru#mru_window#register(domain, init, update, show) abort
  let s:mru_init_callback[a:domain] = a:init
  let s:mru_update_callback[a:domain] = a:update
  let s:mru_show_callback[a:domain] = a:show
endfun

" }}}


" mru#mru_window#last_bufnr
" {{{

fun! mru#mru_window#get_last_bufnr()
  return s:mru_last_buffer
endfun

" }}}


"
" mru#mru_window#set_last_bufnr
" {{{

fun! mru#mru_window#set_last_bufnr(bufnr)
  let s:mru_last_buffer = a:bufnr
endfun

" }}}



" mru#mru_window#mru_bufnr
" {{{

fun! mru#mru_window#mru_bufnr()
  return s:mru_buffer_num
endfun

" }}}


" mru#mru_window#open
" {{{

fun! mru#mru_window#open() abort
  let s:mru_latest_data = mru#mru#get_data()

  if empty(s:mru_latest_data)
    echomsg "MRU list is empty"
    return
  endif

  let s:mru_last_buffer = bufnr('%')
  let buffer_open_cmd = s:open_buffer_cmd(s:get_buffer_name("all"))

  let wininfo = filter(getwininfo(), "bufname(v:val.bufnr) =~# 'mru://'")
  if len(wininfo) ==# 1
    exec wininfo[0].winnr .. 'wincmd w'

  else
    hide execute buffer_open_cmd

  endif


  execute "setlocal ft=" .. "mru"

  setlocal buftype=acwrite bufhidden=wipe noswapfile
  setlocal nonumber norelativenumber nowrap signcolumn=no foldcolumn=0
  setlocal winfixheight winfixwidth
  setlocal conceallevel=3 concealcursor=nvic

  let s:mru_buffer_num = bufnr('%')
  call s:call_init(s:mru_buffer_num, "all")
  call s:call_update(s:mru_buffer_num, "all")
  call s:call_show(s:mru_buffer_num, "all")
endfun

" }}}


" mru#mru_window#select
" {{{

fun! mru#mru_window#select() abort
  if bufname(bufnr('%')) =~# 'mru://.\+'
    let linenr = line('.')
    return s:mru_updated_data[linenr - 1]

  else
    return {}
  endif
endfun

" }}}


" s:open_buffer_cmd
" {{{

fun! s:open_buffer_cmd(name, direction = "rightbelow", size = "10", opener = "split") abort
  let cmd = printf("%s %s%s %s", a:direction, a:size, a:opener, a:name)
  return cmd
endfun

" }}}


" get_buffer_name
" {{{

fun! s:get_buffer_name(req = "all") abort
  return printf("mru://%s", a:req)
endfun

" }}}


"
" s:call_init
" {{{

fun! s:call_init(bufnr, req) abort
  let request = a:req
  if index(keys(s:mru_init_callback), request) >= 0
    let request = "all"
  endif

  call function(s:mru_init_callback[request])()
endfun

" }}}


"
" s:call_update
" {{{

fun! s:call_update(bufnr, req) abort
  let request = a:req
  if index(keys(s:mru_update_callback), request) >= 0
    let request = "all"
  endif
  let s:mru_updated_data = function(s:mru_update_callback[request])(deepcopy(s:mru_latest_data))
endfun

" }}}


"
" s:call_show(bufnr, req)
" {{{

fun! s:call_show(bufnr, req) abort
  let request = a:req
  if index(keys(s:mru_show_callback), request) >= 0
    let request = "all"
  endif

  call s:unprotect_buffer(a:bufnr)
  call deletebufline(a:bufnr, 1, '$')

  let s:mru_lines = function(s:mru_show_callback[request])(deepcopy(s:mru_updated_data))
  call setbufline(a:bufnr, 1, s:mru_lines)
  call s:protect_buffer(a:bufnr)
endfun

" }}}


" s:protect_buffer
" {{{

function! s:protect_buffer(bufnr)
  call setbufvar(a:bufnr, "&modified", 0)
  call setbufvar(a:bufnr, "&modifiable", 0)
  call setbufvar(a:bufnr, "&readonly", 1)
endfunction

" }}}


" s:unprotect_buffer
" {{{

function! s:unprotect_buffer(bufnr)
  call setbufvar(a:bufnr, "&modified", 0)
  call setbufvar(a:bufnr, "&modifiable", 1)
  call setbufvar(a:bufnr, "&readonly", 0)
endfunction

" }}}


" END {{{
" vim: set foldmethod=marker :
