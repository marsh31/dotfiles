--
-- NAME:   init.vim
-- AUTHOR: marsh
-- NOTE:
--
--

vim.g.mapleader = [[ ]]
-- vim.g.maplocalleader = [[,]]

-- ~/.config/nvim/lua/config.lua
--
-- -- ~/.config/nvim/lua/plugins.lua
-- require("plugins")
--
-- -- ~/.config/nvim/lua/keymaps.lua
-- require("keymaps")
--


require("config")
require("plugin_manager").setup()
require("plugin_manager").load_plugins()



vim.cmd.colorscheme([[gruvbox]])

-- vim: sw=4 sts=4 expandtab fenc=utf-8
