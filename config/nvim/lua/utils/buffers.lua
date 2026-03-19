M = {}

---return parent path of current buffer
---@return string | nil fullpath parent path of current buffer if the path was exists.
M.parent = function()
    local parent = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(parent) == true then
        return parent
    end
    return nil
end



---return filetype
---@return string filetype filetype
M.filetype = function()
    return vim.bo.filetype
end

return M
