" marsh color prototype.
"
" MARK: - add gui color because that value was used on terminal when tern on
" the turmguicolors

set background=dark
set cursorline
set t_Co=256

if version > 580
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="qtdark"


" MARK: - Normal text
hi Normal       ctermfg=187 ctermbg=NONE guifg=#d6cf9a guibg=#2e2f30 cterm=NONE 


" MARK: - Line number
hi LineNr       ctermfg=250 ctermbg=None guifg=#bec0c2 guibg=#404244 cterm=None 


" MARK: - Cursor color
hi CursorColumn             ctermbg=232                guibg=#373737 cterm=None
hi CursorLine               ctermbg=232                guibg=#373737 cterm=None
hi CursorLineNr ctermfg=3   ctermbg=None guifg=#d6c540 guibg=#404244 cterm=bold 


" MARK: - Fold colors
hi Folded       ctermfg=3   ctermbg=232  guifg=#d6c540 guibg=#373737 cterm=italic,underline 
hi FoldColumn   ctermfg=3   ctermbg=None cterm=None             

hi Comment      ctermfg=246              guifg=#a8abb0               cterm=italic 

" MARK: - vertial or split line
hi VertSplit    ctermfg=7   ctermbg=7    guifg=#404244 guibg=#404244 cterm=None 

" MARK: - keywords
hi Directory    ctermfg=3   ctermbg=None                             cterm=None


" MARK: - todo mark
" call matchadd("Todo", '\(TODO\|NOTE\|INFO\|MARK\|FIXME\):\ -')
hi Todo         ctermfg=11  ctermbg=None guifg=#ff0000 guibg=#2e2f30 cterm=italic 

" MARK: - diff
"
" TODO 
