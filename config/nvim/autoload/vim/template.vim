

function! vim#template#wrap(dict, template_name) abort
  let l:tmp = get(g:, "sonictemplate_vim_vars", {})
  let g:sonictemplate_vim_vars = a:dict

  exec printf('Template %s', a:template_name)

  let g:sonictemplate_vim_vars = l:tmp
endfunction
