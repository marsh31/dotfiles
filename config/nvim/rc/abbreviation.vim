"=======================================
" FILE:   plugins/abbreviation.vim
" AUTHOR: marsh
"
" abbreviation config file.
"=======================================

function! s:cmdlineAbbreviation(input, replace) abort
  exec printf("cabbrev <expr> %s (getcmdtype() ==# \":\" && getcmdline() ==# \"%s\") ? \"%s\" : \"%s\"", a:input, a:input, a:replace, a:input)
endfunction

call s:cmdlineAbbreviation("tig", "Tig")



