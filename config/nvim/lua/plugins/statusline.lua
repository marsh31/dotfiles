-- NAME:   statusline.lua
-- AUTHOR: marsh
-- NOTE:
--

return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "FocusLost", "BufRead", "BufNewFile" },
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = { "dashboard", "alpha" },
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    refresh = {
                        statusline = 300,
                        tabline = 300,
                        winbar = 300,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "searchcount", "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                -- tabline = {
                --     lualine_a = {},
                --     lualine_b = { { "tabs", mode = 2 } },
                --     lualine_c = {},
                --     lualine_x = {},
                --     lualine_y = { { "windows", mode = 2 } },
                --     lualine_z = {},
                -- },
                winbar = {},
                inactive_winbar = {},
                extensions = {
                    "nvim-tree",
                    "quickfix",
                },
            })
        end,
    },
    -- {
    --     "romgrk/barbar.nvim",
    --     enabled = false,
    --     dependencies = {
    --         "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    --         "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    --     },
    --     init = function ()
    --       vim.g.barbar_auto_setup = false
    --     end,
    --     config = function ()
    --       require("bufferline").setup({
    --
    --       })
    --     end
    -- },
}
