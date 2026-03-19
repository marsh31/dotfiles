" NAME:   base64
" AUTHOR: marsh
"
" NOTE:
" 
" vim#base64#decode
"


" config variables {{{


let s:base64_table = [
      \ 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
      \ 'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
      \ 'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
      \ 'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/']
let s:base64_pad = '='
let s:base64_atoi_table = {}


" }}}
" vim#base64#decode {{{


fun! vim#base64#decode(seq) abort
  let l:res = ''
  for l:i in range(0, len(a:seq) - 1, 4)
    let l:n = s:decode_base64_atoi(a:seq[l:i]) * 0x40000
          \ + s:decode_base64_atoi(a:seq[l:i + 1]) * 0x1000
          \ + (a:seq[l:i + 2] == s:base64_pad ? 0 : s:decode_base64_atoi(a:seq[l:i + 2])) * 0x40
          \ + (a:seq[l:i + 3] == s:base64_pad ? 0 : s:decode_base64_atoi(a:seq[l:i + 3]))
    let l:res = s:add_str(l:res, l:n / 0x10000)
    let l:res = s:add_str(l:res, l:n / 0x100 % 0x100)
    let l:res = s:add_str(l:res, l:n % 0x100)
  endfor
  return eval('"' . l:res . '"')
endfun


" }}}
" s:decode_base64_atoi {{{


fun! s:decode_base64_atoi(a) abort
  if len(s:base64_atoi_table) == 0
    for l:i in range(len(s:base64_table))
      let s:base64_atoi_table[s:base64_table[l:i]] = l:i
    endfor
  endif
  return s:base64_atoi_table[a:a]
endfun


" }}}
" s:add_str {{{


fun! s:add_str(left, right) abort
    if a:right == 0
        return a:left
    endif
    return a:left . printf("\\x%02x", a:right)
endfun

" }}}
" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
