""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NAME:   markdown
" AUTHOR: marsh
"
" NOTE: {{{
"
" tabstop      <Tab> が対応する空白の数
" softtabstop  編集で<Tab>の幅として使用される空白の数。
" shiftwidth   自動インデントの各段落に使われる空白の数。
" expandtab    挿入モードで<Tab>を挿入するときに空白文字を入れる。
"              <Tab>文字を入れたい場合、<C-v><C-i>をする。
"
" }}}

if exists('b:did_loaded_ftplugin_markdown')
  finish
endif
let b:did_loaded_ftplugin_markdown = 1

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

" syntax match MyMarkdownHeader /^\s*#\+.*$/
" highlight MyMarkdownHeader cterm=NONE ctermbg=DarkBlue guifg=#161b22 guibg=#ec8e2c
" vim:tw=2 ts=2 et sw=2 wrap ff=unix fenc=utf-8 :
