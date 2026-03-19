" NAME:   percent
" AUTHOR: marsh
"
" NOTE:
" {{{
"
" ウィキペディア
" 
" }}}
"
"

" vim#data#percent#encode {{{


fun! vim#data#percent#encode(data, code = 'utf-8') abort
  let enc = substitute(iconv(a:data, 'latin1', a:code), '[^A-Za-z0-9_.~-]', '\="%".printf("%02X", char2nr(submatch(0)))', 'g')
  return enc
endfun


" }}}
" vim#data#percent#decode {{{


fun! vim#data#percent#decode(data, code = 'utf-8') abort
  let dec = iconv(substitute(a:data, '%[0-9a-fA-F]\+', '\=nr2char(str2nr(submatch(0)[1:-1], 16))', 'g'), a:code, 'latin1')
  return dec
endfun


" }}}

" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
