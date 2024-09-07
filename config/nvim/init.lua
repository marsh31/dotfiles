-- NAME:   init.vim
-- AUTHOR: marsh
-- NOTE:
-- 

vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

vim.g.my_plugin_list = "default"

-- ./lua/config.lua
require("default/config")


-- ./lua/manager.lua
local pm = require("default/manager")
pm.setup()
pm.load_plugins("default/plugins")
-- pm.load_plugins("sample/ddc/plugins")

-- ./lua/command.lua
require("default/command")


-- ./lua/autocmd.lua
require("default/autocmd")


-- ./lua/default/keymaps.lua
require("default/keymaps")

-- -- highlight Normal ctermbg=NONE guibg=NONE
-- vim.api.nvim_set_hl(0, "Normal", {
--     bg = "NONE"
-- })


-- vim.cmd.colorscheme([[kanagawa-dragon]])
-- vim.cmd.colorscheme([[carbonfox]])
vim.cmd.colorscheme([[github_dark_colorblind]])


-- vim: sw=4 sts=4 expandtab fenc=utf-8
