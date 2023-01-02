scriptencoding utf-8
if exists('g:loaded_after_cpp_plugin')
  finish
endif
let g:loaded_after_cpp_plugin = 1

let s:save_cpo = &cpo
set cpo&vim

runtime! ./c.vim


let &cpo = s:save_cpo
unlet s:save_cpo
