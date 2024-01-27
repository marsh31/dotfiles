" NAME:   vim-sample.vim
" AUTHOR: marsh
" サンプルのコマンドとか、テストコンフィグを追加。
"

com! -range -nargs=1 OrderNum  call setline('.', map(range(<line1>, <line2>), 'printf(<f-args>, v:val)'))




com! -nargs=+ Calendar call s:calendar(<f-args>)

let s:magic_26m1per10 = [ 1, 4, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5]
function! s:date2weekno(year, month, day)
  " h = (d + 26(m+1) / 10 + Y + int( Y / 4 ) - 2 * y / 100 + y / 400) mod 7
  "      ^   ^^^^^^^^^^^^                    ^^^^^^^^^^^^^^^^^^^^^^^
  "          magic_26m1per10  
  let y = a:year
  let m = a:month
  if m == 1 || m == 2
    let m = m + 12
    let y = y - 1
  endif
  let Y2 = float2nr(y/100)
  let Y = y % 100
  let Yper4 = float2nr(Y/4)
  let xx = float2nr(-2*Y2+float2nr(Y2/4))
  let res = (a:day + s:magic_26m1per10[a:month-1] + Y + Yper4 + xx) % 7

  if res <= 0
    let res = res + 7
  endif
  return res
endfunction


let s:each_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
function s:daysOfManth(year, month)
  let days = 31
  if a:month == 2
    if ((a:year % 400 == 0) || (a:year % 4 == 0) && (a:year != 0))
      let days = s:each_days[a:month-1] + 1
    else
      let days = s:each_days[a:month-1]
    endif
  else
    let days = s:each_days[a:month-1]
  endif
  return days
endfunction

function! s:calendar(year, month) abort
  let weekno = s:date2weekno(a:year, a:month, 1)
  let days = s:daysOfManth(a:year, a:month)

  execute "normal! A Sun Mon Tue Wed Thu Fri Sat"
  execute "normal! o"
  let blank = "    "
  for i in range(1, weekno-1)
    execute "normal! A" .. blank
  endfor

  let start = weekno
  let fin = v:false
  let day = 1
  while v:true
    for i in range(start, 7)
      execute "normal! A" .. printf("%4d", day)

      let day = day + 1
      if day > days
        let fin = v:true
        break
      endif
    endfor
    let start = 1

    if fin
      break
    endif
    execute "normal! o"
  endwhile
endfunction

" command! -nargs=0  ColorSchemeOpen :call s:buffer_output_get_colorscheme()
" command! -nargs=0  ColorChange     :call s:buffer_change_colorscheme()
" function! s:get_color_schemes()
"   return uniq(sort(map(
"         \ globpath(&runtimepath, "colors/*.vim", 0, 1),
"         \ 'fnamemodify(v:val, ":t:r")'
"         \ )))
" endfunction
"
" function! s:buffer_output_get_colorscheme()
"   let opener = "vsplit"
"   let buffername = "colorthemes"
"
"   let bufferlines = map(s:get_color_schemes(), '"colorscheme " .. v:val')
"   let buffercolsizes = map(copy(bufferlines), 'strlen(v:val)')
"   let buffercolmaxsize = max(buffercolsizes) + 10
"
"   noautocmd hide execute buffercolmaxsize .. opener buffername
"   setlocal ft=colorselector buftype=acwrite bufhidden=wipe noswapfile
"   setlocal nonumber norelativenumber
"   call append('$', bufferlines)
"
"   augroup plugin_colorlist_file
"     autocmd! * <buffer>
"     autocmd FileType    colorselector   call s:init()
"     autocmd BufWriteCmd <buffer> nested call s:apply()
"     autocmd BufWipeout  <buffer> nested call s:wipeout()
"   augroup END
" endfunction
"
" function! s:init() abort
"   nmap <buffer> <CR> :ColorChange<CR>
"   nmap <buffer> q    :q!<CR>
" endfunction
"
" function! s:apply() abort
"   " TODO: if needed, add it.
"   setlocal nomodified
" endfunction
"
" function! s:wipeout() abort
"   " TODO: if needed, add it.
" endfunction
"
" function s:buffer_change_colorscheme()
"   let linestr = getline('.')
"   if linestr =~# "^colorscheme "
"     execute linestr
"   endif
" endfunction
