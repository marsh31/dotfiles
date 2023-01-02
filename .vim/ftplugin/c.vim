scriptencoding utf-8
if exists('g:loaded_c_plugin')
  finish
endif
let g:loaded_c_plugin = 1

let s:save_cpo = &cpo
set cpo&vim


"
" MARK: - custom plugin setting.
"
command! CCppFileChange call c_cpp#CCppFileChange()



let &cpo = s:save_cpo
unlet s:save_cpo

