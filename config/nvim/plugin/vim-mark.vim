" NAME:   vim-mark.vim
" AUTHOR: marsh
"
" NOTE:
"
" 宿題は、マークViewを更新する処理を追加する。
" もし、WindowListにMarkViewがあれば、Markの処理をしたときにViewの更新処理を走らせる。
"
" あとは、Refresh処理が暫定のものだからあとで修正する。
"
" Mark使わなくてもいいかも。場所の動機がサインと取れていない。


" let s:Marks {{{
let s:Marks = {
      \ 'a': { 'id': 1,  'priority': 40 },
      \ 'b': { 'id': 2,  'priority': 40 },
      \ 'c': { 'id': 3,  'priority': 40 },
      \ 'd': { 'id': 4,  'priority': 40 },
      \ 'e': { 'id': 5,  'priority': 40 },
      \ 'f': { 'id': 6,  'priority': 40 },
      \ 'g': { 'id': 7,  'priority': 40 },
      \ 'h': { 'id': 8,  'priority': 40 },
      \ 'i': { 'id': 9,  'priority': 40 },
      \ 'j': { 'id': 10, 'priority': 40 },
      \ 'k': { 'id': 11, 'priority': 40 },
      \ 'l': { 'id': 12, 'priority': 40 },
      \ 'm': { 'id': 13, 'priority': 40 },
      \ 'n': { 'id': 14, 'priority': 40 },
      \ 'o': { 'id': 15, 'priority': 40 },
      \ 'p': { 'id': 16, 'priority': 40 },
      \ 'q': { 'id': 17, 'priority': 40 },
      \ 'r': { 'id': 18, 'priority': 40 },
      \ 's': { 'id': 19, 'priority': 40 },
      \ 't': { 'id': 20, 'priority': 40 },
      \ 'u': { 'id': 21, 'priority': 40 },
      \ 'v': { 'id': 22, 'priority': 40 },
      \ 'w': { 'id': 23, 'priority': 40 },
      \ 'x': { 'id': 24, 'priority': 40 },
      \ 'y': { 'id': 25, 'priority': 40 },
      \ 'z': { 'id': 26, 'priority': 40 },
      \ 'A': { 'id': 27, 'priority': 40 },
      \ 'B': { 'id': 28, 'priority': 40 },
      \ 'C': { 'id': 29, 'priority': 40 },
      \ 'D': { 'id': 30, 'priority': 40 },
      \ 'E': { 'id': 31, 'priority': 40 },
      \ 'F': { 'id': 32, 'priority': 40 },
      \ 'G': { 'id': 33, 'priority': 40 },
      \ 'H': { 'id': 34, 'priority': 40 },
      \ 'I': { 'id': 35, 'priority': 40 },
      \ 'J': { 'id': 36, 'priority': 40 },
      \ 'K': { 'id': 37, 'priority': 40 },
      \ 'L': { 'id': 38, 'priority': 40 },
      \ 'M': { 'id': 39, 'priority': 40 },
      \ 'N': { 'id': 40, 'priority': 40 },
      \ 'O': { 'id': 41, 'priority': 40 },
      \ 'P': { 'id': 42, 'priority': 40 },
      \ 'Q': { 'id': 43, 'priority': 40 },
      \ 'R': { 'id': 44, 'priority': 40 },
      \ 'S': { 'id': 45, 'priority': 40 },
      \ 'T': { 'id': 46, 'priority': 40 },
      \ 'U': { 'id': 47, 'priority': 40 },
      \ 'V': { 'id': 48, 'priority': 40 },
      \ 'W': { 'id': 49, 'priority': 40 },
      \ 'X': { 'id': 50, 'priority': 40 },
      \ 'Y': { 'id': 51, 'priority': 40 },
      \ 'Z': { 'id': 52, 'priority': 40 },
      \ }
" }}}

" let s:MarkPriority {{{

let s:MarkPriority = [
      \ 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'z', 'c', 'x', 'v', 'b', 'n', 'm', 
      \ 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'Z', 'C', 'X', 'V', 'B', 'N', 'M'
      \ ]

" }}}

let s:MarkSignName      = "MyMarkSign_"
let s:MarkSignGroupName = "MyMarkSignGroup"

