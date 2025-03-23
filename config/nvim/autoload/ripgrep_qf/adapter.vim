" NAME:   adapter
" AUTHOR: marsh
"
" NOTE:
"
"

"
" ripgrep_qf#adapter#convert {{{

fun! ripgrep_qf#adapter#convert(line_object) abort
  let l:type = get(a:line_object, 'type', '')
  if l:type ==# 'begin'
    return s:process_begin(a:line_object)
  elseif l:type ==# 'match'
    return s:process_match(a:line_object)
  elseif l:type ==# 'end'
    return s:process_end(a:line_object)
  else
    return ["other", a:line_object]
  endif
endfun

" }}}
" s:process_begin(line_object) {{{


fun! s:process_begin(line_object) abort
    " Parse beginning of file from ripgrep.
    let l:begin = a:line_object['data']
    let l:filename = s:process_textlike(l:begin['path'])
    if l:filename is v:null
        return ["other", a:line_object]
    endif
    return ['file_begin', {'filename': l:filename}]
endfun


" }}}
" s:process_match(line_object) {{{


fun! s:process_match(line_object) abort
    " Parse match-data from ripgrep to qf-list item.
    let l:match =  a:line_object['data']
    let l:filename = s:process_textlike(l:match['path'])
    if l:filename is v:null
        return ['other', a:line_object]
    endif
    let l:lnum = l:match['line_number']
    let l:submatches = l:match['submatches']
    " The start is based 0.
    let l:start = l:submatches[0]['start'] + 1
    let l:end = l:submatches[0]['end'] + 1


    let l:linetext = s:process_textlike(l:match['lines'])
    if l:linetext is v:null
        return ['other', a:line_object]
    end
    let l:linetext = trim(l:linetext, "\n", 2)
    return [
        \ 'match', {
            \ 'filename': l:filename,
            \ 'lnum': l:lnum,
            \ 'col': l:start,
            \ 'end_col': l:end,
            \ 'text': l:linetext,
        \ }
    \ ]
endfun


" }}}
" s:process_end(line_object) {{{


fun! s:process_end(line_object) abort
    " Parse ending of file from ripgrep.
    let l:end = a:line_object['data']
    let l:filename = s:process_textlike(l:end['path'])
    if l:filename is v:null
        return ['other', a:line_object]
    endif
    return ['file_end', {'filename': l:filename, 'stats': l:end['stats']}]
endfun


" }}}
" s:process_textlike(textlike) {{{


fun! s:process_textlike(textlike) abort
    " Decode an object like a text:
    "   - (text): {'text':'value'}  (raw string)
    "   - (text): {'bytes':"Zml6eg=="}  (base 64 encoded)
    if has_key(a:textlike, 'text')
        return a:textlike['text']
    elseif has_key(a:textlike, 'bytes')
        return vim#base64#decode(a:textlike['bytes'])
    else
        return v:null
    end
endfun



" }}}
" ripgrep_qf#adapter#add_match(match_object) {{{


fun! ripgrep_qf#adapter#add_match(found, match_object) abort
  let l:found = a:found
  if !l:found
    bo copen
  endif

  let l:found = v:true
  call setqflist([a:match_object], 'a')

  return l:found
endfun


" }}}
" ripgrep_qf#adapter#finish(found, arg, status) {{{

fun! ripgrep_qf#adapter#finish(found, arg, status) abort
  if l:found
    let l:title = 'Ripgrep'
    if a:arg !=# ''
      let l:title = l:title . ' ' . a:arg
    endif

    call setqflist([], 'a', { 'title': l:title })
  endif
endfun

" }}}
" ripgrep_qf#adapter#reset() {{{
fun! ripgrep_qf#adapter#reset() abort
  call setqflist([], ' ')
endfun


" }}}



" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
