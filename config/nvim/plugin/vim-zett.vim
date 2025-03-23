" NAME:   vim-zett
" AUTHOR: marsh
" NOTE: 
" '<,'>g/$/let @+ = ' | '.  markdown#meta_header#getmdheader(expand($'~/til/learn/memo/{getline('.')}'), 15).title | normal! $p
" '<,'>normal! A |
" 
" 20240822072358.md
" 
" Global config ============================================
let g:zettelkasten_shellslashchar = '/'

let g:zettelkasten_date_format    = "%Y%m%d%H%M%S"
let g:zettelkasten_dir            = expand('~/til/learn/memo')
let g:zettelkasten_ext            = 'md'
let g:zettelkasten_template       = 'Template zett'
let g:zettelkasten_notee          = 'zett'
let g:zettelkasten_store_dir      = g:zettelkasten_dir . '/appendix'

let g:zettelkasten_link           = ''


" Local config =============================================
let s:zettelkasten_header_s       = 1
let s:zettelkasten_header_e       = 9


" Command ==================================================
command! -range -nargs=* -complete=customlist,zettelkasten#open#complete   Zopen  call zettelkasten#open#start(<q-mods>, <q-args>)
command!        -nargs=* -complete=customlist,s:zettelkasten_edit_complete Zedit  call s:zettelkasten_edit(<q-args>)
command!        -nargs=0                                                   Zday   call s:zettelkasten_day_note()

command! ZJumpPrev                      call s:zettelkasten_jump_prev()
command! ZJumpNext                      call s:zettelkasten_jump_next()

command! ZCopyMetaLink                  call s:zettelkasten_copy_meta_link()
command! ZCopyLink                      call s:zettelkasten_copy_link()
command! ZPasteLink                     call s:zettelkasten_paste_link()

command! ZMetaStatics                   call s:zettelkasten_meta_statics()

command! ZMakeStoreDir                  call s:zettelkasten_store_dir()
command! ZRegStoreDir                   call s:zettelkasten_store_dir_to_register()

command! ZSearchLink                    call markdown#jump_link#search()
command! ZSearchLinkJumpNext            call markdown#jump_link#jump_next()
command! ZSearchLinkJumpPrev            call markdown#jump_link#jump_prev()

command! ZUpdateTitle                   call s:zettelkasten_update_title()
command! ZUpdateDate                    call s:zettelkasten_update_date()
command! -nargs=*       ZUpdateTags     call s:zettelkasten_update_tags(<q-args>)

command! -range Ztest                   call ZetteTest(<range>)


xnoremap <buffer><expr> <Leader>zt      ZetteTest(mode())
onoremap <buffer><expr> <Leader>zt      ZetteTest(mode())

nmap <Plug>(markdown-jump-link-search)  :<C-u>ZSearchLink<CR>
nmap <Plug>(markdown-jump-link-next)    :<C-u>ZSearchLinkJumpNext<CR>
nmap <Plug>(markdown-jump-link-prev)    :<C-u>ZSearchLinkJumpPrev<CR>


" IF =======================================================
" virtualedit
" selection
function! ZetteTest(mode) range
  echomsg a:firstline
  echomsg a:lastline
  
  echomsg a:mode
  echomsg mode()

  normal! 

  let [_, flnr, fcol, _] = getpos("'<")
  let [_, elnr, ecol, _] = getpos("'>")
  if a:firstline == flnr && a:lastline == elnr
    echomsg "V"
  endif
  return "\<Ignore>"
endfunction



"

function! s:zettelkasten_edit(filename) abort
  let l:target_file = ""
  for l:file in s:get_zettelkasten_dir_files()
    let l:meta = s:getmdheader(l:file)
    if has_key(l:meta, 'title') && has_key(l:meta, 'uid')
      let l:id = l:meta["title"] .. '@' .. l:meta["uid"]

    else
      let l:id = fnamemodify(l:file, ":t:r")

    endif

    if trim(l:id) == trim(a:filename)
      let l:target_file = l:file
    endif
  endfor

  exec printf("%s %s", 'edit', l:target_file)
endfunction



