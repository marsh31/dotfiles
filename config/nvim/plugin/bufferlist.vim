" NAME:   bufferlist
" AUTHOR: marsh
"
" NOTE:
" {
"   "" = {
"     init, 
"     update,
"     action = {
"       "<CR>" = xx,
"       "x"    = xx,
"     },
"   },
"   "til" = {
"     init, 
"     update,
"     action = {
"       "<CR>" = xx,
"       "x"    = xx,
"     },
"   },
" }
"


let s:BufferListConfig = {
      \ "name"   : "bl://",
      \ "ft"     : "bl",
      \ "bufnr"  : 0,
      \ "bufinfo": [],
      \ "format" : ['bufnr', 'filename'],
      \ "log"    : v:null
      \ }


let s:BufferListConfigTIL = {
      \ "dir"    : expand('~/til/learn/memo/'),
      \ }


" IF {{{

" BufferListOpen {{{


fun! BufferListOpen() abort
  call s:BufferListConfig.Open()
endfun


" }}}
" BufferListUpdate() {{{

fun! BufferListUpdate() abort
  call s:BufferListConfig.Update()
endfun

" }}}
" BufferListConfigPrint {{{

fun! BufferListConfigPrint() abort
  echomsg s:BufferListConfig
  echomsg s:BufferListConfigTIL
  call s:BufferListConfigTIL.Update()
endfun

" }}}


" }}}


" BufferListConfig {{{
"
" s:BufferListConfig.Open {{{

fun! s:BufferListConfig.Open() 
  let self.log = LogConfig("bl")
  call self.log.info("OK", "Open BufferList")

  let buffer_open_cmd = s:open_buffer_cmd(self.name)
  call self.log.info("OK", buffer_open_cmd)

  noautocmd hide execute buffer_open_cmd
  execute  "setlocal ft=" .. self.ft
  setlocal buftype=acwrite bufhidden=wipe noswapfile
  setlocal nonumber norelativenumber
  setlocal conceallevel=3 concealcursor=nvic

  augroup bufferlist_update
    autocmd! * <buffer>
    autocmd Bufnew * echomsg s:BufferListConfig.Update()
  augroup END

  let self.bufnr = bufnr()
  call self.Init()
  call self.Update()
endfun

" }}}
" s:BufferListConfig.Init {{{

fun! s:BufferListConfig.Init() abort
  call self.log.info("OK", "Init BufferList")

  command! -buffer -nargs=0         EnterBuffer    :call s:enter_buffer()

  nmap <buffer><silent> q    :q!<CR>
  nmap <buffer><silent> <CR> :<C-u>EnterBuffer<CR>
endfun

" }}}
" s:BufferListConfig.Update {{{

fun! s:BufferListConfig.Update() abort
  call self.log.info("OK", "Update BufferList")

  call self.log.debug("OK", printf("update buffer is %s", self.bufnr))

  call s:unprotect_buffer(self.bufnr)

  call deletebufline(self.bufnr, 1, '$')
  call s:get_bufferlist(self.name)->setbufline(self.bufnr, 1)

  call s:protect_buffer(self.bufnr)
endfun

" }}}


" }}}
" BufferListConfigTIL {{{

" s:BufferListConfigTIL.Update {{{

fun! s:BufferListConfigTIL.Update() abort
  let buffer_name = 'bl://'
  let til = '/home/marsh/til/learn/memo/'

  " let buffers = map(filter(copy(getbufinfo()), 'v:val.listed && bufname(v:val.bufnr) != buffer_name'), 
  "       \ '{ "bufnr": v:val.bufnr, "name": v:val.name }')
  "
  let buffers = map(filter(copy(getbufinfo()), 'v:val.listed && bufname(v:val.bufnr) != buffer_name'),
        \ '{ "bufnr": v:val.bufnr, "name": v:val.name }')
  let til_buffers = filter(buffers, $'v:val.name =~# "^\\V{til}"')

  echomsg til_buffers
endfun

" }}}


" }}}

" 
" s:protect_buffer
" s:unprotect_buffer
" s:open_buffer_cmd
" s:get_bufferlist
" s:get_bufferline
" s:get_bufferformat
" script local {{{

" s:protect_buffer {{{

function! s:protect_buffer(bufnr)
  call setbufvar(a:bufnr, "&modified", 0)
  call setbufvar(a:bufnr, "&modifiable", 0)
  call setbufvar(a:bufnr, "&readonly", 1)
endfunction

" }}}
" s:unprotect_buffer {{{

function! s:unprotect_buffer(bufnr)
  call setbufvar(a:bufnr, "&modified", 0)
  call setbufvar(a:bufnr, "&modifiable", 1)
  call setbufvar(a:bufnr, "&readonly", 0)
endfunction

" }}}
" s:open_buffer_cmd {{{

fun! s:open_buffer_cmd(name, direction = 'rightbelow', size = '10', opener = 'split') abort
  let cmd = printf("%s %s%s %s", a:direction, a:size, a:opener, a:name)
  call s:BufferListConfig.log.debug("OK", cmd)
  return cmd
endfun

" }}}
" s:get_bufferlist {{{

fun! s:get_bufferlist(buffer_name) abort
  let buffers = map(filter(copy(getbufinfo()), 'v:val.listed && bufname(v:val.bufnr) != a:buffer_name'),
        \ 's:get_bufferline(v:val)')
  return buffers
endfun

" }}}
" s:get_bufferline {{{

fun! s:get_bufferline(val) abort
  let format = s:get_bufferformat()
  let line = printf(format, a:val.bufnr, a:val.name == "" ? "[No Name]" : a:val.name)
  return line
endfun

" }}}
" s:get_bufferformat {{{

fun! s:get_bufferformat() abort
  " TODO: bufnr の桁数によって計算を変える。
  " let bufnrend = bufnr('$')
  " let cnt = 0
  " while bufnrend > 0
  "   let cnt = cnt + 1
  "   let bufnrend = bufnrend % 10
  " endwhile

  let format = "%4s %s"
  return format
endfun

" }}}
" s:enter_buffer {{{

fun! s:enter_buffer() abort
  let line = matchlist(getline('.'), '\(\d\+\)\s\+\(.\+\)')

  call s:BufferListConfig.log.debug("OK", 'cmd len > ' .. len(line))
  if !empty(line)
    quit
    execute 'vs | b ' . line[1]
    call s:BufferListConfig.log.debug("OK", 'cmd > ' .. 'vs | b ' .. line[1])
  endif
endfun

" }}}


" }}}

" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
