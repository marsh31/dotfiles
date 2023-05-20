--
-- NAME:   init.vim
-- AUTHOR: marsh
-- NOTE:
--
--

vim.g.mapleader = [[ ]]
-- vim.g.maplocalleader = [[,]]



require("config")

require("manager").setup()
require("manager").load_plugins()

require("keymaps")




-- vim: sw=4 sts=4 expandtab fenc=utf-8
