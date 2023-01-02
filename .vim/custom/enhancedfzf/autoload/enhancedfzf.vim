" enhancedfzf
" Version: 0.0.1
" Author : marsh31
" License: 
"
" This is autoload/enhancedfzf.vim

" MARK: - Pre processing {{{1
" ================================================
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


" MARK: - Utils {{{1
" ================================================
function! s:fill_quickfix(list, ...)
  if len(a:list) > 1
    call setqflist(a:list)
    copen
    wincmd p
    if a:0
      execute a:1
    endif
  endif
endfunction


" MARK: - fzf mru files {{{1
function! s:all_files() abort
  return extend(filter(copy(v:oldfiles), "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
        \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)' ), 'bufname(v:val)'))
endfunction

function! enhancedfzf#mru_files() abort
  call fzf#run({
      \ 'source' : reverse(s:all_files()),
      \ 'sink'   : 'e',
      \ 'options': '-m -x +s',
      \ 'down'   : '50%' })
endfunction


" MARK: - fzf toggles {{{1
function! s:all_toggles() abort
  return sort(keys(g:enhancedfzf_toggle_list))
endfunction

function! s:toggle_handler(cmd) abort
  execute ":" . g:enhancedfzf_toggle_list[a:cmd]
endfunction

function! enhancedfzf#toggles() abort
  call fzf#run({
      \ 'source' : s:all_toggles(),
      \ 'sink'   : function('s:toggle_handler'),
      \ 'options': '+m -0',
      \ 'down'   : '50%' })
endfunction



" MARK: - fzf register {{{1
" Register is ", 0, a-z, %, *, and +.
let s:reg_names = [
      \ '"', "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
      \ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
      \ 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
      \ '.', ':', '%', '*', '+'
      \ ]

function! s:all_register() abort 
  let l:values = []
  for c in s:reg_names
    call add(l:values, c. ": " . getreg(c))
  endfor
  return l:values
endfunction

function! s:register_handler(line) abort
  let l:values = split(a:line, ":")
  call setreg("+", l:values[1])
endfunction

function! enhancedfzf#register() abort
  call fzf#run({
        \ 'source'  : s:all_register(),
        \ 'sink'    : function('s:register_handler'),
        \ 'options' : '+m',
        \ 'down'    : "30%"
        \ })
endfunction


" MARK: - fzf Shortcuts {{{1
function! s:all_shortcuts() abort 
   return sort(keys(g:enhancedfzf_shortcuts))
endfunction
function! s:shortcut_handler(cmd) abort
  execute ":" . g:enhancedfzf_shortcuts[a:cmd]
endfunction

function! enhancedfzf#shortcut() abort
    call fzf#run({
      \ 'source'  : s:all_shortcuts(),
      \ 'sink'    : function('s:shortcut_handler'),
      \ 'options' : '+m',
      \ 'down'    : '50%' })
endfunction


" MARK: - Post processing {{{1
" ================================================
let &cpo = s:save_cpo
unlet s:save_cpo
