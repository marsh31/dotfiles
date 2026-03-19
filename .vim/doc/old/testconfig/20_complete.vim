

" Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"

" force refresh
imap <c-k> <Plug>(asyncomplete_force_refresh)
imap <c-]> <Plug>(lsp-hover)
nmap gd <plug>(lsp-definition)
nmap <F12> <plug>(lsp-definition)

" function! s:autoRefresh()
" 	if getline('.')[col('.') - 2] == " "
" 		call asyncomplete#_force_refresh()
" 	endif
" endfunction
function! s:completeDone()
	if pumvisible() == 0
		pclose
	endif
endfunction
" autocmd! TextChangedI * call s:autoRefresh()
autocmd! CompleteDone * call s:completeDone()

if has('python3')
    let g:UltiSnipsExpandTrigger="<Tab>"
    let g:UltiSnipsJumpForwardTrigger="<Tab>"
    let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
    let g:UltiSnipsEditSplit="vertical"
    let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
    set runtimepath+=~/.vim/UltiSnips

    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor'),
    \ }))