let s:MarkViewName      = "MarkSignView"
let s:MarkViewOpener    = "vsplit"
let s:MarkViewDirection = "rightbelow"


command!                MarkInit             :call s:init()
command!       -nargs=1 MarkSet              :call s:mark_set(<f-args>)
command! -bang -nargs=1 MarkJump             :call s:mark_jump("<bang>", <f-args>)
command!       -nargs=0 MarkResetToPriority  :call s:mark_reset_to_priority()
command!       -nargs=0 MarkView             :call s:mark_view()


for key in keys(s:Marks)
  " echo printf("nmap <Plug>(mark-set-%s) :<C-u>MarkSet %s", key, key)
  exec printf("nmap <Plug>(mark-set-%s)  :<C-u>MarkSet %s<CR>", key, key)
  exec printf("nmap <Plug>(mark-jump-%s) :<C-u>MarkJump %s<CR>", key, key)

  exec printf("nmap <Leader>mm%s <Plug>(mark-set-%s)", key, key)
  exec printf("nmap <Leader>mk%s <Plug>(mark-jump-%s)", key, key)
endfor




fun! s:init()
  for key in keys(s:Marks)
    call sign_define(s:MarkSignName . key, { "texthl": "Error", "text": key })
  endfor
endfun


fun! s:mark_set(mark)
  if a:mark =~ '[a-zA-Z]'
    exec "mark " . a:mark
    call sign_place(s:Marks[a:mark]['id'], 
          \ s:MarkSignGroupName, 
          \ s:MarkSignName . a:mark, 
          \ bufnr('%'), 
          \ { 'lnum': line('.'), 'priority': s:Marks[a:mark]['priority'] })
  endif
endfun


fun! s:mark_jump(bang, mark)
  if a:mark =~ '[a-zA-Z]'
    call sign_jump(s:Marks[a:mark]['id'], s:MarkSignGroupName, bufnr('%'))
  endif

  if a:bang == "!"
    echomsg "bang"
  endif
endfun


fun! s:mark_reset_to_priority()
  let places = sign_getplaced(bufnr('%'), { 'group': s:MarkSignGroupName })
  echo places[0].signs
  echo "test"
endfun


fun! s:mark_view()
  let view_config = s:mark_view_config()
  let bnr = bufnr('%')

  call s:mark_view_create(view_config['open_cmd'], view_config['ft'])
  call s:mark_view_refresh(bnr)
  call s:mark_view_autocmd()

endfun


function! s:protect_buffer()
  setlocal nomodified nomodifiable readonly
endfunction

function! s:unprotect_buffer()
  setlocal nomodified modifiable noreadonly
endfunction


fun! s:mark_view_config()
  let config = {}

  let config['name'] = s:MarkViewName
  let config['open_cmd'] = printf("%s %s%s %s", s:MarkViewDirection, '', s:MarkViewOpener, s:MarkViewName)
  let config['ft'] = 'marksignview'

  return config
endfun


fun! s:mark_view_create(open, ft)
  noautocmd hide execute a:open

  execute  "setlocal ft=" .. a:ft
  setlocal buftype=acwrite bufhidden=wipe noswapfile
  setlocal nonumber norelativenumber nowrap
  setlocal conceallevel=3 concealcursor=nvic

endfun


fun! s:mark_view_refresh(bufnr)
  call s:unprotect_buffer()

  %delete _
  let places = sign_getplaced(a:bufnr, { 'group': s:MarkSignGroupName })
  let sign_places = map(places[0].signs, 'printf("%2s  %4s  %s", v:val.id, v:val.lnum, getbufline(14, v:val.lnum)[0])')

  call append('$', sign_places)
  sort
  :g/^$/delete_

  call s:protect_buffer()
endfun


fun! s:mark_view_autocmd()

  augroup plugin_mark_sign
    autocmd! * <buffer>
    autocmd BufWriteCmd <buffer> nested call s:mark_view_apply()
    autocmd BufWipeout  <buffer> nested call s:mark_view_wipeout()
  augroup END

endfun


fun! s:mark_view_apply() abort
  " TODO: if needed, add it.
  setlocal nomodified
endfun


fun! s:mark_view_wipeout() abort
  " TODO: if needed, add it.
endfun


" vim: ft=vim fdm=marker
