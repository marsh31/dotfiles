" marsh color prototype.
"
" MARK: - add gui color because that value was used on terminal when tern on
" the turmguicolors 
"
" TODO: need to chenge color not comfortable.

set background=dark
set t_Co=256

if version > 580
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="test"

function! g:HighlightColor(group, guifg, guibg, ctermfg, ctermbg, ...) abort
  let l:attr = get(a:, 1, "")
  let l:sp = get(a:, 2, "")

  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif

  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif

  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif

  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif

  if l:attr != ""
    exec "hi " . a:group . " gui=" . l:attr
    exec "hi " . a:group . " cterm=" . l:attr
  endif

  if l:sp != ""
    exec "hi " . a:group . " guisp=#" . l:sp
  endif
endfunction

" Set defualt colors because, current state is hard to think it.
" - color scheme color list {{{

let s:basebg0 = '#16160e'
let s:basebg1 = '#2b2b2b'

let s:basefg0 = '#d6cf9a'

let s:silver0 = '#a9a9a9'
let s:silver1 = '#c0c0c0'

let s:gold0   = '#daa520'
let s:gold1   = '#ffd700'

let s:gray0   = '#524748'
let s:gray1   = '#7d7d7d'

let s:black0  = '#000a02'
let s:black1  = '#000b00'

let s:white0  = '#f7efe3'
let s:white1  = '#f6f7f8'

let s:purple0 = '#884898'
let s:purple1 = '#b168a8'

let s:red0    = '#e7001d'
let s:red1    = '#ea0032'

let s:blue0   = '#005baa'
let s:blue1   = '#0086cc'

let s:green0  = '#7baa17'
let s:green1  = '#3eb370'

let s:cyan0   = '#00a3af'
let s:cyan1   = '#83ccd2'

let s:brown0  = '#ad4d00'
let s:brown1  = '#ce7a19'

let s:yellow0 = '#fda900'
let s:yellow1 = '#fed300'

let s:orange0 = '#ee7800'
let s:orange1 = '#fc5900'
" }}}

" MARK: - text
call g:HighlightColor('Normal',      s:basefg0, s:basebg0, "187", "NONE", "NONE")
call g:HighlightColor('NonText',     s:basebg0, "bg",      "187", "NONE", "NONE")
call g:HighlightColor('EndOfBuffer', s:basebg0, "bg",      "187", "NONE", "NONE")
call g:HighlightColor('Comment',     s:silver0, "bg",      "187", "NONE", "italic")

call g:HighlightColor('Constant',    s:cyan0,   "bg",      "",    "",     "italic")

call g:HighlightColor('String',      s:brown1,  "bg",      "",    "",     "NONE")
call g:HighlightColor('Character',   s:brown1,  "bg",      "",    "",     "NONE")
call g:HighlightColor('Number',      s:brown1,  "bg",      "",    "",     "NONE")
call g:HighlightColor('Float',       s:brown1,  "bg",      "",    "",     "NONE")
call g:HighlightColor('Boolean',     s:cyan1,   "bg",      "",    "",     "italic")

call g:HighlightColor('Identifier',  s:cyan0,   "bg",      "",    "",     "NONE")
call g:HighlightColor('Function',    s:basefg0, "bg",      "",    "",     "bold")

call g:HighlightColor('Statement',   s:cyan0,   "bg",      "",    "",     "italic")
call g:HighlightColor('Label',       s:yellow1, "bg",      "",    "",     "NONE")
" hi Conditional
" hi Repeat
" hi Operator
" hi Keyword
" hi Exception

call g:HighlightColor('PreProc',     s:purple1, "bg",      "",    "",     "NONE")
" hi Include
" hi Define
" hi Macro
" hi PreCondit

call g:HighlightColor('Type',        s:purple1, "bg",      "",    "",     "NONE")
" hi StorageClass
" hi Structure
" hi Typedef

