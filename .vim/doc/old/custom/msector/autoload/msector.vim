" ================================================
" File:    autoload/msector.vim
" Version: 0.0.1
" Author:  marsh31 <marsh22h53@gmail.com>
" License: 
" ================================================

" MARK: - Pre processing {{{1
" ================================================
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


" MARK: - Utils {{{1
" ================================================
function! s:is_comment_line() abort
  let line = getline(".")
endfunction


" MARK: - Functions {{{1
function! msector#add_start_section() range abort
  let level = a:lastline - a:firstline + 1

  let comment_pattern = substitute(&commentstring, ' *%s', '', 'g')
  let add_string = comment_pattern . " " . split(&foldmarker, ',')[0] . level
  echo getline(".") . " " . add_string
endfunction



function! msector#add_end_section() abort
  let comment_pattern = substitute(&commentstring, ' *%s', '', 'g')
  let add_string = comment_pattern . " " . split(&foldmarker, ',')[1]
  echo getline(".") . " " . add_string
endfunction


" MARK: - Post processing {{{1
" ================================================
let &cpo = s:save_cpo
unlet s:save_cpo
