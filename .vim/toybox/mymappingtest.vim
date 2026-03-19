
let g:mymappingtest_loadingflag = v:true
if g:mymappingtest_loadingflag
  finish
endif

fun! s:OpenPopup()
  call popup_create('hello', {})
  return "\<Ignore>"
endfun


nnoremap <expr> <F3> <SID>OpenPopup()



fun! s:StoreColumn()
  let g:column = col('.')
  return 'x'
endfun

nnoremap <expr><buffer> x <SID>StoreColumn()
nmap ! f!<Ignore>x


inoremap <expr> <C-L>  nr2char(getchar())
inoremap <expr> <C-L>x "foo"

nnoremap <F2> aText <Cmd>echo mode(1)<CR> Added<Esc>
nnoremap <F3>       <Cmd>echo mode(1)<CR>


let g:counter = 0
inoremap <expr> <C-L> ListItem()
inoremap <expr> <C-R> ListReset()

fun! ListItem()
  let g:counter += 1
  return g:counter .. '. '
endfun

fun! ListReset()
  let g:counter = 0
  return ''
endfun


inoremap <C-CR> controlcr
inoremap <S-CR> shiftcr


" :map-operator

nnoremap <expr> <F4> CountSpaces()
xnoremap <expr> <F4> CountSpaces()

nnoremap <expr> <F4><F4> CountSpaces() .. '_'


fun! CountSpaces(context = {}, type = '') abort
  if a:type == ''
    let context = #{
          \ dot_command: v:false,
          \ extend_block: '',
          \ virtualedit: [ &l:virtualedit, &g:virtualedit],
          \ }
    let &operatorfunc = function('CountSpaces', [ context ])
    set virtualedit=block
    return 'g@'
  endif

  let save = #{
        \ clipboard: &clipboard,
        \ selection: &selection,
        \ virtualedit: [ &l:virtualedit, &g:virtualedit ],
        \ register: getreginfo('"'),
        \ visual_marks: [ getpos("'<"), getpos("'>") ],
        \ }

  try
    set clipboard= selection=inclusive virtualedit=
    let commands = #{
          \ line: "'[V']",
          \ char: "`[v`]",
          \ block: "`[\<C-V>`]",
          \ }[a:type]
    let [ _, _, col, off ] = getpos("']")
    if off != 0
      let vcol = getline("'[")->strpart(0, col + off)->strdisplaywidth()
      if vcol >= [line("'["), '$']->virtcol() - 1
        let a:context.extend_block = '$'
      else
        let a:context.extend_block = vcol .. '|'
      endif
    endif

    if a:context.extend_block != ''
      let commands ..= 'oO' .. a:context.extend_block
    endif
    let commands ..= 'y'
    execute 'silent noautocmd keepjumps normal! ' .. commands
    echomsg getreg('"')->count(' ')
  finally
    call setreg('"', save.register)
    call setpos("'<", save.visual_marks[0])
    call setpos("'>", save.visual_marks[1])

    let &clipboard = save.clipboard
    let &selection = save.selection
    let [ &l:virtualedit, &g:virtualedit ] = get(a:context.dot_command ? save : a:context, 'virtualedit')
    let a:context.dot_command = v:true
  endtry
endfun




" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
