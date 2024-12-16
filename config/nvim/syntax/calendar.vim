
if exists("b:current_syntax")
    finish
endif

" calendar syntax
syntax iskeyword @,48-57,_,128-167,224-235,.,-

syn keyword   MonthL  Jan[uary] Feb[ruary] Mar[ch] Apr[il] May Jun[e] Jul[y] Aug[ust] Sep[tember] Oct[ober] Nov[ember] Dec[ember]
syn keyword   WeekL   Mon[day] Tue[sday] Wed[nesday] Thu[rsday] Fri[day] Sat[urday] Sun[day] 
syn keyword   WeekS4  Mon.   Tue.    Wed.      Thu.     Fri.   Sat.     Sun.
syn keyword   WeekS3  Mo.    Tu.     We.       Th.      Fr.    Sa.      Su.
syn keyword   WeekS2  Mo     Tu      We        Th       Fr     Sa       Su

syn match     Holiday '^\s\+\d\+\s\+'




hi def link   CalNavi Type
hi def link   MonthL  Type
hi def link   WeekL   Type
hi def link   WeekS4  Type
hi def link   WeekS3  Type
hi def link   WeekS2  Type





let b:current_syntax = "calendar"
