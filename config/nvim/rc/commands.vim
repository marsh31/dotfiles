"=======================================
" FILE:   plugins/commands.vim
" AUTHOR: marsh
"
" Command config file.
"=======================================

command! ToggleSearchHighlight setlocal hlsearch!
command! ToggleWrap setlocal wrap!
command! ToggleRelativeNumber setlocal relativenumber!

function! s:grep(word) abort
  cexpr system(printf('%s "%s"', &grepprg, a:word)) | cw
  echo printf('Search "%s"', a:word)
endfunction
command! -nargs=1 Grep       :call <SID>grep(<q-args>)
command! -nargs=1 GrepTab    :tabnew | :silent grep --sort-files <args>
command! -nargs=1 GrepTabNSF :tabnew | :silent grep <args>

command! Tig :tabnew term://tig

command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

function! s:toggleQuickfix() abort
  let nr = winnr('$')
  cwindow
  let nr2 = winnr('$')
  if nr == nr2
    cclose
  endif
endfunction
command! ToggleQuickfix :silent call s:toggleQuickfix()<CR>




" vim: sw=2 sts=2 expandtab fenc=utf-8
