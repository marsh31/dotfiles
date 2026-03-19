" abbrev_cmd.vim - Command-line abbreviations (Vim 8.2+)
"
" Features:
"   - cnoremap <expr> installed once per last-key
"   - multi-byte safe LHS handling
"   - list / del / clear
"   - :AbbrevCmd[!] {lhs} {rhs...}
"       no-bang: rhs treated as literal string inserted after <C-U>
"       bang:    rhs treated as Vim expression returning keys/string
"
" Notes:
"   - LHS may start with a cmdtype char: ':', '/', '?', '@', '='
"     If omitted, ':' is assumed.
"   - Matching key is (cmdtype .. current_cmdline_before_last_key).
"     Example: :W  => mapping on 'W' looks up key ':' (cmdline is empty)
"
" Status:
"   develop
"
" 

" 期待通り動作しないため、停止
let g:loaded_abbrev_cmd = 1
if exists('g:loaded_abbrev_cmd')
  finish
endif
let g:loaded_abbrev_cmd = 1

let s:cmds = {}        " s:cmds[lastkey][key] = {'raw':0/1, 'rhs':string}
let s:installed = {}   " s:installed[lastkey] = 1

" --- Utilities -------------------------------------------------------------

" @param
"   - msg string
"
" @return
"   - 0
"
" 失敗出力をする。
"
fun! s:fail(msg) abort
  echohl ErrorMsg
  echomsg '[AbbrevCmd] ' .. a:msg
  echohl None
  return 0
endfun


" @param
"   - cmd_lhs string
"
" @return
"   - list [ <ctype>, <pre>, <last> ]
"
" 左辺式を評価して異常データかチェック。
" 異常であれば、<pre>, <last>は空文字。
" 正常であれば、<last>はコマンドの最後の文字。
" <pre>は<last>を除く文字が入る。
"
fun! s:split_lhs(cmd_lhs) abort
  if type(a:cmd_lhs) != v:t_string || a:cmd_lhs ==# ''
    return ['', '', '']
  endif

  let l:s = a:cmd_lhs

  let l:first = strcharpart(l:s, 0, 1)
  if l:first =~# '[:/?@=]'
    let l:ctype = l:first
    let l:rest  = strcharpart(l:s, 1)
  else
    let l:ctype = ':'
    let l:rest  = l:s
  endif

  " e.g. ":" only -> invalid
  if l:rest ==# ''
    return [l:ctype, '', '']
  endif

  let l:n = strchars(l:rest)
  if l:n <= 0
    return [l:ctype, '', '']
  endif

  let l:last = strcharpart(l:rest, l:n - 1, 1)
  let l:pre  = (l:n > 1) ? strcharpart(l:rest, 0, l:n - 1) : ''

  return [l:ctype, l:pre, l:last]
endfun

" @param
"   - lastkey string(char)
"
" @return
"   - None
"
" lastkeyをcnoremapでマッピングしたか。
" していなければマッピングをして、フラグをオンする。
fun! s:install_if_needed(lastkey) abort
  if get(s:installed, a:lastkey, 0)
    return
  endif
  " Use <SID> to call script-local dispatcher.
  execute printf("cnoremap <expr> %s <SID>dispatch('%s')", a:lastkey, a:lastkey)
  let s:installed[a:lastkey] = 1
endfun


" @param
"   - lastkey list[string]
"
" @return
"   - string
"
" 文字列型のリストを結合する。
" このとき、先頭に<C-u>を入れて、すでに入っている
" 文字列を削除する。
fun! s:mk_rhs_literal(rhs_parts) abort
  " literal insertion after clearing cmdline
  " rhs_parts is List of strings; join with spaces (like Ex command text)
  return "\<C-U>" .. join(a:rhs_parts, ' ')
endfun



" @param
"   - lastkey list[string]
"
" @return
"   - string
"
" 文字列型のリストを結合する。
fun! s:mk_rhs_raw(expr_parts) abort
  " return '<c-u>' .. join(a:expr_parts, ' ')
  return "'\<C-U>" .. substitute(join(a:expr_parts, ' '), "'", "''", 'g') .. "'"
endfun

" --- Core ------------------------------------------------------------------

