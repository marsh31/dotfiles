-- NAME:   statusline.lua
-- AUTHOR: marsh
-- NOTE:
--

return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "FocusLost", "BufRead", "BufNewFile" },
        config = function()
            local overseer = require("overseer")

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
                    lualine_x = {
                        -- {
                        --     "overseer",
                        --     label = "",
                        --     colored = true,
                        --     symbols = {
                        --         [overseer.STATUS.FAILURE] = "F:",
                        --         [overseer.STATUS.CANCELED] = "C:",
                        --         [overseer.STATUS.SUCCESS] = "S:",
                        --         [overseer.STATUS.RUNNING] = "R:",
                        --     },
                        --     unique = false,
                        --     name = nil,
                        --     name_not = nil,
                        --     status = nil,
                        --     status_not = false,
                        -- },
                        require("auto-session.lib").current_session_name,
                        "searchcount",
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                winbar = {},
                inactive_winbar = {},
                extensions = {
                    "nvim-tree",
                    "quickfix",
                },
            })
        end,
    },
}