" hi Special
" hi SpecialChar
" hi Tag
" hi Delimiter
" hi SpecialComment
call g:HighlightColor('Underlined',   s:blue1,   "bg",     "", "", "italic,underline")
call g:HighlightColor('Todo',         s:gold1,   "bg",     "", "", "italic")
call g:HighlightColor('Directory',    s:blue0,   "bg",     "", "", "NONE")
call g:HighlightColor('VertSplit',    s:gray0,   s:gray0,  "", "", "NONE")


" MARK: - message
call g:HighlightColor('ModeMsg',      s:basefg0, "bg",     "", "", "NONE")
call g:HighlightColor('MoreMsg',      s:basefg0, "bg",     "", "", "NONE")
call g:HighlightColor('Question',     s:basefg0, "bg",     "", "", "NONE")
call g:HighlightColor('WarningMsg',   s:yellow0, "bg",     "", "", "NONE")
call g:HighlightColor('ErrorMsg',     s:red1,    "bg",     "", "", "NONE")


" MARK: - Visual Mode
call g:HighlightColor('Visual',       "",        s:gray0,  "", "", "NONE")


" MARK: - Search
call g:HighlightColor('IncSearch',    s:black0,  s:gold0,   "", "", "NONE")
call g:HighlightColor('Search',       s:black0,  s:gold0,   "", "", "italic")
call g:HighlightColor('MatchParen',   s:black0,  s:green0,   "", "", "NONE")


" MARK: - Cursor
call g:HighlightColor('Cursor',       s:white0,  s:white0,  "", "", "NONE")
call g:HighlightColor('lCursor',      s:white0,  s:white0,  "", "", "NONE")
call g:HighlightColor('CursorIM',     s:white0,  s:white0,  "", "", "NONE")

call g:HighlightColor('LineNr',       s:silver0, "#1a1a1a",      "", "", "NONE")
call g:HighlightColor('CursorLine',   "",        s:basebg1, "", "", "NONE")
call g:HighlightColor('CursorLineNr', s:gold0,   s:basebg1, "", "", "NONE")
call g:HighlightColor('CursorColumn', "",        s:basebg1, "", "", "NONE")

call g:HighlightColor('QuickFixLine', "",        s:basebg1, "", "", "NONE")


" MARK: - Menu {{{
call g:HighlightColor('Pmenu',        s:basefg0, s:basebg1, "", "", "NONE")
call g:HighlightColor('PmenuSel',     s:white0,  s:blue0,   "", "", "NONE")
call g:HighlightColor('PmenuSbar',    s:basebg1, s:basebg1, "", "", "NONE")
call g:HighlightColor('PmenuThumb',   s:gray0,   s:gray0,   "", "", "NONE")
" }}}


" MARK: - Fold colors {{{
call g:HighlightColor('Folded',       s:silver0, "bg",      "", "", "italic,underline")
call g:HighlightColor('FoldColumn',   s:purple0, "bg",      "", "", "NONE")
" }}}


call g:HighlightColor('DiffAdd',      s:red0,    "bg",      "", "", "NONE")
call g:HighlightColor('DiffChange',   s:green0,  "bg",      "", "", "NONE")
call g:HighlightColor('DiffDelete',   s:blue0,   "bg",      "", "", "NONE")
call g:HighlightColor('DiffText',     s:yellow0, "bg",      "", "", "NONE")

" Not implemented {{{
" MARK: - Tab
" hi TabLine                               guifg=#000000 guibg=#000000 cterm=NONE
" hi TabLineFill                           guifg=#ffffff guibg=#000000 cterm=NONE
" hi TabLineSel                            guifg=#000000 guibg=#000000 cterm=NONE

" call g:HighlightColor('TabLine',     s:red0,    s:blue0,  "1", "2", "NONE")
" call g:HighlightColor('TabLineFill', s:yellow0, s:green0, "3", "4", "NONE")
" call g:HighlightColor('TabLineSel',  s:gray0,   s:white0, "6", "5", "NONE")

