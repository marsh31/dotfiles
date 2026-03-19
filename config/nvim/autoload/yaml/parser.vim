" NAME:   parser.vim
" AUTHOR: marsh
"
"
"
"
"


" let s:parser {{{

let s:parser = {
      \ 'result': {},
      \ 'current_key': '',
      \ 'current_list': []
      \ 'current_indent': 1
      \ }


" }}}
" yaml#parser#parser() {{{

fun! yaml#parser#parser() abort
  let result = deepcopy(s:parser)
  return result
endfun

" }}}
" s:parser.parse {{{

fun! s:parser.parse(lines) abort
  for line in a:lines
    if line =~ '^\s*$' || line =~ '^\s*#'
      continue
    endif

    " リストの解析
    if line =~ '^\s*-\s*\(.*\)'
      let item = matchstr(line, '^\s*-\s*\(.*\)')
      call add(self.current_list, item)
      continue
    endif

    " キー: 値の解析
    if line =~ '^\s*\(\k\+\):\s*\(.*\)'
      " 以前のリストを保存
      if !empty(self.current_key) && !empty(self.current_list)
        let self.result[self.current_key] = self.current_list
        let self.current_list = []
      endif

      let self.current_key = matchstr(line, '^\s*\(\k\+\):')
      let value = matchstr(line, ':\s*\(.*\)$')

      " 値がない場合はリスト開始
      if value == ''
        let self.current_list = []
      else
        let self.result[self.current_key] = value
        let self.current_key = ''
      endif
      continue
    endif
  endfor

  " 最後のリストを保存
  if !empty(self.current_key) && !empty(self.current_list)
    let self.result[self.current_key] = self.current_list
  endif

  return self.result
endfun

" }}}
" {{{



" }}}
" {{{



" }}}


let yaml_lines = [
      \ '# this: test',
      \ 'title: Vimscript YAML',
      \ 'author: John Doe',
      \ 'tags:',
      \ '  - vim',
      \ '  - yaml',
      \ '  - parsing',
      \ 'age: 22',
      \ 'bool01: true',
      \ 'bool02: false',
      \ 'null: null',
      \ 'list02: [this, is, test]',
      \ 'list03:',
      \ '  [this, is, test]',
      \ ]
let parser = yaml#parser#parser()
echomsg parser.parse(yaml_lines)








" END {{{
" vim: set nowrap foldmethod=marker :
