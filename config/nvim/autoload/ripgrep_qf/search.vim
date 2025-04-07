" NAME:   search
" AUTHOR: marsh
"
" NOTE:
"
"

let s:log = v:null

let s:jobid = 0
let s:parser = ripgrep#parser#parser()
let s:found = v:false

let s:args = ''
let s:cwd  = ''
let s:rel  = ''


" ripgrep_qf#search#search {{{


fun! ripgrep_qf#search#search(args, cwd = '.') abort
  let s:log = LogConfig("rg_tag")

  let s:jobid = 0
  let s:args = a:args
  let s:cwd = a:cwd
  let s:rel = fnamemodify(s:cwd, ':p:.')
  let s:fount = v:false

  call s:log.debug("ok", $"{s:cwd}")
  let s:jobid = ripgrep#job#start(s:args, s:cwd, {
        \ 'reset':     function('s:reset_handler'),
        \ 'on_stdout': function('s:stdout_handler'),
        \ 'on_stderr': function('s:stderr_handler'),
        \ 'on_exit':   function('s:exit_handler'),
        \ })

  call s:log.debug("ok", $'* Start!!! {s:jobid}')
  if s:jobid <= 0
    echoerr 'Failed to be call ripgrep'
  endif
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
        " TODO: if you use change working directory, add file path
        " let l:body['filename'] = ... . l:body['filename']
        let l:body['filename'] = vim#path#join([ s:rel, l:body['filename']])
        let s:found = ripgrep_qf#adapter#add_match(s:found, l:body)
      endif
    endif
  endfor
endfun


" }}}
" s:stderr_handler {{{


fun! s:stderr_handler(id, data, event_type) abort
  if a:data != [""]
    call s:log.debug("ok", "+ errout +++++")
    echomsg "*-*-*-*-*"
    echomsg a:data
    for l:line in a:data
      call s:log.error("ng", l:line)
    endfor

    echomsg "Ripgrep error!!"
    call s:reset_handler()
  endif
endfun

" }}}
" s:exit_handler {{{

fun! s:exit_handler(id, data, event_type) abort
  call s:log.info("OK", "+ exit +++++")

  let l:status = a:data
  call ripgrep_qf#adapter#finish(s:found, s:args, l:status)
  if l:status !=# 0
    echomsg "Failed to find " . s:args
  endif

  let s:jobid = 0
endfun

" }}}
" s:reset_handler {{{


fun! s:reset_handler() abort
  let s:found = v:false

  " job stop
  call ripgrep#job#stop(s:jobid)

  " parser reset
  call s:parser.reset()

  " clear quickfix
  call ripgrep_qf#adapter#reset()
endfun


" }}}
" ripgrep_qf#search#stop {{{


fun! ripgrep_qf#search#stop() abort
  if s:jobid <= 0
    return
  endif

  silent call ripgrep#job#stop(s:jobid)
  let s:jobid = 0
endfun


" }}}
" END {{{
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 foldmethod=marker:
