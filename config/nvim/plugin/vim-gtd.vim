" NAME:   vim-gtd.vim
" AUTHOR: marsh
"

function! s:get_current_date()
    return strftime('%Y-%m-%d')
endfunction

function! s:todo_remove_priority()
    :s/^([A-Z])\s\+//ge
endfunction

function! s:todo_prepend_date()
    execute 'normal! I' . s:get_current_date() . ' '
endfunction

function! s:todo_mark_as_done()
    call s:todo_remove_priority()
    call s:todo_prepend_date()
    execute 'normal! Ix '
endfunction


function! Omni(findstart, base) abort
  " let matches = getline(0, line('$'))
  let matches = readfile(g:GTD_CONTEXT_FILE)

  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start - 1
  else
    let res = []
    for item in matches
      if item =~ '^' .. a:base
        call add(res, item)
      endif
    endfor
    return res
  endif
endfunction


function! s:apply() abort
  setlocal nomodified
endfunction


function! s:wipeout(filename) abort
  let lines = getline(0, line('$'))
  call filter(lines, 'v:val !=# ""')
  call writefile(lines, a:filename, "a")
endfunction


function! s:open(opener, buffername) abort
  noautocmd hide execute a:opener a:buffername

  setlocal omnifunc=Omni
  setlocal ft=gtd buftype=acwrite bufhidden=wipe noswapfile
  augroup plugin_gtd_file
    autocmd! * <buffer>
    autocmd BufWriteCmd <buffer> nested call s:apply()
    autocmd BufWipeout  <buffer> nested call s:wipeout(g:GTD_INBOX_FILE)
  augroup END
endfunction


let g:GTD_PATH              = expand('~/til/tm')
let g:GTD_INBOX_FILE        = expand('~/til/tm/inbox.txt')
let g:GTD_DOC_FILE          = expand('~/til/tm/pointer.txt')
let g:GTD_SOMEDAY_FILE      = expand('~/til/tm/someday.txt')
let g:GTD_WAITING_FILE      = expand('~/til/tm/waiting.txt')
let g:GTD_CALENDAR_FILE     = expand('~/til/tm/calendar.txt')
let g:GTD_ACTION_TODO_FILE  = expand('~/til/tm/action.todo.txt')
let g:GTD_ACTION_DONE_FILE  = expand('~/til/tm/action.done.txt')

let g:GTD_PROJECT_FILE      = expand('~/til/tm/project.txt')
let g:GTD_CONTEXT_FILE      = expand('~/til/tm/context.txt')


command! -nargs=0  GtdOpen            :call s:open("split", "gtd.inbox.txt")

command! -nargs=0  TodoPrependDate    :call s:todo_prepend_date()
command! -nargs=0  TodoRemovePriority :call s:todo_remove_priority()
command! -nargs=0  TodoDone           :call s:todo_mark_as_done()



" vim: set ft=vim
