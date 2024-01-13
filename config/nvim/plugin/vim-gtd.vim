
function! s:apply() abort
  setlocal nomodified
endfunction


function! s:wipeout(filename) abort
  let lines = getline(0, line('$'))
  call filter(lines, 'v:val !=# ""')
  call writefile(lines, a:filename, "a")
endfunction


function! Omni(findstart, base) abort
  let matches = [ "@test", "@test2", "@test3", "@ok", "@mail", "@teams" ]

  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start - 1
  else
    let res = []
    for item in matches
      if item =~ '^' .. a:base
        call add(res, item)
      endif
    endfor
    return res
  endif
endfunction


function! s:open(opener, buffername) abort
  noautocmd hide execute a:opener a:buffername

  setlocal omnifunc=Omni
  setlocal ft=gtd buftype=acwrite bufhidden=wipe noswapfile
  augroup plugin_gtd_file
    autocmd! * <buffer>
    autocmd BufWriteCmd <buffer> nested call s:apply()
    autocmd BufWipeout  <buffer> nested call s:wipeout(g:GTD_INBOX_FILE)
  augroup END
endfunction


let g:GTD_PATH       = expand('~/til/tm')
let g:GTD_INBOX_FILE = expand('~/til/tm/inbox.txt')




command! -nargs=0  GtdOpen   :call s:open("split", "gtd.inbox.txt")

" vim: set ft=vim
