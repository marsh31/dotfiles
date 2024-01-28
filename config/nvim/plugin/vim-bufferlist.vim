" Buffer Remover
" Version: 1.1
" Author : marsh

let s:buffer_name   = "bufferlist"

" let s:buffer_opener = "vsplit"
let s:buffer_opener = "split"

" let s:buffer_side   = "leftabove"
let s:buffer_side   = "rightbelow"


command! BufferListOpen call s:buffer_open()

"
" IF
"
function! s:buffer_open()
  augroup plugin_colorlist_file_init
    autocmd! * <buffer>
    execute "autocmd FileType " .. s:buffer_name .. " call s:init()"
  augroup END

  let bufferlines = s:get_bufferlist()
  let bufferrowmaxsize = len(bufferlines) + 5
  let buffercolmaxsize = max(map(copy(bufferlines), 'strlen(v:val)')) + 5

  noautocmd hide execute s:buffer_side .. " " .. bufferrowmaxsize .. s:buffer_opener .. " " .. s:buffer_name

  execute  "setlocal ft=" .. s:buffer_name
  setlocal buftype=acwrite bufhidden=wipe noswapfile
  setlocal nonumber norelativenumber
  setlocal conceallevel=3 concealcursor=nvic


  call append('$', bufferlines)
  :g/^$/delete_

  augroup plugin_colorlist_file
    autocmd! * <buffer>
    " autocmd CursorMoved <buffer> nested call s:buffer_change_colorscheme()

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
function! s:get_bufferlist()
  " TODO: ignore bufferlist.
  let buffers = map(filter(copy(getbufinfo()), 'v:val.listed'), 'printf("%3d: %s", v:val.bufnr, v:val.name)')
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
  command! -buffer -nargs=0  MoveK           :call s:buffer_move_top()
  command! -buffer -nargs=0  MoveJ           :call s:buffer_move_down()
  command! -buffer -nargs=0  DeleteLine      :call s:buffer_delete_line()
  command! -buffer -nargs=0  BufferDelete    :call s:buffer_delete()
  command! -buffer -nargs=0  BufferUpdate    :call s:buffer_update()

  nmap <buffer><silent> q    :q!<CR>
 
  nmap <buffer><silent> dd   :DeleteLine<CR>
  nmap <buffer><silent> j    :MoveJ<CR>
  nmap <buffer><silent> k    :MoveK<CR>
endfunction


function! s:apply() abort
  " TODO: if needed, add it.
  setlocal nomodified
endfunction


function! s:wipeout() abort
  " TODO: if needed, add it.
endfunction



"
" ACTION LIST
"
function! s:buffer_move_top()
  let lnum = line('.')
  let buffer_min = 1

  if lnum == buffer_min
    normal! G
  else
    normal! k
  endif
endfunction


function! s:buffer_move_down()
  let lnum = line('.')
  let buffer_max = line('$')

  if lnum == buffer_max
    normal! gg
  else
    normal! j
  endif
endfunction


function! s:buffer_delete_line()
  call s:unprotect_buffer()

  " TODO: if need range option, add it.
  delete _

  call s:protect_buffer()
endfunction


function! s:buffer_update()
  call s:unprotect_buffer()

  " TODO: if need range option, add it.
  %delete _

  let bufferlines = s:get_bufferlist()

  call append('$', bufferlines)
  :g/^$/delete_


  call s:protect_buffer()
endfunction


function! s:buffer_delete()
  let lines = getline(1, '$')
  let bdlist = map(lines, 'str2nr(s:parse(v:val)[0])')

  for bditem in bdlist
    execute "bd " .. bditem
  endfor
  call s:buffer_update()
endfunction
