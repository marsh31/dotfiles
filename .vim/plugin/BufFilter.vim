" 
"
"
"
"

if exists('g:loaded_buffilter')
  finish
endif
let g:loaded_buffilter = 1

command! -nargs=? BufFilter      call s:filter_to_buffer(<q-args>)
command! -nargs=0 BufFilterInfo  call s:filter_info()

fun! s:filter_to_buffer(...) abort
  
  let l:pat = @/
  if len(a:000) ==# 1 && a:000[0] !=# ''
    let l:pat = a:000[0]
  endif

  let l:srcbuf  = bufnr('%')
  let l:srcname = bufname('%')

  let l:matched_lines = []
  let l:matched_lnums = []

  for lnum in range(1, line('$'))
    let l:text = getline(lnum)
    if l:text =~# l:pat
      call add(l:matched_lines, l:text)
      call add(l:matched_lnums, lnum)
    endif
  endfor

  " 新しい編集用バッファを開く
  botright new
  setlocal buftype=nofile bufhidden=wipe noswapfile
  setlocal modifiable

  let b:buffilter_source_buf    = l:srcbuf
  let b:buffilter_source_name   = l:srcname
  let b:buffilter_pattern       = l:pat
  let b:buffilter_source_lnums  = l:matched_lnums

  if empty(l:matched_lines)
    call setline(1, [''])
  else
    call setline(1, l:matched_lines)
  endif

  exec 'file [BufFilter ' . fnameescape(fnamemodify(l:srcname, ':t')) . ']'
  normal! gg

endfun



fun! s:filter_info()

  if ! exists('b:buffilter_source_buf')
    finish
  endif

  echom "Name:    " .. b:buffilter_source_name .. '('.. b:buffilter_source_buf ..')'
  echom "Pattern: " .. b:buffilter_pattern

endfun

" E303: Unable to open swap file for "plugin/BufFilter.vim", recovery impossible

" vim: set ft=vim expandtab tabstop=2 :
