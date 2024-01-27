
if exists("b:current_syntax")
    finish
endif

" calendar syntax
syn keyword   MonthL  January February March April May June July August September October November December
syn keyword   MonthS  Jan     Feb      Mar   Apr   May Jun  Jul  Aug    Sep       Oct     Nov      Dec

syn keyword   WeekL   

syn match     Holiday '^\s\+\d\+\s\+'



hi def link   MonthL  Type
hi def link   MonthS  Type
hi def link   Holiday Special





    " Monday   :          Mon. / Mo.
    " Tuesday  : Tues.  / Tue. / Tu.
    " Wednesday:          Wed. / We.
    " Thursday : Thurs. / Thu. / Th.
    " Friday   :          Fri. / Fr.
    " Saturday :          Sat. / Sa.
    " Sunday   :          Sun. / Su.











let b:current_syntax = "calendar"
