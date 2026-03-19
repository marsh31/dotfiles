-- NAME:   moveblock/init.lua
-- AUTHOR: marsh
--
-- NOTE:
--
--

local M = {}

local function cut_visual_selection()
    -- Visual範囲の取得
    local _, start_row, start_col = unpack(vim.fn.getpos("'<"))
    local _, end_row, end_col = unpack(vim.fn.getpos("'>"))

    start_row = start_row - 1
    end_row = end_row - 1

    if start_row == -1 or end_row == -1 then
        vim.notify("No selection")
        return nil
    end

    local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
    if #lines > 0 then
        lines[1] = string.sub(lines[1], start_col + 1)
        lines[#lines] = string.sub(lines[#lines], 1, end_col)
    end

    vim.api.nvim_buf_set_lines(0, start_row, end_row + 1, false, {})
    return lines
end

local function insert_lines_at_cursor(lines)
    local bufnr = vim.api.nvim_get_current_buf()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

    row = row - 1
    vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
end

M.get_selection = cut_visual_selection
M.set_lines = insert_lines_at_cursor

M.new_buffer = function()
    local lines = M.get_selection()
    vim.cmd("Zopen Fleeting")
    M.set_lines(lines)
end

return M
