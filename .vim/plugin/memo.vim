" NAME:   plugin/memo.vim
" AUTHOR: marsh
" NOTE:
"
" メモノートを作るためのプラグイン。
" 保存先は、優先度に従い決定される。
" 指定がない場合はエラーとする。


let s:memo_directory = ''
if exists('$MEMOS') && isdirectory($MEMOS)
  let s:memo_directory = $MEMOS
endif


fun! GetMemoDirectory()
  return s:memo_directory
endfun


fun! s:init_path()
  let &path = &path .. "," .. s:memo_directory
endfun



" options : dict:   オプション
" "options" = {
"   "type"     : [A-Z0-9][A-Z] : ZZ tmp note
"   "opener"   : "edit" | "sp" | "vs" | "tab sp"
"   "template" : 
" }
"
fun! s:new_memo(options) abort
  let l:opt_opener = get(a:options, 'opener', 'sp')
  if l:opt_opener !~# 'e\%[dit]\|sp\%[lit]\|vs\%[plit]\|tab sp\%[lit]'
    let l:opt_opener = 'sp'
  endif

  let l:opt_type   = get(a:options, 'type', 'ZZ')
  if l:opt_type !~# '[A-Z0-9][A-Z]'
    let l:opt_type = 'ZZ'
  endif

  let l:opt_temp   = get(a:options, 'template', '')


  " exec
  let l:filename = l:opt_type .. strftime("%Y%m%d%H%M%S") .. ".md"
  let l:link     = '[](' .. l:filename .. ')  '
  put =l:link

  let l:filepath = vim#path#join([s:memo_directory, l:filename])
  exec l:opt_opener .. ' ' .. l:filepath

  if exists(':Template') && l:opt_temp !=# ''
    exec 'Template ' .. l:opt_temp
  endif
endfun


call s:init_path()
command!  AtomicNote  call <sid>new_memo({ 'type': '0A', 'opener': 'tab sp', 'template': '0A-atomic' })
command!  BoringNote  call <sid>new_memo({ 'type': '0B', 'opener': 'tab sp', 'template': '0A-atomic' })

command!  DebateNote  call <sid>new_memo({ 'type': '0D', 'opener': 'tab sp', 'template': '0A-atomic' })

command!  TempNote    call <sid>new_memo({ 'type': 'ZZ', 'opener': 'tab sp', 'template': '0A-atomic' })



" END: {{{1
" vim: set ft=vim expandtab tabstop=2 :