function! s:zettelkasten_edit_complete(arglead, cmdline, cursorpos)
  let l:result = []
  let l:meta = {}
  for l:file in s:get_zettelkasten_dir_files()
    let l:meta = s:getmdheader(l:file)
    if has_key(l:meta, 'title') && has_key(l:meta, 'uid')
      let l:result = l:result + [ l:meta["title"] .. '@' .. l:meta["uid"] ]
    else
      let l:result = l:result + [ fnamemodify(l:file, ":t:r") ]
    endif
  endfor

  call filter(l:result, printf('matchstrpos(v:val, "%s")[1] == 0', a:arglead))
  return l:result
endfunction


function! s:zettelkasten_day_note()
  let todaynote = strftime('%Y%m%d') . '000000' . '.md'
  let file = expand(g:zettelkasten_dir) . '/' . todaynote

  exec printf("edit %s", file)
  if !(!empty(glob(file)) && filereadable(file))
    call s:zettelkasten_template_do(strftime("%Y-%m-%d ノート"), "daily", "Fleeting")
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

function! s:zettelkasten_copy_meta_link() abort
  let path = expand('%:p')
  let meta = s:getmdheader(path)

  let result = '[' .. meta['title'] .. '](' .. expand('%:p:h') .. ')'
  let @" = result
  let @+ = result
  let @* = result
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
  call mkdir(l:fullpath)
endfunction


function! s:zettelkasten_store_dir_to_register() abort
  let l:fullpath = s:get_store_dir_fullpath()
  let @" = l:fullpath
  let @+ = l:fullpath
  let @* = l:fullpath
endfunction


function! s:zettelkasten_update_title() abort
  let l:title = s:get_first_h1()
  exec printf("%s,%ss/%s/%s", s:zettelkasten_header_s, s:zettelkasten_header_e, s:get_regex_update_title(), s:get_update_title(l:title))
endfunction

function! s:zettelkasten_update_date() abort
  exec printf("%s,%ss/%s/%s", s:zettelkasten_header_s, s:zettelkasten_header_e, s:get_regex_update_date(), s:get_update_date())
endfunction

"
" s:zettelkasten_update_tags
" {{{

fun! s:zettelkasten_update_tags(tags) abort
  let l:add_tags = trim(a:tags, ' ')
  if empty(l:add_tags)
    let l:add_tags = trim(input('tags> '), ' ')
  endif
  exec $'1,9s/tags: \[\([^]]\+\)\]/tags: [\1, {l:add_tags}]'
endfun

" }}}


function! s:auto_inputlink() abort
  call s:getmdheader("/home/marsh/til/learn/memo/fleeting/20240820211328.md")
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" get_zettelkasten_dir_files
" 
" args
"   none
" 
" return
"   splitted [string] カレントファイルの存在するディレクトリに存在するファイルの一覧
" 
"   現在のバッファの親ディレクトリに存在するファイルの一覧を配列形式で返す。
" 
function! s:get_zettelkasten_dir_files() abort
  let l:dir = g:zettelkasten_dir
  let l:filelist = glob(l:dir . '/*')
  let l:splitted = split(filelist, '\n')
  call filter(splitted, '!isdirectory(v:val)')
  return l:splitted
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

  if empty(l:lines) || l:lines[0] !~ '^-\+$'
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


function! s:get_update_title(title) abort
  return 'title: ' . a:title
endfunction


function! s:get_regex_update_title() abort
  return 'title: .\+'
endfunction


function! s:get_update_date() abort
  return 'update: ' . strftime('%Y-%m-%d %H:%M:%S')
endfunction


function! s:get_regex_update_date() abort
  return 'update: \d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}'
endfunction


function! s:get_first_h1() abort
  let l:curpos = getcurpos()
  call cursor(1, 1)
  call search('^# \+.\+$')
  let l:res = matchstrpos(getline("."), '^# \+\zs.\+\ze$')
  call cursor([l:curpos[1], l:curpos[2], l:curpos[3], l:curpos[4]])
  
  return l:res[0]
endfunction


function! s:get_region() abort
  " normal! gv
  echo mode()
  if mode() =~ '[vV]s\?'
    let [_, flnr, fcol, _] = getpos("'<")
    let [_, elnr, ecol, _] = getpos("'>")

    return [ [ flnr, fcol ], [ elnr, ecol ] ]
  else
    return []
  endif
endfunction
