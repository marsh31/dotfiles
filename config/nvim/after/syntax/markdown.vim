" NAME:   after/syntax/markdown.vim
" AUTHOR: marsh
"
"
" :highlight markdownH1
" markdownH1     xxx links to htmlH1
" :highlight htmlH1
" htmlH1         xxx links to Title
" :highlight Title
" Title          xxx cterm=bold gui=bold guifg=#79c0ff
"
" ~/.asdf/installs/neovim/0.10.0/share/nvim/runtime/syntax/markdown.vim
" 
" :Inspect
" :InspectTree
"
" https://leaysgur.github.io/posts/2024/04/16/092858/
" https://zenn.dev/vim_jp/articles/2022-12-25-vim-nvim-treesitter-2022-changes#%E4%BB%8A%E5%BE%8C%E3%81%A9%E3%81%86%E3%81%99%E3%82%8C%E3%81%B0%E3%82%88%E3%81%84%E3%81%8B-1


highlight    markdownH1  gui=bold  guifg=#58B2DC  guibg=None
highlight    markdownH2  gui=bold  guifg=#58B2DC  guibg=None
highlight    markdownH3  gui=bold  guifg=#58B2DC  guibg=None
highlight    markdownH4  gui=bold  guifg=#58B2DC  guibg=None
highlight    markdownH5  gui=bold  guifg=#58B2DC  guibg=None
highlight    markdownH6  gui=bold  guifg=#58B2DC  guibg=None

" call matchadd('markdownH1', '^\s*#\+.*', 10, -1, { 'hl_eol': 1 })

" :Inspect
" Treesitter
"   - @text.title.1.markdown links to @text markdown
"   - @text.title.2.markdown links to @text markdown
"   - @text.title.3.markdown links to @text markdown
"   - @text.title.4.markdown links to @text markdown
"   - @text.title.5.markdown links to @text markdown
"   - @text.title.6.markdown links to @text markdown
"
" Extmarks
"   - IlluminatedWordText illuminate.highlight


hi def link @text.title.1.markdown markdownH1
hi def link @text.title.2.markdown markdownH2
hi def link @text.title.3.markdown markdownH3
hi def link @text.title.4.markdown markdownH4
hi def link @text.title.5.markdown markdownH5
hi def link @text.title.6.markdown markdownH6
"
hi def link @text.title.1.marker.markdown markdownH1
hi def link @text.title.2.marker.markdown markdownH2
hi def link @text.title.3.marker.markdown markdownH3
hi def link @text.title.4.marker.markdown markdownH4
hi def link @text.title.5.marker.markdown markdownH5
hi def link @text.title.6.marker.markdown markdownH6


" Treesitter
"   - @text.title.2.marker.markdown links to @text markdown
