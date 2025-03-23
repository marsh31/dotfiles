" NAME:   search
" AUTHOR: marsh
"
" NOTE:
"
"

let s:jobid = 0
let s:log = v:null
let s:parser = ripgrep#parser#parser()
let s:found = v:false


" ripgrep_qf#search#search {{{


fun! ripgrep_qf#search#search(args) abort
  let s:log = LogConfig("rg_tag")
  let args = a:args
  let cwd = "."
  let s:fount = v:false

  let s:jobid = ripgrep#job#start(args, cwd, {
        \ 'reset':     function('s:reset_handler'),
        \ 'on_stdout': function('s:stdout_handler'),
        \ 'on_stderr': function('s:stderr_handler'),
        \ 'on_exit':   function('s:exit_handler'),
        \ })
endfun


" }}}
" s:stdout_handler {{{


fun! s:stdout_handler(id, data, event_type)
  call s:log.debug("ok", "+ stdout +++++")
  for l:line in a:data
    let line_obj = s:parser.parse(l:line)
    if type(line_obj) == v:t_dict
      let handler = ripgrep_qf#adapter#convert(line_obj)
      let l:event = handler[0]
      let l:body = handler[1]

      if l:event == 'match'
        let s:found = ripgrep_qf#adapter#add_match(s:found, l:body)
      endif
    endif
  endfor
endfun


" }}}
" s:stderr_handler {{{


fun! s:stderr_handler(id, data, event_type) abort
  call s:log.debug("ok", "+ errout +++++")
  for l:line in a:data
    call s:log.error("ng", l:line)
  endfor
endfun

" }}}
" s:exit_handler {{{

fun! s:exit_handler(id, data, event_type) abort
  call s:log.info("OK", "+ exit +++++")
  let l:status = a:data
endfun

" }}}
" s:reset_handler {{{


fun! s:reset_handler() abort
  call s:log.debug("ok", $'* Reset!!! {s:jobid}')
  call s:parser.reset()
  call ripgrep_qf#adapter#reset()
  call ripgrep#job#stop(s:jobid)
endfun


" }}}
" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
