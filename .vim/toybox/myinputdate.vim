
let g:myinputdate = v:false
if g:myinputdate
  finish
endif


" 
" repeat/duration
" repeat/s/time
" repeat/time/e
"
" R[n]/2025-02-02T10:00:00/PT5M
" R[n]/2025-02-02T10:00/PT5M
" R[n]/2025-02-02T10/PT5M
"
" R[n]/2025-02-02T10:00/2025-02-02T10:05
"
"


let s:isodate_format = '%Y-%m-%d'
let s:isotime_format = 'T%H:%M:%S'
let s:isodatetime_format = s:isodate_format .. s:isotime_format






" END {{{
" vim:tw=2 ts=2 et sw=2 nowrap ff=unix fenc=utf-8 foldmethod=marker:
