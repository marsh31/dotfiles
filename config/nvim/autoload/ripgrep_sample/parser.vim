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
    return [ ripgrep#event#raw(), {'raw': a:line} ]
  else
    let self.remain = ''
  endif

  let l:type = get(l:line_object, 'type', '')
  if l:type ==# 'begin'
    return s:process_begin(l:line_object)
  elseif l:type ==# 'match'
    return s:process_match(l:line_object)
  elseif l:type ==# 'end'
    return s:process_end(l:line_object)
  else
    return [ ripgrep#event#other(), l:line_object ]
  endif
endfun


" }}}
" s:process_begin {{{


fun! s:process_begin(line_object) abort
  " Parse beginning of file from ripgrep.
  let l:begin = a:line_object['data']
  let l:filename = s:process_textlike(l:begin['path'])
  if l:filename is v:null
    return [ ripgrep#event#other(), a:line_object ]
  endif
  return [ ripgrep#event#file_begin(), {'filename': l:filename} ]
endfun


" }}}
" s:process_end {{{


fun! s:process_end(line_object) abort
  " Parse ending of file from ripgrep.
  let l:end = a:line_object['data']
  let l:filename = s:process_textlike(l:end['path'])
  if l:filename is v:null
    return [ ripgrep#event#other(), a:line_object ]
  endif
  return [ ripgrep#event#file_end(), {'filename': l:filename, 'stats': l:end['stats']} ]
endfun


" }}}
" s:process_match(line_object) {{{


function! s:process_match(line_object) abort
    " Parse match-data from ripgrep to qf-list item.
    let l:match =  a:line_object['data']
    let l:filename = s:process_textlike(l:match['path'])
    if l:filename is v:null
        return [ripgrep#event#other(), a:line_object]
    endif
    let l:lnum = l:match['line_number']
    let l:submatches = l:match['submatches']

    " The start is based 0.
    let l:start = l:submatches[0]['start'] + 1
    let l:end = l:submatches[0]['end'] + 1

    let l:linetext = s:process_textlike(l:match['lines'])
    if l:linetext is v:null
        return [ripgrep#event#other(), a:line_object]
    end
    let l:linetext = trim(l:linetext, "\n", 2)
    return [
        \ ripgrep#event#match(), {
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
" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
