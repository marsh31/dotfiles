" Book mark
" Version: 1.1
" Author : marsh

let s:buffer_name   = "[BookmarkList]"
let s:buffer_ft     = "bookmark"

" let s:buffer_opener = "vsplit"
let s:buffer_opener = "split"

" let s:buffer_side   = "leftabove"
let s:buffer_side   = "rightbelow"

let s:bookmark= expand("~/til/info/bookmark.md")


command! BookmarkOpen call s:buffer_open()

"
" IF
"
function! s:buffer_open()
  augroup plugin_colorlist_file_init
    autocmd! *
    exec "autocmd FileType " .. s:buffer_ft .. " call s:init()"
    " exec "autocmd WinEnter * echo 'test xx'"
  augroup END

  let bufferlines = s:get_bufferlist()
  " let bufferrowmaxsize = len(bufferlines) + 5
  let bufferrowmaxsize = 10
  let buffercolmaxsize = max(map(copy(bufferlines), 'strlen(v:val)')) + 5

  noautocmd hide execute s:buffer_side .. " " .. bufferrowmaxsize .. s:buffer_opener .. " " .. s:buffer_name

  execute  "setlocal ft=" .. s:buffer_ft
  setlocal buftype=acwrite bufhidden=wipe noswapfile
  setlocal nonumber norelativenumber
  setlocal conceallevel=3 concealcursor=nvic

  
  call append('$', bufferlines)
  :g/^$/delete_

  augroup plugin_colorlist_file
    autocmd! * <buffer>

    autocmd BufWriteCmd <buffer> nested call s:apply()
    autocmd BufWipeout  <buffer> nested call s:wipeout()
  augroup END

  call s:protect_buffer()
endfunction


function! s:buffer_close()
  echo "Not Implemented"
endfunction


function! s:buffer_toggle()
  echo "Not Implemented"
endfunction



"
" SCRIPT LOCAL
"
function! s:make_line(key, val)
  
endfunction

function! s:get_bufferlist()
  let buffers = readfile(s:bookmark)
  return buffers
endfunction


function! s:parse(line)
  return split(a:line, ": ")
endfunction


function! s:protect_buffer()
  setlocal nomodified nomodifiable readonly
endfunction

function! s:unprotect_buffer()
  setlocal nomodified modifiable noreadonly
endfunction


function! s:init() abort
  command! -buffer -nargs=0         MoveK           :call s:buffer_move_top()
  command! -buffer -nargs=0         MoveJ           :call s:buffer_move_down()
  command! -buffer -nargs=0         BufferSelect    :call s:buffer_setcwd()
  command! -buffer -nargs=0         BufferUpdate    :call s:buffer_update()

  nmap <buffer><silent> q    :q!<CR>
 
  nmap <buffer><silent> R    :BufferUpdate<CR>
  nmap <buffer><silent> j    :MoveJ<CR>
  nmap <buffer><silent> k    :MoveK<CR>
  nmap <buffer><silent> <CR> :BufferSelect<CR>
endfunction


function! s:apply() abort
  " TODO: if needed, add it.
  setlocal nomodified
endfunction


function! s:wipeout() abort
  " TODO: if needed, add it.
endfunction


function! s:isfile(path) abort
  let isempty = glob(a:path)
  return isempty != "" && ! isdirectory(a:path)
endfunction


function! s:isdirectory(path) abort
  let isempty = glob(a:path)
  return isempty != "" && isdirectory(a:path)
endfunction



"
" ACTION LIST
"
function! s:buffer_move_top()
  let lnum = line('.')
  let buffer_min = 1
  exec lnum == buffer_min ? "normal! G" : "normal! k"
endfunction


function! s:buffer_move_down()
  let lnum = line('.')
  let buffer_max = line('$')
  exec lnum == buffer_max ? "normal! gg" : "normal! j"
endfunction


function! s:buffer_update()
  call s:unprotect_buffer()
  echo "test update"

  %delete _
  let bufferlines = s:get_bufferlist()
  call append('$', bufferlines)
  :g/^$/delete_

  call s:protect_buffer()
endfunction



function! s:buffer_setcwd()
  let line = getline('.')
  if s:isdirectory(line)
    exec printf('cd %s', line)
  else
    echomsg printf('%s is not directory', line)
  endif
endfunction

