" vim-surround
let g:surround_42 = "**\r**"
let g:surround_126 = "~~\r~~"

let g:markdown_fenced_languages = [
			\ 'html',
			\ 'c',
			\ 'bash=sh',
			\ 'cpp',
			\ 'python'
			\ ]

let g:previm_open_cmd = "firefox"


" plasticboy/vim-markdown
let g:vim_markdown_folding_disable = 1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

setlocal nofoldenable

" iamcco/markdown-preview.nvim
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refreshy_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ""
let g:mkdp_browser = ""
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ""
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

let g:mkdp_markdown_css = ""
let g:mkdp_highlight_css = ""
let g:mkdp_port = ""
let g:mkdp_page_title = "${name}"
