-- NAME:   lua/default/plugins/gitsigns.lua
-- AUTHOR: marsh
-- NOTE:
--
--

local keyset = vim.keymap.set

---get pluging keymapping name
---@param plugin string #pluginname
---@param key string    #keymap name
---@return string       #keymapping name
local function get_plug_key(plugin, key)
    return string.format("<Plug>(%s:%s)", plugin, key)
end

return {
    {
        "lewis6991/gitsigns.nvim",
        cond = false,
        config = function()
            local gitsigns = require("gitsigns")
            gitsigns.setup({
                signcolumn = false,
                numhl = true,
            })
            keyset("n", "<leader>hs", gitsigns.stage_hunk)
            keyset("n", "<leader>hr", gitsigns.reset_hunk)

            keyset("v", "<leader>hs", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end)
            keyset("v", "<leader>hr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end)

            keyset("n", "<leader>hS", gitsigns.stage_buffer)
            keyset("n", "<leader>hu", gitsigns.undo_stage_hunk)
            keyset("n", "<leader>hR", gitsigns.reset_buffer)
            keyset("n", "<leader>hp", gitsigns.preview_hunk)
            keyset("n", "<leader>hb", function()
                gitsigns.blame_line({ full = true })
            end)

            keyset("n", "<leader>tb", gitsigns.toggle_current_line_blame)
            keyset("n", "<leader>hd", gitsigns.diffthis)
            keyset("n", "<leader>hD", function()
                gitsigns.diffthis("~")
            end)
            keyset("n", "<leader>td", gitsigns.toggle_deleted)
        end,
    },
}
