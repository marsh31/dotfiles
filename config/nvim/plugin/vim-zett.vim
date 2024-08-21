
let g:zettelkasten_date_format   = "%Y%m%d%H%M%S"
let g:zettelkasten_dir           = expand('~/til/learn/memo')
let g:zettelkasten_ext           = 'md'
let g:zettelkasten_template      = 'Template zett'

let g:zettelkasten_link          = ''

let s:zettelkasten_fleeting      = { "type": "Fleeting",   "path": g:zettelkasten_dir . "/fleeting"   }
let s:zettelkasten_literature    = { "type": "Literature", "path": g:zettelkasten_dir . "/literature" }
let s:zettelkasten_permanent     = { "type": "Permanent",  "path": g:zettelkasten_dir                 }
let s:zettelkasten_index         = { "type": "Index",      "path": g:zettelkasten_dir                 }
let s:zettelkasten_structure     = { "type": "Structure",  "path": g:zettelkasten_dir                 }

command! -nargs=* Zett        call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_fleeting)
command! -nargs=* Zfleeting   call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_fleeting)
command! -nargs=* Zliterature call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_literature)
command! -nargs=* Zpermanent  call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_permanent)
command! -nargs=* Zindex      call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_index)
command! -nargs=* Zstructure  call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_structure)

command! ZJumpPrev call s:zettelkasten_jump_prev()
command! ZJumpNext call s:zettelkasten_jump_next()

command! ZCopyLink  call s:zettelkasten_copy_link()
command! ZPasteLink call s:zettelkasten_paste_link()

command! Ztest      call s:auto_inputlink()


" IF =======================================================
function! s:zettelkasten_open(mods, str, config) abort
  let l:cmd = s:edit_cmd(a:mods)
  let l:title = trim(input('title> '), " ")
  let l:tags= trim(input('tags> '), " ")
  let l:date = strftime(g:zettelkasten_date_format)
  let l:filename = l:date . '.' . g:zettelkasten_ext

  let l:isOk = s:yninput("Do you want to input link?(Yy/other): ")
  let l:linktext = printf("[%s](%s)", title, l:filename)
  if l:isOk
    call append(line('.'), l:linktext)
  endif

  exec l:cmd . trim(a:config.path, '/', 2) . '/' . l:filename
  if g:zettelkasten_template != ''
    call s:zettelkasten_template_do(l:title, l:tags, a:config.type)
  endif
endfunction


function! s:zettelkasten_jump_prev() abort
  let l:splitted = s:get_current_dir_filelist()
  let l:index = match(l:splitted, expand('%:p'))

  let l:index = l:index - 1

  let l:open_cmd = "edit " . l:splitted[l:index]
  exec l:open_cmd
endfunction


function! s:zettelkasten_jump_next() abort
  let l:splitted = s:get_current_dir_filelist()
  let l:index = match(l:splitted, expand('%:p'))

  let l:index = l:index + 1
  if len(splitted) <= l:index
    let l:index = l:index - len(splitted)
  endif

  let l:open_cmd = "edit " . l:splitted[l:index]
  exec l:open_cmd
endfunction

function! s:zettelkasten_copy_link() abort
  let g:zettelkasten_link = expand('%:p')
endfunction


" shellslash on
function! s:zettelkasten_paste_link() abort
  let l:link = substitute(g:zettelkasten_link, expand('%:p:h') . '/', '', 'g')

  let l:linktext = trim(input('link> '), " ")
  let l:pastetext = printf("[%s](%s)", linktext, link)

  let @" = l:pastetext
  let @+ = l:pastetext
  let @* = l:pastetext
endfunction


function! s:auto_inputlink() abort
  let l:linktext = "test"
  let l:cbufnr = bufnr()
  let l:cline = line('.') - 1

  let l:cdir = expand('%:p:h')
  if l:cdir == g:zettelkasten_dir

  endif

  let l:isOk = s:yninput("Do you want to input link?(Yy/other): ")
  if l:isOk
    call appendbufline(l:cbufnr, l:cline, l:linktext)
  endif
endfunction

" API ======================================================

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" zettelkasten_template_do
" 
" args
"   title: string
"   tags: string
"   type: string : Fleeting | Literature | Permanent | Index | Structure
"
" return
"
"   args を参照して、Templateコマンドを実行して、Templateを展開する。
"
function! s:zettelkasten_template_do(title, tags, type) abort
  let l:tmp = get(g:, "sonictemplate_vim_vars", {})
  let g:sonictemplate_vim_vars = {
  \   'markdown': {
  \     'title': a:title,
  \     'tags': a:tags,
  \     'type': a:type,
  \   }
  \ }
  exec g:zettelkasten_template
  let g:sonictemplate_vim_vars = l:tmp
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" edit_cmd
" 
" args
"   mods: string
"
" return
"   cmd: string
"
"   <q-mods> の値を渡して、editコマンドを返す。
"   有効な<q-mods:horizontal,vertical,tab>の場合、
" <q-mods:horizontal,vertical,tab> split を返す。
"   無効な<q-mods>の場合、edit を返す。
"
function! s:edit_cmd(mods) abort
  if a:mods =~ '\(horizontal\|vertical\|tab\)'
    let cmd = a:mods .. ' split '
  else
    let cmd = "edit "
  endif
  return cmd
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" 
" 
" 
" 
" 
" 
" 
" 
" 
" 
" 
" 
function! s:get_current_dir_filelist() abort
  let l:dir = expand('%:p:h')
  let l:filelist = glob(l:dir . '/*')
  let l:splitted = split(filelist, '\n')
  return l:splitted
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" 
" 
" 
" 
" 
" 
" 
" 
" 
" 
" 
" 
function! s:yninput(title) abort
  echon a:title
  
  let l:result = v:false
  let l:inputchar = nr2char(getchar())
  if l:inputchar =~ '[yY]'
    let l:result = v:true
  endif

  return l:result
endfunction
