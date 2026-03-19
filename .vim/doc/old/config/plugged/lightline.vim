" NAME: lightline.vim
" PATH: $HOME/.vim/plugged/lightline.vim

set laststatus=2
set showtabline=2

" MARK: - lightline.vim {{{1
" MARK: - lightline config value {{{2
" seoul256
let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ], [ 'filename' ], ['fugitive'] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ],
      \              [ 'ale', 'charcode', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'tabline': {
      \   'left':  [['tabs']],
      \   'right': [[]]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileFormat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ale': 'Ale_string',
      \ },
      \ 'separator': {'left': "\ue0b0", "right": "\ue0b2" },
      \ 'subseparator': {"left": "\ue0b1", "right": "\ue0b3" },
      \ 'tabline_separator': {"right": ""},
      \ 'tabline_subseparator': {},
      \ }


" MARK: - lightline functions {{{2
function! LightlineModified()
  return &ft =~ 'help\|nerdtree\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction


function! LightlineReadonly()
  return &ft !~? 'help\|nerdtree\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction


function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'nerdtree' ? "NERDTree" :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction


function! LightlineFugitive()
  if &ft !~? 'nerdtree\|vimfiler\|gundo' && exists('*fugitive#head')
    let _ = fugitive#head()
    return strlen(_) ? _ : ''
  else
    return ''
  endif
endfunction


function! LightlineFileFormat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction


function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction


function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction


function! LightlineMode()
  if &ft !~? 'nerdtree\|gundo' && winwidth(0) > 60
    return lightline#mode()
  else
    return ''
  endif
endfunction

function! Ale_string()
  if !exists('g:ale_buffer_info')
    return ''
  endif

  let l:buffer = bufnr('%')
  let l:counts = ale#statusline#Count(l:buffer)
  let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format

  if l:counts.total == 0
    return l:no_errors

  else
    let l:error_count = l:counts.error + l:counts.style_error
    let l:warning_count = l:counts.warning + l:counts.style_warning
    return printf(l:error_format, l:error_count) . " ". printf(l:warning_format, l:warning_count)

  endif
endfunction
