
" MARK: - ale {{{1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

let g:ale_sign_column_always = 1

let g:ale_sign_error = '!!'
let g:ale_sign_warning = '??'
let g:ale_statusline_format = ['!!:%d', '??:%d', 'ok']

let g:ale_echo_msg_format = '[%linter%] [%severity%] %code: %%s'

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 5

hi ALEErrorSign ctermfg=Red ctermbg=None
hi ALEWarningSign ctermfg=Yellow ctermbg=None


hi clear ALEWarning
hi clear ALEError
let ale_linters = {
      \ 'c'     : ['clangd'],
      \ 'cpp'   : ['clangd'],
      \ 'go'    : ['gopls'],
      \ 'python': ['pyls'],
      \ }

let ale_fixers = {
      \ 'c'   : ['clang-format'],
      \ 'cpp'   : ['clang-format'],
      \ 'go'    : ['gofmt'],
      \ 'python': ['autopep8'],
      \ }



