" NAME:   vim-mtable.vim
" AUTHOR: marsh
"
" NOTE
"


command! -nargs=+ MarkdownTable :call s:markdown_table(<f-args>)

function! s:markdown_table(...) abort
  if a:0 == 2
    let row = a:1
    let col = a:2

    let i = 1
    let buf = s:row_header(col)
    while i < row
      let addbuf = s:empty_row(col)
      let buf = extend(buf, addbuf)

      let i = i + 1
    endwhile
  endif

  call append('.', buf)
endfunction


function! s:empty_row(col) abort
  let buf = '|'
  let i = 0
  while i < a:col
    let buf = buf . '     |'
    let i = i + 1
  endwhile

  return [buf]
endfunction


function! s:row_header(col) abort
  let headerbuf = '|'
  let sepbuf = '|'
  let i = 0

  while i < a:col
    let headerbuf = headerbuf . '     |'
    let sepbuf = sepbuf . ' --- |'
    let i = i + 1
  endwhile

  return [headerbuf, sepbuf]
endfunction


