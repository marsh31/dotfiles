" 
"  ~~~~~~~~~~~~~~~~~~~~~~~~~~  
" >          2024/11(Nov)      
" >	WK   Su Mo Tu We Th Fr Sa  
" >	WK05 24 25 26*27 28 29 30  
"                hhh           Today
"  mhhhh                       Week number
"  mmmmmmhh                    Sunday 
"  mmmmmmmmmmmmmmmmmmmmmmmmhh  Saturday
"  mmmmmmmmmmmmmmmmmmmmmmmmmm  Week
" 
" WK number
" WK05 


syn match CalendarWK        contained /\t\(WK\d\d\)/
syn match CalendarToday     contained /\(\*\d\d\| \*\d\)/
syn match CalendarSunday    contained /\t\(WK\d\d\)\?\( \d\d\|  \d\)/                         contains=CalendarWK,CalendarToday
syn match CalendarSaturday  contained /\t\(WK\d\d\)\?.\{18\}\s\([0-9\ ]\d\)/hs=e-1             contains=CalendarSunday,CalendarWK,CalendarToday

syn match CalendarWeek                /\t\(WK\d\d\)\?\([\* ]\d\d\| [\* ]\d\|   \)\{7\}/       contains=CalendarWK,CalendarSunday,CalendarSaturday,CalendarToday



" vim: tw=0
