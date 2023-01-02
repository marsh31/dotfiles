
scriptencoding utf-8
if exists('g:loaded_after_c_plugin')
  finish
endif
let g:loaded_after_c_plugin = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <F4> :CCppFileChange<CR>

"
" MARK: - plugin setting.
"

" call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')
" call deoplete#custom#var('clangx', 'default_c_options', '')

setlocal path=.,/usr/include,~/include

" let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-8/lib/libclang-8.so.1'
" let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-8/lib/clang/'
" let g:deoplete#sources#clang#std = {
"       \ 'c': 'c11',
"       \ 'cpp': 'c++14',
"       \ }

let &cpo = s:save_cpo
unlet s:save_cpo

