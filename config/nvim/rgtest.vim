
" RipgrepTest
" {{{

let s:jobid = 0
let s:log = v:null
let s:parser = ripgrep#parser#parser()
let s:found = v:false

fun! RipgrepTestReset() abort
  call ripgrep#job#stop(s:jobid)
endfun

fun! RipgrepTest() abort
  let s:log = LogConfig("rg_tag")
  let args = "tags"
  let cwd = "/home/marsh/til/learn/memo/"
  let s:fount = v:false

  let s:jobid = ripgrep#job#start(args, cwd, {
        \ 'reset':     function('s:reset_handler'),
        \ 'on_stdout': function('s:stdout_handler_core'),
        \ 'on_stderr': function('s:stderr_handler'),
        \ 'on_exit':   function('s:exit_handler'),
        \ })
endfun

fun! s:stdout_handler_core(id, data, event_type)
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


fun! s:stderr_handler(id, data, event_type) abort
  call s:log.debug("ok", "+ errout +++++")
  for l:line in a:data
    call s:log.error("ng", l:line)
  endfor
endfun


fun! s:exit_handler(id, data, event_type) abort
  call s:log.info("OK", "+ exit +++++")
  let l:status = a:data
endfun

fun! s:reset_handler() abort
  call s:log.debug("ok", $'* Reset!!! {s:jobid}')
  call s:parser.reset()
  call ripgrep_qf#adapter#reset()
  call ripgrep#job#stop(s:jobid)
endfun
"
" }}}

" END {{{
" vim: set foldmethod=marker :
