" Name: asyncomplete-lsp.vim
" PATH: $HOME/.vim/plugged/async.vim
"       $HOME/.vim/plugged/vim-lsp
"       $HOME/.vim/plugged/vim-lsp-settings
"       $HOME/.vim/asyncomplete.vim
"       $HOME/.vim/asyncomplete-lsp.vim
"       $HOME/.vim/asyncomplete-ultisnips.vim
"       $HOME/.vim/asyncomplete-file.vim



" lsp settings
let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_fold_enabled = 0
let g:lsp_insert_text_enabled = 0
let g:lsp_text_edit_enabled = 0

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand("~/vim-lsp.log")
" let g:asyncomplete_log_file = expand("~/asyncomplete.log")

let g:asyncomplete_remove_duplicates = 1
let g:asyncommplete_auto_completeopt = 1
let g:asyncomplete_smart_completion = 0
let g:asyncomplete_popup_delay = 50
let g:asyncomplete_auto_popup = 1


" function! s:autoRefresh()
" 	if getline('.')[col('.') - 2] == " "
" 		call asyncomplete#_force_refresh()
" 	endif
" endfunction
" set omnifunc=lsp#complete
function! s:completeDone()
	if pumvisible() == 0
		pclose
	endif
endfunction
" autocmd! TextChangedI * call s:autoRefresh()

augroup vim-lsp-complete
  autocmd!
  autocmd! CompleteDone * call s:completeDone()
augroup END


if has('python3')
    let g:UltiSnipsExpandTrigger="<Tab>"
    let g:UltiSnipsJumpForwardTrigger="<Tab>"
    let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
    set runtimepath+=~/.vim/UltiSnips

    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif



" call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"     \ 'name': 'file',
"     \ 'allowlist': ['*'],
"     \ 'priority': 10,
"     \ 'completor': function('asyncomplete#sources#file#completor'),
"     \ }))


call asyncomplete#register_source(asyncomplete#sources#path#get_source_options({
      \ 'name': 'path',
      \ 'allowlist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asycomplete#sources#path#completor'),
      \ }))

