--
-- NAME:   init.vim
-- AUTHOR: marsh
-- NOTE:
-- 

vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[\]]
-- vim.g.maplocalleader = [[,]]

-- ./lua/config.lua
require("config")

-- ./lua/manager.lua
local pm = require("manager")
pm.setup()
pm.load_plugins()

-- ./lua/command.lua
require("command")


-- ./lua/autocmd.lua
require("autocmd")


-- ./lua/keymaps.lua
require("keymaps")

-- -- highlight Normal ctermbg=NONE guibg=NONE
-- vim.api.nvim_set_hl(0, "Normal", {
--     bg = "NONE"
-- })


-- vim: sw=4 sts=4 expandtab fenc=utf-8
