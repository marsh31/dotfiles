--
-- Command window
--
-- https://zenn.dev/vim_jp/articles/2022-vim-advent-calender-cmdwin?redirected=1
vim.api.nvim_create_augroup("my_cmdwin_config", {})
vim.api.nvim_create_autocmd("CmdwinEnter", {
    group = "my_cmdwin_config",
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = true
        vim.opt_local.signcolumn = "no"
        vim.api.nvim_command("startinsert")
    end,
})

--
-- autocmd
--
vim.api.nvim_create_augroup("KeepLastPos", {})
vim.api.nvim_create_autocmd("Bufread", {
    group = "KeepLastPos",
    pattern = "*",
    callback = function ()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd("normal g`\"zz")
        end
    end
})

