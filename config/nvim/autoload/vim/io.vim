""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" confirm
" 
" args
"   msg
"     "message"
"
"   choices
"     [ "&Yes", "&No" ]
"     [ "Yes" , "No"  ]
"     [ "Save", "Save &All" ]
"     => "%s, %s : "
"
"   default
"     0, 1, ..N
"
"   type
"     1     MoreMsg
"     2     
"     other MoreMsg
" 
" return
"   0, 1, 2, ...
function! vim#io#confirm(msg, choices = [ ], default = 0, type = 1) abort
  let default = 'Ok'

  let choice_tbl = { }
  let choice_lst = a:choices
  if empty(choice_lst)
    let choice_lst = [ default ]
  endif

  let choice_msgs = [ ]
  let index = 1
  for ch in choice_lst
    let [ key, is_specified ] = <SID>get_shortcutkey(ch)
    let ch_msg = <SID>convert_msg(ch, key, is_specified)
    
    let choice_tbl[tolower(key)] = index
    let index = index + 1

    call add(choice_msgs, ch_msg)
  endfor
  let choice = join(choice_msgs, ', ')

  echohl MoreMsg
  echo a:msg
  echo choice . ': '
  echohl None

  let l:in_ch = tolower(nr2char(getchar()))
  let result = has_key(choice_tbl, in_ch) ? choice_tbl[in_ch] : a:default
  return result
endfunction


function! s:get_shortcutkey(msg)
  let isSpecified = v:true
  let [ key, judge, _ ] = matchstrpos(a:msg, '&\zs.\ze')
  if judge == -1
    let [ key, _, _ ] = matchstrpos(a:msg, '^\zs.\ze')
    let isSpecified = v:false
  endif

  return [ key, isSpecified ]
endfunction


function! s:convert_msg(msg, key, is_specified)
  if a:is_specified
    return substitute(a:msg, '&.', '(' . a:key . ')', '')
  else
    return substitute(a:msg, '^.', '(' . a:key . ')', '')
  endif
endfunction


