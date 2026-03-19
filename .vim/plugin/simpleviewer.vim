
" util                                                                                   " {{{2
fun! s:protect_buffer()
  setlocal nomodified nomodifiable readonly
endfun


fun! s:unprotect_buffer()
  setlocal nomodified modifiable noreadonly
endfun



fun! s:init()                                                                            " {{{2
  nnoremap  <buffer><silent> q    <cmd>q!<cr>
  nnoremap  <buffer><silent> t    <C-w>gf
  
  nnoremap  <buffer><silent> e    <cmd>call <sid>tabopen_stay()<cr>
endfun

augroup SimpleViewerFileType
  autocmd! * <buffer>
  autocmd FileType SimpleViewer call s:init()
augroup END


fun! SimpleViewer()                                                                      " {{{2
  let l:current_head = globpath(expand('%:p:h'), '**', v:false, v:true)

  noautocmd hide exec '20sp SimpleViewer'
  exec 'setlocal ft=SimpleViewer'

  setlocal buftype=acwrite bufhidden=wipe noswapfile
  setlocal nonumber norelativenumber
  setlocal conceallevel=3 concealcursor=nvic

  call setline(1, l:current_head)
  call s:protect_buffer()
endfun


" actions                                                                                " {{{2

fun!   s:tabopen_stay()
  let  l:current_tabpagenr =  tabpagenr()
  let  l:cfile             =  expand('<cfile>:p')

  exec '$tabedit ' .. l:cfile
  exec 'tabnext '  .. l:current_tabpagenr
endfun
