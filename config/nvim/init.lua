--
-- NAME:   init.vim
-- AUTHOR: marsh
-- NOTE:
--
--

vim.g.mapleader = [[ ]]
-- vim.g.maplocalleader = [[,]]

-- ~/.config/nvim/lua/config.lua
require("config")

-- ~/.config/nvim/lua/plugins.lua
require("plugins")

--
-- Key map
--
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

vim.keymap.set("n", "<Leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "<Leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<Leader>r", "<cmd>source %<CR>")

-- require("telescope").load_extension"ghq"
vim.keymap.set("n", "<Leader><Leader>ff", "<cmd>Telescope find_files hidden=true<CR>")
vim.keymap.set("n", "<Leader><Leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<Leader><Leader>fg", "<cmd>Telescope grep_string<CR>")
vim.keymap.set("n", "<Leader><Leader>gl", "<cmd>Telescope ghq list<CR>")
vim.keymap.set("n", "<Leader><Leader>fo", "<cmd>Telescope aerial<CR>")

vim.keymap.set("n", "<C-c><C-c>", "<cmd>nohlsearch<CR>")

vim.keymap.set("i", "jj", "<ESC>")

--
-- Command window
--
-- https://zenn.dev/vim_jp/articles/2022-vim-advent-calender-cmdwin?redirected=1
vim.api.nvim_create_augroup("my_cmdwin_config", {})
vim.api.nvim_create_autocmd("CmdwinEnter", {
	group = "my_cmdwin_config",
	pattern = { "*" },
	callback = function()
		vim.keymap.set("n", "q", "<Cmd>quit<CR>", { buffer = true })
		vim.keymap.set("n", "<C-c>", "<Cmd>quit<CR>", { buffer = true })

		vim.keymap.set("n", "/", "G?", { buffer = true }) -- support
		vim.keymap.set("n", "?", "G/", { buffer = true }) -- support
	end,
})

--
-- autocmd
--
vim.api.nvim_create_augroup("GrepCmd", {})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = "GrepCmd",
	pattern = { "vimgrep,grep,grepadd" },
	callback = function()
		if vim.fn.len(vim.fn.getqflist()) ~= 0 then
			vim.api.nvim_command("copen")
		end
	end,
})

if vim.fn.executable("rg") then
	vim.opt.grepprg = "rg --vimgrep --hidden"
	vim.opt.grepformat = "%f:%l:%c:%m"
end



------------------------------------------------------------
-- For packer.
--
--   Auto compile lua config file.
--
vim.api.nvim_create_augroup("packer_user_config", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "packer_user_config",
	pattern = { "plugins.lua" },
	command = "source <afile> | PackerCompile",
})


-- vim: sw=4 sts=4 expandtab fenc=utf-8
