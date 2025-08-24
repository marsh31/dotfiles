" NAME:   autoload/markdown/frontmatter.vim
" AUTHOR: marsh
"
" NOTE:
"
" markdown#frontmatter#


" Opening / Closing tokens (very-magic regex)
let s:openingToken = {
      \ 'yaml': '\v^\-{3}\s*$',
      \ 'toml': '\v^\+{3}\s*$',
      \ 'json': '\v^\{\s*$',
      \ }

let s:closingToken = {
      \ 'yaml': '\v^(-{3}|\.{3})\s*$',
      \ 'toml': '\v^\+{3}\s*$',
      \ 'json': '\v^\}\s*$',
      \ }


" Front matter detected result
" Returns a Dict:
"   { 'type': a:type, 'start': a:start, 'end': a:end }
"
fun! s:makeTypeDict(type, start = 0, end = 0) abort
  return { 'type': a:type, 'start': a:start, 'end': a:end }
endfun


" Find closing token
" Returns a number:
"   0      not found
"   other  found
"
" If found: return non 0 value.
" If not found: return 0
"
fun! s:findClose(start_lnum, close_pat, maxl) abort
  let l = a:start_lnum + 1
  while l <= a:maxl
    if getline(l) =~# a:close_pat
      return l
    endif
    let l += 1
  endwhile
  return 0
endfun



" Front matter detector for Markdown buffers
" Returns a Dict:
"   { 'type': 'yaml'|'toml'|'json'|'none', 'start': 0, 'end': 0 }
"
" If found: start/end are 1-based line numbers that cover the front matter block.
" If not found: type='none', start=0, end=0
"
fun! markdown#frontmatter#DetectFrontMatter() abort
  " 1) Check markdown-like filetype
  if &filetype !~# '\v^markdown(\..*)?$'
    return s:makeTypeDict('none')
  endif

  " Find first non-empty line (skip BOM/whitespace-only lines)
  let maxl = line('$')
  let lnum = 1
  while lnum <= maxl && getline(lnum) =~# '^\s*$'
    let lnum += 1
  endwhile
  if lnum > maxl
    return s:makeTypeDict('none')
  endif

  " Strip UTF-8 BOM on that first non-empty line
  let first = substitute(getline(lnum), '^\xEF\xBB\xBF', '', '')

  " --- YAML ---
  if first =~# s:openingToken['yaml']
    let close_lnum = s:findClose(lnum, s:closingToken['yaml'], maxl)
    return close_lnum ? s:makeTypeDict('yaml', lnum, close_lnum) : s:makeTypeDict('none')
  endif

  " +++ TOML +++
  if first =~# s:openingToken['toml']
    let close_lnum = s:findClose(lnum, s:closingToken['toml'], maxl)
    return close_lnum ? s:makeTypeDict('toml', lnum, close_lnum) : s:makeTypeDict('none')
  endif

  " { JSON }
  if first =~# s:openingToken['json']
    let close_lnum = s:findClose(lnum, s:closingToken['json'], maxl)
    return close_lnum ? s:makeTypeDict('json', lnum, close_lnum) : s:makeTypeDict('none')

  elseif first =~# '\v^\{\s*.*\}\s*$'
    return s:makeTypeDict('json', lnum, lnum)
  endif

  " No known front matter
  return s:makeTypeDict('none')
endfun


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generic helpers
"


" has front matter
fun! markdown#frontmatter#HasFrontMatter() abort
  let info = markdown#frontmatter#DetectFrontMatter()
  return info.type ==# 'none' ? 0 : 1
endfun

" 
fun! markdown#frontmatter#FrontMatterType() abort
  return markdown#frontmatter#DetectFrontMatter().type
endfun

fun! markdown#frontmatter#FrontMatterRange() abort
  let info = markdown#frontmatter#DetectFrontMatter()
  return info.type ==# 'none' ? [] : [info.start, info.end]
endfun

