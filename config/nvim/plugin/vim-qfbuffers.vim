
func! QfBufferTextFunc(info)
  " quickfix の項目の対象範囲から情報を取得する
  let l = []
  let items = getqflist({'id' : a:info.id, 'items' : 1}).items

  for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
    let bufnr      = printf('%4d', items[idx].bufnr)
    let filename   = printf('%s', fnamemodify(bufname(items[idx].bufnr), ':p:t'))
    let module     = printf('%s', items[idx].module)
    " let lnum_col   = printf('%5d %5d', items[idx].lnum, items[idx].col)
    " let text       = items[idx].text
    let name       = module
    if module ==# ''
      let name     = filename
    endif

    let bufinfo    = getbufinfo(items[idx].bufnr)[0]
    
    let unlisted   = (bufinfo.listed  ==# v:true) ? ' ' : 'u'
    let hidden     = (bufinfo.hidden  ==# v:true) ? 'h' : 'a'
    let changed    = (bufinfo.changed ==# v:true) ? '+' : ' '

    let rmtype = ' '
    if (getbufvar(bufnr, '&readonly') ==# v:true)
      let rmtype = '='
    elseif (getbufvar(bufnr, '&modifiable') ==# v:false)
      let rmtype = '-'
    let type       = unlisted .. hidden .. changed .. rmtype
    let msg        = printf("%s %s %s", bufnr, type, name)
    call add(l, msg)
  endfor
  return l
endfunc



fun! s:getmodulename(bufpath, ft) abort
  let l:name = ''
  if empty(a:bufpath)
    if a:ft ==# 'qf'
      let l:name = '[Quickfix List]'

    elseif a:ft ==# 'help'
      let l:name = '[Help]'

    else
      let l:name = '[No Name]'

    endif
  else
    let l:name = fnamemodify(a:bufpath, ':t')

  endif

  return {
        \ 'path': a:bufpath,
        \ 'name': l:name
        \ }
endfun


fun! s:getbuflist() abort
  let buffers = []
  for bufnr in range(1, bufnr('$'))
    if bufexists(bufnr)

      let bufpath = bufname(bufnr)
      let ft      = getbufvar(bufnr, '&filetype')
      let module  = s:getmodulename(bufpath, ft)
      let bufinfo = getbufinfo(bufnr)[0]
      let text    = getbufline(bufnr, bufinfo.lnum)
      let text    = (len(text) == 0) ? '' : text[0]

      call add(buffers, {
            \ 'bufnr':    bufnr,
            \ 'filename': module.path,
            \ 'module':   module.name,
            \ 'lnum':     bufinfo.lnum,
            \ 'end_lnum': bufinfo.lnum,
            \ 'col':      1,
            \ 'end_col':  1,
            \ 'text':     text,
            \ 'type':     'BufferList'
            \ })
    endif
  endfor

  return buffers
endfun




" echo GetBufferList()
" call setqflist(s:getbuflist(), 'r')
call setqflist([], ' ', { 
      \ 'context':          { 'type': 'info' },
      \ 'items':            s:getbuflist(),
      \ 'quickfixtextfunc': 'QfBufferTextFunc',
      \ 'title':            "Buffer List"
      \ })

" vim: set nowrap
