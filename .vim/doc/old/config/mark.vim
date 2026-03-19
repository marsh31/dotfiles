" 15-mark.vim
"
" mark setting.

if !exists('g:markrement_chars')
  let g:markrement_chars = [
  \ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
  \ 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  \ ]
endif

nnoremap <silent>mm :<C-u>call <SID>AutoMarkrement()<CR>
function! s:AutoMarkrement() abort
  if !exists('b:markrement_pos')
    let b:markrement_pos = 0
  else
    let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_chars)
  endif

  execute 'mark' g:markrement_chars[b:markrement_pos]
  echo 'marked' g:markrement_chars[b:markrement_pos]
endfunction
