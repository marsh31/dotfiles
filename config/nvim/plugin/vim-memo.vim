
let g:memo_date_format = "%F"
let g:memo_dir = expand('~/til/learn/memo')
let g:memo_ext = 'md'

command!  -nargs=*  MemoNewOpen  call s:memo_new_open(<q-mods>, <q-args>)

function! s:memo_new_open(mods, str)
  if a:mods =~ '\(horizontal\|vertical\|tab\)'
    let cmd = a:mods .. ' split '
  else
    let cmd = "edit "
  endif

  let l:data = a:str
  if l:data == ""
    let l:data = trim(input('> '), " ")
  endif
  let l:data = substitute(l:data, '\s\+', '_', 'g')


  let l:date = strftime(g:memo_date_format)
  if l:data != ""
    let l:data = '@' . l:data
  endif

  let l:filename = printf('%s%s', l:date, l:data) . '.' . g:memo_ext

  exec cmd . trim(g:memo_dir, "/", 2) . '/' . l:filename
endfunction

