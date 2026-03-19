" ======================================
" NAME:   zettelkasten#create
" AUTHOR: marsh
" NOTE:
"
"
"
"

let s:template_name = "zett"

"===============================================================================
" get_filepath  
" 現在のバッファに対して、editしてメモファイルを作る。  
" もしバッファを分割するなら事前に分割する。  
"
fun! s:get_filepath() abort
  let l:storepath     = vim#command#utils#trim_path(g:zettelkasten_dir) .. vim#command#utils#get_shellslashchar()
  let l:filename      = strftime(g:zettelkasten_date_format) .. '.' .. g:zettelkasten_ext
  let l:filepath      = l:storepath .. l:filename

  return l:filepath
endfun


"===============================================================================
" zettelkasten#create#enew  
" 現在のバッファに対して、editしてメモファイルを作る。  
" もしバッファを分割するなら事前に分割する。  
"
fun! zettelkasten#create#enew() abort
  let l:filepath      = s:get_filepath()
  let l:template_dict = {}

  exec printf("edit %s", l:filepath)
  call vim#template#wrap(template_dict, s:template_name)
endfun


"===============================================================================
" zettelkasten#create#new  
" 現在のバッファに対して、sp | editしてメモファイルを作る。  
" もしバッファを分割するなら事前に分割する。  
"
fun! zettelkasten#create#new() abort
  let l:filepath      = s:get_filepath()
  let l:template_dict = {}

  exec printf("sp | edit %s", l:filepath)
  call vim#template#wrap(template_dict, s:template_name)
endfun


"===============================================================================
" zettelkasten#create#vnew  
" 現在のバッファに対して、vs | editしてメモファイルを作る。  
" もしバッファを分割するなら事前に分割する。  
"
fun! zettelkasten#create#vnew() abort
  let l:filepath      = s:get_filepath()
  let l:template_dict = {}

  exec printf("vs | edit %s", l:filepath)
  call vim#template#wrap(template_dict, s:template_name)
endfun


"===============================================================================
" zettelkasten#create#tabnew  
" 現在のバッファに対して、vs | editしてメモファイルを作る。  
" もしバッファを分割するなら事前に分割する。  
"
fun! zettelkasten#create#tabnew() abort
  let l:filepath      = s:get_filepath()
  let l:template_dict = {}

  exec printf("tab sp | edit %s", l:filepath)
  call vim#template#wrap(template_dict, s:template_name)
endfun


" vim: set nowrap :
