" NAME:   parser
" AUTHOR: marsh
"
" NOTE:
"
"

let s:Parser = {
      \ 'remain': ''
      \ }

let s:types = {
      \ 'raw': 'raw',
      \ 'error': 'error',
      \ 'other': 'other',
      \ 'match': 'match',
      \ 'file_begin': 'file_begin',
      \ 'file_end': 'file_end',
      \ 'finish': 'finish'
      \ }

fun! s:parser_new() abort
  return deepcopy(s:Parser)
endfun

fun! s:get_type(name) abort
  return get(s:types, a:name, s:types.other)
endfun

" *ripgrep#parser#new()* ripgrep の JSON 出力を扱う Parser オブジェクトを生成する。
fun! ripgrep#parser#new() abort
  return s:parser_new()
endfun

" *ripgrep#parser#parser()* 互換用の別名。新しい Parser オブジェクトを返す。
fun! ripgrep#parser#parser() abort
  return ripgrep#parser#new()
endfun

fun! s:Parser.parse(line) abort
  let l:payload = self.remain .. a:line
  let l:line_object = v:null
  try
    let l:line_object = json_decode(l:payload)
  catch
    let self.remain = l:payload
    return v:null
  endtry

  if type(l:line_object) != v:t_dict
    let self.remain = l:payload
    return v:null
  endif

  let self.remain = ''
  return l:line_object
endfun

fun! s:Parser.reset() abort
  let self.remain = ''
endfun

fun! s:process_begin(line_object) abort
  let l:begin = a:line_object['data']
  let l:filename = s:process_textlike(l:begin['path'])
  if l:filename is v:null
    return [s:get_type('other'), a:line_object]
  endif
  return [s:get_type('file_begin'), {'filename': l:filename}]
endfun

fun! s:process_end(line_object) abort
  let l:end = a:line_object['data']
  let l:filename = s:process_textlike(l:end['path'])
  if l:filename is v:null
    return [s:get_type('other'), a:line_object]
  endif
  return [s:get_type('file_end'), {'filename': l:filename, 'stats': l:end['stats']}]
endfun

fun! s:process_match(line_object) abort
  let l:match = a:line_object['data']
  let l:filename = s:process_textlike(l:match['path'])
  if l:filename is v:null
    return [s:get_type('other'), a:line_object]
  endif

  let l:lnum = l:match['line_number']
  let l:submatches = l:match['submatches']
  if empty(l:submatches)
    return [s:get_type('other'), a:line_object]
  endif

  let l:start = l:submatches[0]['start'] + 1
  let l:end = l:submatches[0]['end'] + 1

  let l:linetext = s:process_textlike(l:match['lines'])
  if l:linetext is v:null
    return [s:get_type('other'), a:line_object]
  endif
  let l:linetext = trim(l:linetext, "\n", 2)

  return [
        \ s:get_type('match'), {
        \   'filename': l:filename,
        \   'lnum': l:lnum,
        \   'col': l:start,
        \   'end_col': l:end,
        \   'text': l:linetext,
        \ }
        \ ]
endfun

fun! s:process_textlike(textlike) abort
  if has_key(a:textlike, 'text')
    return a:textlike['text']
  elseif has_key(a:textlike, 'bytes')
    return vim#base64#decode(a:textlike['bytes'])
  endif
  return v:null
endfun

" *ripgrep#parser#type()* 指定名のイベント種別文字列を取得する。
fun! ripgrep#parser#type(type_name) abort
  return s:get_type(a:type_name)
endfun

" *ripgrep#parser#type_raw()* Raw イベント種別を返す。
fun! ripgrep#parser#type_raw() abort
  return s:get_type('raw')
endfun

" *ripgrep#parser#type_error()* Error イベント種別を返す。
fun! ripgrep#parser#type_error() abort
  return s:get_type('error')
endfun

" *ripgrep#parser#type_other()* その他のイベント種別を返す。
fun! ripgrep#parser#type_other() abort
  return s:get_type('other')
endfun

" *ripgrep#parser#type_match()* Match イベント種別を返す。
fun! ripgrep#parser#type_match() abort
  return s:get_type('match')
endfun

" *ripgrep#parser#type_file_begin()* ファイル開始イベント種別を返す。
fun! ripgrep#parser#type_file_begin() abort
  return s:get_type('file_begin')
endfun

" *ripgrep#parser#type_file_end()* ファイル終了イベント種別を返す。
fun! ripgrep#parser#type_file_end() abort
  return s:get_type('file_end')
endfun

" *ripgrep#parser#type_finish()* Finish イベント種別を返す。
fun! ripgrep#parser#type_finish() abort
  return s:get_type('finish')
endfun

" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
