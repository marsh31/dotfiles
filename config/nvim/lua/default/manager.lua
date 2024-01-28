-- NAME:   manager.lua
-- AUTHOR: marsh
-- NOTE:
--

local M = {}

local function init_lazy_nvim(path)
    if not vim.loop.fs_stat(path) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            path,
        })
    end
    vim.opt.rtp:prepend(path)
end

M.setup = function()
    local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    init_lazy_nvim(path)
end

M.load_plugins = function(plugins)
    require('lazy').setup(plugins)
end


M.update_plugins = function ()
    vim.fn.execute("Lazy update")
    vim.fn.execute("TSUpdate")
end

return M
