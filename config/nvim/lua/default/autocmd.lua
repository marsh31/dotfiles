--
-- Command window
--
-- https://zenn.dev/vim_jp/articles/2022-vim-advent-calender-cmdwin?redirected=1

local function augroup(name)
    return vim.api.nvim_create_augroup("my_config_" .. name, { clear = true })
end

-- disable ime japanese to english when leave insert mode.
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     group = augroup("leave_insert_with_disable_ime"),
--     pattern = { "*" },
--     command = "DisableIME",
-- })

-- validate file name on save.
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("on_save"),
    pattern = { "*" },
    callback = function()
        local filename = vim.fn.expand("<afile>:p")

        local invalid_chars = "!&()[]{}<>^:;'\",`~?|"
        for i = 1, #invalid_chars do
            local char = string.sub(invalid_chars, i, i)
            local res = string.find(filename, char, 1, true)

            if res then
                error("Filename has invalid char: ", filename)
            end
        end
    end,
})

-- options when enter the command window.
vim.api.nvim_create_autocmd("CmdwinEnter", {
    group = augroup("cmd_win"),
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = true
        vim.opt_local.signcolumn = "no"

        vim.api.nvim_command("startinsert")
    end,
})

-- keep last position
vim.api.nvim_create_autocmd("Bufread", {
    group = augroup("keep_last_pos"),
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd('normal g`"zz')
        end
    end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_augroup("GrepCmd", {})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    group = "GrepCmd",
    pattern = { "vimgrep,grep,grepadd" },
    callback = function()
        if vim.fn.len(vim.fn.getqflist()) ~= 0 then
            vim.api.nvim_command("botright copen")
        end
    end,
})
