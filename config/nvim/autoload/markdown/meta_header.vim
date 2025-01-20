" NAME:   meta_header
" AUTHOR: marsh
"
" NOTE:
"
"

function! markdown#meta_header#getmdheader(file, head = 10) abort
  let l:lines = readfile(a:file, '', a:head)
  let l:result = {}

  if empty(l:lines) || l:lines[0] !~ '^-\+$'
    return l:result
  endif

  for l:line in l:lines[1:]
    if l:line =~ '^-\+$'
      break
    endif

    let l:mlist = matchlist(l:line, '\(.\+\):\s\+\(.\+\)')
    if !empty(l:mlist)
      let l:result[l:mlist[1]] = s:get_list(l:mlist[2])
    endif
  endfor

  return l:result
endfunction


function! s:get_list(valstr) abort
  let l:mlist = matchlist(a:valstr, '\[\(.\+\)\]')
  let l:start = 0
  if !empty(l:mlist)
    let l:result = []

    let l:mres = matchstrpos(l:mlist[1], '\s*\zs\([^,]\+\)\ze,\?', l:start)
    while l:mres[2] != -1
      call add(l:result, l:mres[0])
      let l:mres = matchstrpos(l:mlist[1], '\s*\zs\([^,]\+\)\ze,\?', l:mres[2])
    endwhile

    return l:result
  elseif !empty(matchlist(a:valstr, '\[\s\+\]'))

    return []
  else

    return a:valstr
  endif
endfunction
