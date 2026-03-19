" File setting.

" File save
set nobackup
set noswapfile
set nowritebackup


" Save shech
" set confirm
set hidden


" auto save and auto read
set autowrite
set autoread


" Use checktime when enter window or not use cursor while constantly time
" Feature like autoread
function! s:autoread()
  if expand("%") != "[Command Line]"
    checktime
  endif
endfunction


augroup winEnterChecktime
  autocmd!
  autocmd WinEnter,CursorHold * :call s:autoread()
augroup END


