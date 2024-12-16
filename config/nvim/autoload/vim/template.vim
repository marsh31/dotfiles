" template.vim
"
"   sonictemplate wrapper
"


" vim#template#wrap
"
" args
"   arg1 dict          dictionary sonictemplate_vim_vars
"   arg2 template_name string     template name
"
" sonictemplate のラッパー関数。
" {{_input_:var}} で指定する入力をグローバル変数に影響を与えずに利用する
" ための関数。
"
function! vim#template#wrap(dict, template_name) abort
  let l:tmp = get(g:, "sonictemplate_vim_vars", {})
  let g:sonictemplate_vim_vars = a:dict

  call sonictemplate#apply(a:template_name, "n")

  let g:sonictemplate_vim_vars = l:tmp
endfunction

