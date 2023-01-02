" 15-qf.vim
"
" Quickfix setting.
"
augroup QFWindow
  autocmd!
  autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen 
augroup END


" MARK: - This is test
if exists('g:QuickfixToggle')
  finish
endif

let g:QuickfixToggle = 1
function! ToggleQuickfix() abort
  let l:nr = winnr('$')
  cwindow
  let l:nr2 = winnr('$')

  if l:nr == l:nr2
    cclose
  endif
endfunction

