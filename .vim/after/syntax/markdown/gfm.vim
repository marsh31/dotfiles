" 
"
"
"

" inline code
syn region gfmInlineCode  start="\%(^\|[^`\\]\)\@<=`[^`]" end="`" display oneline

" mentions
syn match  gfmMentions    "\%(^\|\s\)\@<=@[[:alnum:]-]\+"  display

" tag
syn match  gfmTag         "#\@<!#\S\+\>" display

" note
syn region mdNote         start=":::note" end="^:::$"

" checkbox
" syn match  myCheckbox     ""
"
" ^\s*\%(-\|\*\|+\|\d\+\.\)\s\+\[.\]\s\+.*$
" ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        checkbox
"                                       ^^^ text

" version 1
" syn match  mdCheckbox     "^\s*\zs\%(-\|\*\|+\|\d\+\.\)\s\+\[.\]"     nextgroup=mdCheckboxText skipwhite
" syn match  mdCheckboxDone "\[x\]"                                     containedin=mdCheckbox
" syn match  mdCheckboxText ".\+$" contained contains=gfmMentions,gfmTag


" version 2
" syn region  mdCheckboxLine    start="^\s*\zs\%(-\|\*\|+\|\d\+\.\)\s\+\["    end="$" 
"       \ contains=mdCheckboxTodo,mdCheckboxDone,mdCheckboxCancel,mdCheckboxText
"       \ display
" 
" syn match   mdCheckboxTodo    "\[ \]"  contained
" syn match   mdCheckboxDone    "\[x\]"  contained nextgroup=mdCheckboxStrikeText skipwhite
" syn match   mdCheckboxCancel  "\[-\]"  contained
" 
" syn match   mdCheckboxStrikeText    ".\+$" contained contains=gfmMentions,gfmTag
" syn match   mdCheckboxText          "\%(\]\s\+\)\@<=.\+$" contained contains=gfmMentions,gfmTag

syn match mdCheckboxTodo        "^\s*\zs\%(-\|\*\|+\|\d\+\.\)\s\+\[ \]\s\+" skipwhite nextgroup=mdCheckboxText
syn match mdCheckboxDone        "^\s*\zs\%(-\|\*\|+\|\d\+\.\)\s\+\[x\]\s\+" skipwhite nextgroup=mdCheckboxStrikeText

syn match mdCheckboxText        ".\+$" contained contains=gfmMentions,gfmTag
syn match mdCheckboxStrikeText  ".\+$" contained contains=gfmMentions,gfmTag




""""""""""""""""""""""""""""""""""""
" highlight
"

hi def link gfmInlineCode    Constant
hi def link gfmMentions      markdownLinkText
hi def link gfmTag           markdownLinkText

" hi def link mdCheckboxLine   CursorLineNr
" hi def link mdCheckboxDone   Question
" hi def link mdCheckboxText   SpecialKey

" hi! link mdCheckbox       SpecialKey
" hi! link mdCheckboxText   CursorLineNr

hi! clear mdCheckboxLine  
hi! link mdCheckboxTodo       WildMenu
hi! link mdCheckboxDone       ErrorMsg
hi! link mdCheckboxCancel     Pmenu
hi! link mdCheckboxText       Tag
hi! link mdCheckboxStrikeText markdownStrike 

hi! link mdNote               Directory





" END: {{{1
" vim: set ft=vim expandtab tabstop=2 :
