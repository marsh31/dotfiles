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


function! s:get_when_tags(line) abort
  return matchstr(a:line, '\swhen:\zs\(\w\+\)\ze\s\?', 0)
endfunction

function! s:judge_insert(when_tag) abort
  return v:true
endfunction

function! s:make_insert_txt(line) abort
  return "this is test"
endfunction

function! s:autoload_file() abort
  let lines = readfile(g:GTD_AUTOLOAD_FILE)
  for line in lines
    let when_tag = s:get_when_tags(line)
    if s:judge_insert(when_tag)
      " https://qiita.com/wariichi/items/f935f726ddfeb743e70d
      let insert_str = substitute(line, "^\(([A-Z])\s\+\)?\(.\+\)$", "\1xxx \=strftime('%Y-%m-%d') \2", "")
      call writefile([insert_str], g:GTD_ACTION_TODO_FILE, "a")
    endif
  endfor
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

let g:GTD_AUTOLOAD_FILE     = expand('~/til/tm/autoload.txt')


command! -nargs=0  GtdOpen            :call s:open("split", "gtd.inbox.txt")

command! -nargs=0  GtdInbox           :execute "split" g:GTD_INBOX_TODO_FILE
command! -nargs=0  GtdDoc             :execute "split" g:GTD_DOC_FILE
command! -nargs=0  GtdSomeday         :execute "split" g:GTD_SOMEDAY_FILE
command! -nargs=0  GtdWaiting         :execute "split" g:GTD_WAITING_FILE
command! -nargs=0  GtdCalendar        :execute "split" g:GTD_CALENDAR_FILE
command! -nargs=0  GtdAction          :execute "split" g:GTD_ACTION_TODO_FILE
command! -nargs=0  GtdAutoload        :call s:autoload_file()

command! -nargs=0  GtdProject         :execute "split" g:GTD_PROJECT_FILE
command! -nargs=0  GtdContext         :execute "split" g:GTD_CONTEXT_FILE

command! -nargs=0 -range TodoPrependDate    :<line1>, <line2>call s:todo_prepend_date()
command! -nargs=0 -range TodoRemovePriority :<line1>, <line2>call s:todo_remove_priority()
command! -nargs=0 -range TodoDone           :<line1>, <line2>call s:todo_mark_as_done()



" vim: set ft=vim
