
let s:subs = {
      \ "work_directory": function("vim#yank#cwd"),
      \ "full_name": function("vim#yank#fullname"),
      \ "file_name": function("vim#yank#filename"),
      \ "base_name": function("vim#yank#basename"),
      \ "parent": function("vim#yank#parent"),
      \ "bufnr": function("vim#yank#bufnr"),
      \ "ext": function("vim#yank#ext"),
      \ }

fun! vim#yank#main(sub) abort
  let sub_cmd = trim(a:sub)
  let result = s:subs[sub_cmd]()

  let @* = result
  let @+ = result
endfun


fun! vim#yank#complete(arglead, cmdline, cursorpos) abort
  let keys = keys(s:subs)
  call filter(keys, printf('matchstrpos(v:val, "%s")[1] == 0', a:arglead))
  return keys
endfun


fun! vim#yank#cwd() abort
  return getcwd()
endfun


fun! vim#yank#parent() abort
  return expand('%:p:h')
endfun


fun! vim#yank#basename() abort
  return expand('%:t:r')
endfun


fun! vim#yank#fullname() abort
  return expand('%:p')
endfun


fun! vim#yank#filename() abort
  return expand('%:p:t')
endfun


fun! vim#yank#ext() abort
  return expand('%:e')
endfun


fun! vim#yank#bufnr() abort
  return bufnr()
endfun


command!  -nargs=*  -complete=customlist,vim#yank#complete  YankCurr  call vim#yank#main(<q-args>)
