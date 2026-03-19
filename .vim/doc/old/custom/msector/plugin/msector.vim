" ======================================
" File:    plugin/msector.vim
" Version: 0.0.1
" Author:  marsh31
" License: 
" ======================================

" mark: - preprocessing {{{1
scriptencoding utf-8
if exists('g:loaded_msector')
  finish
endif
let g:loaded_msector = 1

let s:save_cpo = &cpo
set cpo&vim


" mark: - init values {{{1


" mark: - utils {{{1


" mark: - define commands {{{1
command! -range AddSection    <line1>,<line2>call msector#add_start_section()
command!        AddSectionEnd                call msector#add_end_section()


nmap <C-s>a :AddSection<CR>

" mark: - post processing {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
