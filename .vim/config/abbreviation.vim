" File: abbreviation.vim
" Author: marsh31
" Description: abbreviation script
" Last Modified: December 27, 2020


cabbrev <expr> w] (getcmdtype() ==# ":" && getcmdline() ==# "w]") ? "w" : "w]"
cabbrev <expr> fern (getcmdtype() ==# ":" && getcmdline() ==# "fern") ? "Fern" : "fern"
cabbrev <expr> fernb (getcmdtype() ==# ":" && getcmdline() ==# "fernb") ? "Fern bookmark:///" : "fernb"
cabbrev <expr> ldd (getcmdtype() ==# ":" && getcmdline() ==# "ldd" ) ? "LspDocumentDiagnostics" : "ldd"
cabbrev <expr> cargo (getcmdtype() ==# ":" && getcmdline() ==# "cargo" ) ? "Cargo" : "cargo"

cabbrev <expr> vterm (getcmdtype() ==# ":" && getcmdline() ==# "vterm" ) ? "vert terminal" : "vterm"
cabbrev <expr> sterm (getcmdtype() ==# ":" && getcmdline() ==# "sterm" ) ? "terminal" : "sterm"
