" NAME:   zettelkasten open
" AUTHOR: marsh
"
" NOTE:
"
"
" * COMMAND
"   Zett [{opt}] {NOTE_TYPE} [{opt}]
"
" * NOTE_TYPE
"   - 0: Fleeting
"   - 1: Literature
"   - 2: Permanent
"   - 3: Index
"   - 4: Structure
"
" * OPTION
"   * LINK_TYPE
"     - 0: none
"     - 1: unidirection
"     - 2: bidirection
"
"   * REPLACE
"
"
"
"


let s:note_type     = [ "Fleeting", "Literature", "Permanent", "Index", "Structure" ]
let s:note_opt      = [ "++replace" ]
let s:note_opt_dir  = [ "++none", "++forward", "++backward", "++both" ]

let s:template_name = "zett"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" zettelkasten#open#start
" Zopen コマンドの関数
"
" Zopen [{opt}...] {notetype} [{opt}...]
"
" mods (tab | vertical | horizontal)
"
" # arg
"   - arglead
"   - cmdline
"   - cursorpos
"
" # return
"   - result
"
" note:
"   ノートがzettelkastenのディレクトリにすべて保存されることを想定して作られている。
" もし、パスが変わる可能性がある場合は修正を必要とする。
"
function! zettelkasten#open#start(mods, argstring)
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " setup parameter
  let args = split(a:argstring)
  let cmds = vim#command#utils#mod_split(a:mods)

  let [ has_replace, _ ] = s:judge_replace(args)
  let [ has_note_type, note_type ] = s:judge_note_type(args)
  let [ has_note_opt_dir, note_dir ] = s:judge_direction(args)
  let metainfo = markdown#meta_header#getmdheader(expand('%'))

  if !has_key(metainfo, 'title')
    let metainfo['title'] = expand('%:t:r')
  endif

  let l:backward    = expand('%:t')
  let l:title       = s:get_title(has_replace)
  let l:tags        = trim(input('tags> '),    " ")
  let l:date        = strftime(g:zettelkasten_date_format)

  let l:filename    = l:date . '.' . g:zettelkasten_ext
  let l:storepath   = vim#command#utils#trim_path(g:zettelkasten_dir) . vim#command#utils#get_shellslashchar()
  let l:filepath    = l:storepath . l:filename

  let template_dict = {
  \   'markdown': {
  \     'title': l:title,
  \     'tags': l:tags,
  \     'type': l:note_type,
  \   }
  \ }


  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " pre process
  if has_note_opt_dir && note_dir =~ '\(++both\|++forward\)'
    let linktext = printf("[%s](%s)", title, l:filename)
    exec printf("normal! o%s", linktext)
  endif


  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " main process
  " 
  exec l:cmds . l:filepath
  call vim#template#wrap(template_dict, s:template_name)


  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " post process
  if has_note_opt_dir && note_dir =~ '\(++both\|++backward\)'
    let linktext = printf("[%s](%s)", metainfo['title'], l:backward)
    exec printf("normal! o%s", linktext)
  endif
endfunction


" 
" zettelkasten#open#copmplete
" zettelkasten#open#start の補完関数
"
" # arg
"   - arglead   すでに入力されている補完対象の文字列
"   - cmdline   コマンドライン全体
"   - cursorpos カーソル位置
"
" # return
"   - result
function! zettelkasten#open#complete(arglead, cmdline, cursorpos)
  let result = []

  let arg_split = split(a:cmdline)
  let [ has_note_type, _ ] = s:judge_note_type(arg_split)
  let [ has_note_opt_dir, _ ] = s:judge_direction(arg_split)

  if ! has_note_type
    let result = result + s:note_type
  endif

  if ! has_note_opt_dir
    let result = result + s:note_opt_dir
  endif
  let result = result + s:filter_note_opt(arg_split)

  call filter(result, printf('matchstrpos(v:val, "%s")[1] == 0', a:arglead))
  return result
endfunction


"
" s:judge_replace(args)
" 引数に "++replace" が存在するか判定する関数
" 存在すれば、    [ v:true,  "++replace" ] を返し、
" 存在しなければ、[ v:false, ""          ] を返す。
" 
function! s:judge_replace(args)
  let has = v:false
  let res = ""

  for arg in a:args
    if arg == "++replace"
      let has = v:true
      let res = "++replace"
      break
    endif
  endfor

  return [ has, res ]
endfunction


"
" s:judge_notetype(args)
" 引数に s:note_type に書かれたノートタイプが存在するか判定する。
" 存在すれば、    [ v:true, {note_type} ] を返し、
" 存在しなければ、[ v:false, ""         ] を返す。
" 
function! s:judge_note_type(args)
  let has = v:false
  let res = ""

  for arg in a:args
    for type in s:note_type
      if arg == type
          let has = v:true
          let res = type
          break
      endif
    endfor

    if has
      break
    endif
  endfor

  return [ has, res ]
endfunction


"
" s:judge_direction(args)
" 引数に s:note_opt_dir に書かれたリンク方向が存在するか判定する。
" 存在すれば、    [ v:true, {dir} ] を返し、
" 存在しなければ、[ v:false, ""         ] を返す。
" 
function! s:judge_direction(args)
  let has = v:false
  let res = ""

  for arg in a:args
    for opt in s:note_opt_dir
      if arg == opt
          let has = v:true
          let res = opt
          break
      endif
    endfor

    if has
      break
    endif
  endfor

  return [ has, res ]
endfunction


"
" s:judge_direction(args)
" 引数の args に存在しない s:note_opt の要素を返す。 
" args のリストにない s:note_opt の要素が存在すれば、    [ {opts}... ] を返し、
" args のリストにない s:note_opt の要素が存在しなければ、[ ] を返す。
" 
function! s:filter_note_opt(args)
  let result = []

  for opt in s:note_opt
    let has = v:false
    for arg in a:args
      if arg == opt
          let has = v:true
          break
      endif
    endfor

    if ! has
      call add(result, opt)
    endif
  endfor

  return result
endfunction


"
" get_title(is_replace)
"
function! s:get_title(is_replace)
  if a:is_replace
    let titles = vim#visual#utils#getregiontext()
    let title = join(titles, "")
  else
    let title = trim(input('title> '), " ")

  endif
  return title
endfunction

