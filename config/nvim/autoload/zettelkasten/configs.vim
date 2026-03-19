

" get_date_format
"
" return g:zettelkasten_date_format or 'YYYYmmddHHMMSS'
function! zettelkasten#configs#get_date_format()
  return get(g:, 'zettelkasten_date_format', '%Y%m%d%H%M%S')
endfunction


function! zettelkasten#configs#get_note_dir()
  return get(g:, 'zettelkasten_dir', expand('~/')
endfunction


