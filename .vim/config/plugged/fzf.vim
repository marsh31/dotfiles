" NAME: fzf.vim
" PATH: $HOME/.vim/plugged/fzf.vim

let g:fzf_command_prefix = 'Find'


" MARK: - fzf options
function! s:build_quickfix_list(lines)
  call setreg("+", a:lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_layout = { 'down': '~50%' }
" let g:fzf_layout = { 'window': '30new' }


" MARK: - fzf command options
let g:fzf_tags_command = 'ctags -R'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'




" MARK: - todo mark
let s:Marks = [
      \ "TODO:",
      \ "MARK:",
      \ ]

function! s:todo_lines() abort
  let mark_pattern = join(s:Marks, "\\|")
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, filter(map(getbufline(b, 0, "$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val'), {
          \ line, val -> match(val, mark_pattern) != -1
          \ }))
  endfor
  return res
endfunction
function! g:Todo_lines_qf() abort
  let lines = s:todo_lines()
  if len(lines) < 2
    return
  endif

  let qfl = []
  for line in lines
    let chunks = split(line, "\t", 1)
    let bn = chunks[0]
    let ln = chunks[1]
    let ltxt = join(chunks[2:], "\t")
    call add(qfl, {'filename': expand('%'), 'bufnr': str2nr(bn), 'lnum': str2nr(ln), 'text': ltxt})
  endfor
  call s:fill_quickfix(qfl, 'cfirst')
endfunction

function! Markdown_Header() abort
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, filter(map(getbufline(b, 0, "$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val'), {
          \ line, val -> match(val, "#") != -1
          \ }))
  endfor

  if len(res) < 1
    return
  endif

  let qfl = []
  for line in res
    let chunks = split(line, "\t", 1)
    let bn = chunks[0]
    let ln = chunks[1]
    let ltxt = join(chunks[2:], "\t")
    call add(qfl, {'filename': expand('%'), 'bufnr': str2nr(bn), 'lnum': str2nr(ln), 'text': ltxt})
  endfor

  call s:fill_quickfix(qfl, 'cfirst')
endfunction


let g:enhancedfzf_shortcuts = {
      \ 'Search history': "FindHistory/",
      \ 'Ag search'     : "FindAg",
      \ 'Buffers'       : "FindBuffers",
      \ 'Command hist'  : "FindHistory:",
      \ 'Commands'      : "FindCommands",
      \ 'Lines'         : "FindLines",
      \ 'TODO Marks'    : "FindTODOMarks",
      \ }

let g:enhancedfzf_toggle_list = {
      \ 'NERDTree': "NERDTreeToggle",
      \ 'UndoTree': "MundoToggle",
      \ 'Vista'   : "Vista focus",
      \ 'tig'     : "vert terminal ++close tig",
      \ 'Term v'  : "vert terminal ++close /usr/bin/zsh",
      \ 'Term s'  : "terminal ++close /usr/bin/zsh",
      \ }


