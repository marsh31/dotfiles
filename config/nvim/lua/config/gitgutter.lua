------------------------------------------------------------
-- File:   gitgutter.lua
-- Author: marsh
--
-- gitgutter config file.
--
-- disable default keymap.
-- change sign.
-- set color.
------------------------------------------------------------

vim.g.gitgutter_sign_added                   = '│'
vim.g.gitgutter_sign_modified                = '│'
vim.g.gitgutter_sign_removed                 = '_'
vim.g.gitgutter_sign_removed_first_line      = '‾'
vim.g.gitgutter_sign_removed_above_and_below = '-'
vim.g.gitgutter_sign_modified_removed        = '~'

vim.api.nvim_exec([[
highlight link GitGutterAdd     GitSignsAdd
highlight link GitGutterChange  GitSignsChange
highlight link GitGutterDelete  GitSignsDelete

highlight link GitGutterAddLineNr       GitGutterAdd
highlight link GitGutterChangeLineNr    GitGutterChange
highlight link GitGutterDeleteLineNr    GitGutterDelete
]], true)
