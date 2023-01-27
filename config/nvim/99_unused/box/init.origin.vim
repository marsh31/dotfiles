""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File:   init.vim
" Author: marsh
"
" load plugin and setting.
" 期待動作と、それ以外の機能を落とすということをしたほうがいいかも。。。
" ちょっと予想外の機能が鬱陶しい。
" そのためには、pluginごとの設定をするか、一つのファイルにまとめるか何だけど、、、
" 一つのファイルにまとめるのに憧れがあるから、そっちでやってみようかな。。。
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" select file explorer
let g:enable_fern = v:true
let g:enable_nvim_tree = v:false
let g:vsnip_integ_debug = v:true
source $XDG_CONFIG_HOME/nvim/rc/plugins.vim
set completeopt=menu,menuone,noselect

inoremap jj <ESC>
let g:mapleader = "\<Space>"

" load initial config of lua/vim plugins.
" set basic configuration.
" $XDG_CONFIG_HOME/nvim/lua/init.lua

source $XDG_CONFIG_HOME/nvim/rc/editor.vim

source $XDG_CONFIG_HOME/nvim/rc/ui.vim
source $XDG_CONFIG_HOME/nvim/rc/terminal.vim
source $XDG_CONFIG_HOME/nvim/rc/fold.vim

source $XDG_CONFIG_HOME/nvim/rc/fuzzyfinder.vim
source $XDG_CONFIG_HOME/nvim/rc/commands.vim
source $XDG_CONFIG_HOME/nvim/rc/keys.vim
source $XDG_CONFIG_HOME/nvim/rc/abbreviation.vim

lua require('init')
" hi GitSignsAdd      guifg=#587c0c ctermfg=64 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi GitSignsChange   guifg=#0c7d9d ctermfg=31 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" hi GitSignsDelete   guifg=#94151b ctermfg=88 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" """"""""""""""
" "  quickrun  "
" """"""""""""""
" nnoremap <silent><leader>r :QuickRun<CR>
" let g:quickrun_config = get(g:, 'quickrun_config', {})
" let g:quickrun_config["_"]= {
"             \ "runner": "vimproc",
"             \ "runner/vimproc/updatetime": 60,
"             \ "outputter": "error",
"             \ "outputter/quickfix/open_cmd": "copen",
"             \ "outputter/error/success":    "buffer",
"             \ "outputter/error/error":      "quickfix",
"             \ "outputter/buffer/split":     ":botright 8",
"             \ "outputter/buffer/close_on_empty": 1
"             \ }
"
"
" let g:quickrun_config["rust"] = {
"             \ "command":  "cargo",
"             \ "exec":     "%c run"
"             \ }
"
" let g:quickrun_config["python/py3"] = {
"             \ "command":  "/usr/bin/python3",
"             \ "exec":     "%c %s:p",
"             \ }


" vim: sw=2 sts=2 expandtab fenc=utf-8
