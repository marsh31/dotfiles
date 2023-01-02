function! MyTabLine()
    let s = ""
    for i in range(tabpagenr("$"))
        if i + 1 == tabpagenr()
            let s .= "%#TabLineSel#"
        else
            let s .= "%#TabLine#"
        endif

        let s .= "%" . (i + 1) . "T"

        let s .= " %{MyTabLabel(" . (i + 1) . ")} "
    endfor

    let s .= "%#TabLineFill#%T"

    return s
endfunction

function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)

    " let name = fnamemodify(bufname(buflist[winnr - 1]), ":t")

    let buffer_name = substitute(bufname(buflist[winnr - 2]), "fern:.*file://", "", "")
    let name = pathshorten(buffer_name)

    if name == ""
        let name = "[No Name]"
    endif
    return a:n . ":" . name
endfunction

set tabline=%!MyTabLine()
