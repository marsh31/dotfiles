" qf actions
" Version: 1.1
" Author : marsh

" aboveleft leftabove belowright rightbelow botright topleft tab
command! Qfedit       call s:action_edit()
command! Qfsplit      call s:action_split(<q-mods>)
command! Qfvsplit     call s:action_vsplit(<q-mods>)
command! Qftabnew     call s:action_tabnew()



"
" IF
"
function! s:action_edit(mods)
  let qfinfo = s:get_qfinfo_line()

  call s:move_previous_window()
  exec printf("%db +%d | normal! %d|", qfinfo.bufnr, qfinfo.lnum, qfinfo.col)
endfunction


function! s:action_split(mods)
  let qfinfo = s:get_qfinfo_line()
  let attr   = ''
  if a:mods =~ '\(aboveleft\|leftabove\|belowright\|rightbelow\|botright\|topleft\|tab\)'
    let attr   = a:mods .. ' '
  endif

  call s:move_previous_window()
  exec printf("%ssplit | %db +%d | normal! %d|", attr, qfinfo.bufnr, qfinfo.lnum, qfinfo.col)
endfunction


function! s:action_vsplit(mods)
  let qfinfo = s:get_qfinfo_line()
  let attr   = ''
  if a:mods =~ '\(aboveleft\|leftabove\|belowright\|rightbelow\|botright\|topleft\|tab\)'
    let attr   = a:mods .. ' '
  endif

  call s:move_previous_window()
  exec printf("%svsplit | %db +%d | normal! %d|", attr, qfinfo.bufnr, qfinfo.lnum, qfinfo.col)
endfunction


function! s:action_tabnew(mods)
  let qfinfo = s:get_qfinfo_line()

  call s:move_previous_window()
  exec printf("tabnew | %db +%d | normal! %d|", qfinfo.bufnr, qfinfo.lnum, qfinfo.col)
endfunction

" 
" SCRIPT FUNCTIONS
"

function! s:get_qfinfo_line()
  return getqflist()[line('.')-1]
endfunction



function! s:move_previous_window()
  call win_gotoid(win_getid(winnr('#')))
endfunction


