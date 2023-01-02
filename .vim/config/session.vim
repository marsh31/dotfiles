
let s:session_path = expand('~/.vim/sessions')
if !isdirectory(s:session_path)
  call mkdir(s:session_path, "p")
endif

set sessionoptions=blank,buffers,curdir,folds,help,tabpages,terminal,winsize


" save session
command! -nargs=? SaveSession call s:saveSession(<f-args>)
function! s:saveSession(...)
  wall
  
  let l:file = get(a:000, 1, "")
  if a:0 == 0
    let l:file = input("File: ")
    if l:file ==# ''
      echo "Please input file name"
      return
    endif

  else
    let l:file = a:1
  endif

  if match(l:file, ".*\.vim") == -1
    let l:file = l:file . ".vim"
  endif

  execute 'silent mksession!' s:session_path . "/" . l:file
endfunction


" load session
command! -nargs=? LoadSession call s:loadSession(<f-args>)
function! s:loadSession(...)
  if a:0 >= 1
    execute 'silent source' a:1

  else
    if exists('*fzf#run()')
      call fzf#run({
            \ 'source':  split(glob(s:session_path . "/*"), "\n"),
            \ 'sink':    function('s:loadSession'),
            \ 'options': '+m -x +s',
            \ 'down':    '40%'
            \})

    endif
  endif
endfunction


" delete session
command! -nargs=* DeleteSession call s:deleteSession(<f-args>)
function! s:deleteSession(...)
  if a:0 >= 1
    call s:mul_delete(a:000)

  else
    if exists('*ffzf#run()')
      call fzf#run({
            \ 'source':  split(glob(s:session_path . "/*"), "\n"),
            \ 'sink':    function('s:mul_delete'),
            \ 'options': '-m -x +s',
            \ 'down':    '40%'
            \})
    endif
  endif
endfunction

function! s:mul_delete(...)
  for n in a:000
    call delete(expand(n))
  endfor
endfunction








 
