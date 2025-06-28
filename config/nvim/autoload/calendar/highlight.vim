" NAME:   autoload/calendar/highlight.vim
" AUTHOR: marsh
"
" Calendarバッファのシンタックス、ハイライト制御


" init_syntax
"
" カレンダーバッファのシンタックスを設定する。
function! calendar#highlight#init()
  syn keyword   CalWSun     Su
  syn keyword   CalWSat     Sa

  syn match     CalBar                / \?| \?/
  syn match     CalNavi     display   '\(<Prev\|Today\|Next>\)'
  syn match     CalHeader   display   '[^ ]*\d\+\/\d\+([^)]*)'

  syn match     CalSaturday display   '|.\{18}\s\([0-9\ ]\d\)'hs=e-1 contains=ALL
  syn match     CalSunday   display   '|\s\([0-9\ ]\d\)'hs=e-1       contains=ALL
  syn match     CalToday    display   '\*\d\{,2\}'                   contains=ALL

  syn match     CalWK        contained /\t\(WK\d\d\)/
  syn match     CalToday     contained /\(\*\d\d\| \*\d\)/
  syn match     CalSunday    contained /\t\(WK\d\d\)\?\( \d\d\|  \d\)/                     contains=CalWK,CalToday
  syn match     CalSaturday  contained /\t\(WK\d\d\)\?.\{18\}\s\([0-9\ ]\d\)/hs=e-1        contains=CalSunday,CalWK,CalToday

  syn match     CalWeek                /\t\(WK\d\d\)\?\([\* ]\d\d\| [\* ]\d\|   \)\{7\}/   contains=CalWK,CalSunday,CalSaturday,CalToday

  hi! def link  CalNavi      Type
  hi! def link  WeekS2       Type
  hi! def link  CalWSun      CalSunday
  hi! def link  CalWSat      CalSaturday

  hi!           CalHeader    guifg=#fdac54 ctermfg=178 " 
  hi!           CalSaturday  guifg=#0086CC ctermfg=25  " 
  hi!           CalSunday    guifg=#E2421F ctermfg=196 " 紅葉色
  hi!           CalToday     guifg=#BB42F6
endfunction