fun! s:dispatch(lastkey) abort
  " Lookup key is (cmdtype .. cmdline_before_lastkey)
  let l:key = getcmdtype() .. getcmdline()

  let l:bucket = get(s:cmds, a:lastkey, {})
  let l:ent = get(l:bucket, l:key, v:null)

  if type(l:ent) == v:t_dict
    if get(l:ent, 'raw', 0)
      echomsg "l:ent.rhs: [" . string(l:ent.rhs) . "]"
      " raw rhs is an expression that returns a string/keys
      try
        let l:out = eval(l:ent.rhs)
        echomsg "eval(l:ent.rhs): [" . string(l:out) . "]"
        return (type(l:out) == v:t_string) ? l:out : a:lastkey
      catch
"         " Fail safe: do not break command-line usage.
        return a:lastkey
      endtry
    else
      return l:ent.rhs
    endif
  endif

  return a:lastkey
endfun

fun! s:add(raw_rhs, cmd_lhs, ...) abort
  let l:rhs = a:000
  let [l:ctype, l:pre, l:last] = s:split_lhs(a:cmd_lhs)
  if l:last ==# ''
    return s:fail('Invalid LHS: ' .. string(a:cmd_lhs))
  endif

  call s:install_if_needed(l:last)
  if !has_key(s:cmds, l:last)
    let s:cmds[l:last] = {}
  endif

  let l:key = l:ctype .. l:pre

  if a:raw_rhs
    if empty(l:rhs)
      return s:fail('Raw RHS requires an expression.')
    endif
    let s:cmds[l:last][l:key] = {'raw': 1, 'rhs': s:mk_rhs_raw(l:rhs)}
  else
    if empty(l:rhs)
      return s:fail('RHS is empty.')
    endif
    let s:cmds[l:last][l:key] = {'raw': 0, 'rhs': s:mk_rhs_literal(l:rhs)}
  endif

  return 1
endfun

fun! s:del(cmd_lhs) abort
  let [l:ctype, l:pre, l:last] = s:split_lhs(a:cmd_lhs)
  if l:last ==# ''
    return s:fail('Invalid LHS: ' .. string(a:cmd_lhs))
  endif

  let l:key = l:ctype .. l:pre
  if has_key(s:cmds, l:last) && has_key(s:cmds[l:last], l:key)
    call remove(s:cmds[l:last], l:key)
    " keep mapping installed; removing map is optional and can be complex/unsafe
    return 1
  endif
  return s:fail('Not found: ' .. a:cmd_lhs)
endfun


"
"
"
"
"
fun! s:clear(...) abort
  if a:0 == 0
    let s:cmds = {}
    " keep installed maps (they just fall back to lastkey)
    return 1
  endif

  " Clear only specific LHS group (by lastkey bucket)
  let [l:ctype, l:pre, l:last] = s:split_lhs(a:1)
  if l:last ==# ''
    return s:fail('Invalid arg: ' .. string(a:1))
  endif
  if has_key(s:cmds, l:last)
    call remove(s:cmds, l:last)
    return 1
  endif
  return s:fail('Nothing to clear for lastkey: ' .. l:last)
endfun



"
" 
fun! s:list() abort
  let l:lines = []
  call add(l:lines, '--- AbbrevCmd definitions ---')
  for l:last in sort(keys(s:cmds))
    call add(l:lines, 'lastkey: ' .. l:last)
    for l:key in sort(keys(s:cmds[l:last]))
      let l:ent = s:cmds[l:last][l:key]
      let l:kind = get(l:ent, 'raw', 0) ? 'raw' : 'lit'
      call add(l:lines, printf('  %-6s  when=%s  rhs=%s', l:kind, string(l:key), string(l:ent.rhs)))
    endfor
  endfor
  if len(l:lines) == 1
    call add(l:lines, '(empty)')
  endif

  " Open in preview window (simple + portable)
  pclose
  execute 'pedit +setlocal\ buftype=nofile\ bufhidden=wipe\ nobuflisted\ noswapfile AbbrevCmdList'
  let l:preview_bufnr = bufnr('AbbrevCmdList')
  call setbufvar(l:preview_bufnr, '&modifiable', 1)
  call deletebufline(l:preview_bufnr, 1, '$')
  call setbufline(l:preview_bufnr, 1, l:lines)
  call setbufvar(l:preview_bufnr, '&modifiable', 0)
endfun


command! -nargs=+ -bang AbbrevCmd      call s:add(<bang>0, <f-args>)
command! -nargs=1       AbbrevCmdDel   call s:del(<f-args>)
command! -nargs=*       AbbrevCmdClear call s:clear(<f-args>)
command! -nargs=0       AbbrevCmdList  call s:list()

