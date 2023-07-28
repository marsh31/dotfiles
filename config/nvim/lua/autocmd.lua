--
-- Command window
--
-- https://zenn.dev/vim_jp/articles/2022-vim-advent-calender-cmdwin?redirected=1


local function augroup(name)
  return vim.api.nvim_create_augroup("my_config_" .. name, { clear = true })
end


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
    callback = function ()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.cmd("normal g`\"zz")
        end
    end
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
