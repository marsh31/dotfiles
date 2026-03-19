" 
"
"



function! vim#regmonitor#open()
  call s:init()

  echo s:get_buffer_items()

endfunction


function! s:init()

  let s:plugin_name = "regmonitor"
  let s:buffer_name = "RegMonitor"
  let s:buffer_ft   = "rm"
  let s:buffer_open = "vsplit"
  let s:buffer_side = "rightbelow"
  let s:buffer_temp = expand('~/til/info/reg.txt')

  exec printf("augroup plugin_%s", s:plugin_name)
  
  exec        "autocmd! *"
  exec printf("autocmd BufEnter  %s call s:enter_buffer()", s:buffer_name)
  exec printf("autocmd BufHidden %s call s:hide_buffer()",  s:buffer_name)

  exec        "augroup END"

endfunction


function! s:converter(line)
  echo '>' a:line
  let l:line = a:line
  let l:item = matchstrpos(l:line, '{{vim:\zs.\+\ze}}', 0)

  echo l:item
  while l:item[1] != -1
    echo "hoge"
    execute('let l:res = ' .. l:item[0])
    echo "l:res = " l:item[0]
    echo "l:res is " l:res

    let l:line = substitute(l:line, '{{vim:' .. l:item[0] .. '}}', l:res, '')
    echo  '1>' l:line

    let l:item = matchstrpos(l:line, '{{vim:\zs.\+\ze}}', l:item[2] - 1)
  endwhile
  echo 'res:' l:line

  return l:line
endfunction

function! s:get_buffer_items()

  let l:input_buffers = readfile(s:buffer_temp)
  let l:output_buffers = []
  
  for l:item in l:input_buffers
    echo "s:get_buffer_items:" l:item
    call add(l:output_buffers, s:converter(l:item))
  endfor

  echo l:output_buffers
  return l:output_buffers
endfunction



