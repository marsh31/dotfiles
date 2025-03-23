" NAME:   parser
" AUTHOR: marsh
"
" NOTE:
"
"

let s:Parser = {
      \ 'remain': '',
      \ 'log': v:null
      \ }

" { 'type': xxx }
" xxx:
"   raw
"   error
"   other
"   match
"   file_begin
"   file_end
"   finish
"



" ##parser {{{
" }}}
" ripgrep#parser#parser {{{


fun! ripgrep#parser#parser() abort
  let ret = deepcopy(s:Parser)
  return ret
endfun


" }}}
" s:Parser.parse {{{


fun! s:Parser.parse(line) abort
  let l:line = self.remain .. a:line

  " Parse json-line from ripgrep (with --json option) to qf-list item.
  let l:line_object = v:null
  try
    let l:line_object = json_decode(a:line)
  catch
  endtry

  if type(l:line_object) != v:t_dict
    let self.remain = l:line
    return v:null
  else
    let self.remain = ''
    return l:line_object
  endif
endfun


" }}}
" s:Parser.reset{{{


fun! s:Parser.reset() abort
  let self.remain = ''
endfun



" }}}
" s:process_begin {{{


fun! s:process_begin(line_object) abort
  " Parse beginning of file from ripgrep.
  let l:begin = a:line_object['data']
  let l:filename = s:process_textlike(l:begin['path'])
  if l:filename is v:null
    return [ ripgrep#parser#type_other(), a:line_object ]
  endif
  return [ ripgrep#parser#type_file_begin(), {'filename': l:filename} ]
endfun


" }}}
" s:process_end {{{


fun! s:process_end(line_object) abort
  " Parse ending of file from ripgrep.
  let l:end = a:line_object['data']
  let l:filename = s:process_textlike(l:end['path'])
  if l:filename is v:null
    return [ ripgrep#parser#type_other(), a:line_object ]
  endif
  return [ ripgrep#parser#type_file_end(), {'filename': l:filename, 'stats': l:end['stats']} ]
endfun


" }}}
" s:process_match(line_object) {{{


function! s:process_match(line_object) abort
    " Parse match-data from ripgrep to qf-list item.
    let l:match =  a:line_object['data']
    let l:filename = s:process_textlike(l:match['path'])
    if l:filename is v:null
        return [ripgrep#parser#type_other(), a:line_object]
    endif
    let l:lnum = l:match['line_number']
    let l:submatches = l:match['submatches']

    " The start is based 0.
    let l:start = l:submatches[0]['start'] + 1
    let l:end = l:submatches[0]['end'] + 1

    let l:linetext = s:process_textlike(l:match['lines'])
    if l:linetext is v:null
        return [ripgrep#parser#type_other(), a:line_object]
    end
    let l:linetext = trim(l:linetext, "\n", 2)
    return [
        \ ripgrep#parser#type_match(), {
            \ 'filename': l:filename,
            \ 'lnum': l:lnum,
            \ 'col': l:start,
            \ 'end_col': l:end,
            \ 'text': l:linetext,
        \ }
    \ ]
endfunction


" }}}
" s:process_textlike(textlike) {{{


function! s:process_textlike(textlike) abort
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
endfunction


" }}}
" ##parser type {{{
"
" }}}
" ripgrep#parser#type_raw  {{{

fun! ripgrep#parser#type_raw()
  return 'raw'
endfun

" }}}
" ripgrep#parser#type_error {{{

fun! ripgrep#parser#type_error()
  return 'error'
endfun

" }}}
" ripgrep#parser#type_other {{{

fun! ripgrep#parser#type_other()
  return 'other'
endfun

" }}}
" ripgrep#parser#type_match {{{

fun! ripgrep#parser#type_match()
  return 'match'
endfun

" }}}
" ripgrep#parser#type_file_begin {{{

fun! ripgrep#parser#type_file_begin()
  return 'file_begin'
endfun

" }}}
" ripgrep#parser#type_file_end {{{

fun! ripgrep#parser#type_file_end()
  return 'file_end'
endfun

" }}}
" ripgrep#parser#type_finish {{{

fun! ripgrep#parser#type_finish()
  return 'finish'
endfun

" }}}
" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
