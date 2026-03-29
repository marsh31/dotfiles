" NAME:   plugin/queue.vim
" AUTHOR: marsh
" NOTE:
" Queue 構造の単純な実装
" 


let s:clean_point = 50


function! QueueNew() abort
  return {
        \ 'items': [],
        \ 'head': 0,
        \ }
endfunction


function! QueuePush(q, value) abort
  call add(a:q.items, a:value)
endfunction


function! QueueEmpty(q) abort
  return a:q.head >= len(a:q.items)
endfunction


function! QueuePop(q) abort
  if QueueEmpty(a:q)
    throw 'queue is empty'
  endif

  let l:value = a:q.items[a:q.head]
  let a:q.head += 1

  " たまに掃除して肥大化を防ぐ
  if a:q.head > s:clean_point && a:q.head * 2 >= len(a:q.items)
    let a:q.items = a:q.items[a:q.head :]
    let a:q.head = 0
  endif

  return l:value
endfunction


function! QueuePeek(q) abort
  if QueueEmpty(a:q)
    throw 'queue is empty'
  endif
  return a:q.items[a:q.head]
endfunction


function! QueueLen(q) abort
  return len(a:q.items) - a:q.head
endfunction


" vim: set expandtab tabstop=2 :
