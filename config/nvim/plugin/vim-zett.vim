" Global config ============================================
let g:zettelkasten_shellslashchar = '/'

let g:zettelkasten_date_format    = "%Y%m%d%H%M%S"
let g:zettelkasten_dir            = expand('~/til/learn/memo')
let g:zettelkasten_ext            = 'md'
let g:zettelkasten_template       = 'Template zett'
let g:zettelkasten_store_dir      = g:zettelkasten_dir . '/appendix'

let g:zettelkasten_link           = ''


" Local config =============================================
let s:zettelkasten_fleeting       = { "type": "Fleeting",   "path": g:zettelkasten_dir }
let s:zettelkasten_literature     = { "type": "Literature", "path": g:zettelkasten_dir }
let s:zettelkasten_permanent      = { "type": "Permanent",  "path": g:zettelkasten_dir }
let s:zettelkasten_index          = { "type": "Index",      "path": g:zettelkasten_dir }
let s:zettelkasten_structure      = { "type": "Structure",  "path": g:zettelkasten_dir }

let s:zettelkasten_header_s       = 1
let s:zettelkasten_header_e       = 9


" Command ==================================================
command! -nargs=* Zett            call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_fleeting)
command! -nargs=* Zfleeting       call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_fleeting)
command! -nargs=* Zliterature     call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_literature)
command! -nargs=* Zpermanent      call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_permanent)
command! -nargs=* Zindex          call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_index)
command! -nargs=* Zstructure      call s:zettelkasten_open(<q-mods>, <q-args>, s:zettelkasten_structure)

command! ZJumpPrev                call s:zettelkasten_jump_prev()
command! ZJumpNext                call s:zettelkasten_jump_next()

command! ZCopyLink                call s:zettelkasten_copy_link()
command! ZPasteLink               call s:zettelkasten_paste_link()

command! ZMetaStatics             call s:zettelkasten_meta_statics()

command! ZMakeStoreDir            call s:zettelkasten_store_dir()
command! ZRegStoreDir             call s:zettelkasten_store_dir_to_register()

command! ZSearchLink              /\[.\+\](\zs.\+\ze)


command! Ztest                    call s:auto_inputlink()


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
    exec printf("normal! O%s", l:linktext)
  endif

  exec l:cmd . trim_path(a:config.path) . g:shellslash . l:filename
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


function! s:zettelkasten_meta_statics() abort
  let l:splitted = s:get_current_dir_filelist()
  let l:metainfo = []

  for l:file in l:splitted
    call add(l:metainfo, s:getmdheader(l:file))
  endfor

  let l:sum_of_fleeting = filter(deepcopy(l:metainfo), 'v:val["type"] == "Fleeting"')
  echo len(l:sum_of_fleeting)
  "
  let l:sum_of_literature = filter(deepcopy(l:metainfo), 'v:val["type"] == "Literature"')
  echo len(l:sum_of_literature)
  echo l:metainfo
endfunction


function! s:zettelkasten_store_dir() abort
  let l:fullpath = s:get_store_dir_fullpath()
  mkdir(l:fullpath)
endfunction


function! s:zettelkasten_store_dir_to_register() abort
  let l:fullpath = s:get_store_dir_fullpath()
  let @" = l:fullpath
  let @+ = l:fullpath
  let @* = l:fullpath
endfunction


function! s:auto_inputlink() abort
  call s:getmdheader("/home/marsh/til/learn/memo/fleeting/20240820211328.md")
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
" get_current_dir_filelist
" 
" args
"   none
" 
" return
"   splitted [string] カレントファイルの存在するディレクトリに存在するファイルの一覧
" 
"   現在のバッファの親ディレクトリに存在するファイルの一覧を配列形式で返す。
" 
function! s:get_current_dir_filelist() abort
  let l:dir = expand('%:p:h')
  let l:filelist = glob(l:dir . '/*')
  let l:splitted = split(filelist, '\n')
  return l:splitted
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yninput
" 
" args
"   title string コンソールログのヘッダ
" 
" return
"   result boolean Y = true, other = false
" 
"   yY or other の入力を要求する。
" yY のときはTrue。
" other のときはFlase。
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" getmdheader
" 
" args
"   file string file path
" 
" return
"   result dict メタデータの辞書型データを返す。
" 
"   ファイル名を受け取ると、ファイルのヘッダーを読み取り、
" メタデータがあればメタデータを返す。メタデータがなければ、
" 空辞書を返す。ヘッダーの有無は先頭行に---があればヘッダーあり。
" なければ、ヘッダーなしと判定する。
function! s:getmdheader(file) abort
  let l:lines = readfile(a:file, '', 10)
  let l:result = {}

  if l:lines[0] !~ '^-\+$'
    return l:result
  endif

  for l:line in l:lines[1:]
    if l:line =~ '^-\+$'
      break
    endif

    let l:mlist = matchlist(l:line, '\(.\+\):\s\+\(.\+\)')
    if !empty(l:mlist)
      let l:key = l:mlist[1]
      let l:val = l:mlist[2]

      let l:result[l:key] = s:get_list(l:val)
    endif
  endfor

  return l:result
endfunction


function! s:get_list(valstr) abort
  let l:mlist = matchlist(a:valstr, '\[\(.\+\)\]')
  let l:start = 0
  if !empty(l:mlist)
    let l:result = []

    let l:mres = matchstrpos(l:mlist[1], '\s*\zs\([^,]\+\)\ze,\?', l:start)
    while l:mres[2] != -1
      call add(l:result, l:mres[0])
      let l:mres = matchstrpos(l:mlist[1], '\s*\zs\([^,]\+\)\ze,\?', l:mres[2])
    endwhile

    return l:result
  elseif !empty(matchlist(a:valstr, '\[\s\+\]'))

    return []
  else

    return a:valstr
  endif
endfunction


function! s:get_store_dir_fullpath() abort
  let l:dir_name = expand("%:t:r")
  return g:zettelkasten_store_dir . g:zettelkasten_shellslashchar . l:dir_name
endfunction


function! s:trim_path(path) abort
  if a:path[-1:-1] == g:zettelkasten_shellslashchar
    return a:path[0:-2]
  endif
  return a:path
endfunction
