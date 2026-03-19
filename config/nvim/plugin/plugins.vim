

" marsh31/Preview-Image.vim {{{

function! MarkdownImageLink()
  let matcher = matchstrpos(getline('.'), '!\[.\+\](\zs.\+\ze)')
  if matcher[1] == -1
    return 0
  endif

  let matcher = matchstrpos(matcher[0], '\zs\S\+\ze')
  if matcher[1] == -1
    return 0
  endif

  let path = expand('%:p:h') . '/' . matcher[0]
  return { 'path': path }
endfunction

" call preview_image#extend('MarkdownImageLink', 1000, "markdown")


" }}}


" {{{
" vim: foldmethod=marker
