-- NAME:
-- AUTHOR: marsh
-- NOTE:
--
-- <C-n>/<Down>  Next item
-- <C-p>/<Up>    Previous item
-- j/k           Next/previous (in normal mode)
-- H/M/L         Select High/Middle/Low (in normal mode)
-- gg/G          Select the first/last item (in normal mode)
-- <CR>          Confirm selection
-- <C-x>         Go to file selection as a split
-- <C-v>         Go to file selection as a vsplit
-- <C-t>         Go to a file in a new tab
-- <C-u>         Scroll up in preview window
-- <C-d>         Scroll down in preview window
-- <C-/>         Show mappings for picker actions (insert mode)
-- ?             Show mappings for picker actions (normal mode)
-- <C-c>         Close telescope
-- <Esc>         Close telescope (in normal mode)
-- <Tab>         Toggle selection and move to next selection
-- <S-Tab>       Toggle selection and move to prev selection
-- <C-q>         Send all items not filtered to quickfixlist (qflist)
-- <M-q>         Send all selected items to qflist

return {
  { 
    "nvim-telescope/telescope-fzf-native.nvim", build = "make",
    cond = false,
  },
    {
        "nvim-telescope/telescope-frecency.nvim",
        cond = false,
        dependencies = {
            { "kkharji/sqlite.lua" },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        cond = false,
        dependencies = {
            { "nvim-lua/plenary.nvim" },

            -- other plugins
            { "nvim-telescope/telescope-ghq.nvim" },
            { "nvim-telescope/telescope-frecency.nvim" },
            { "LinArcX/telescope-command-palette.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim" },
            { "rmagatti/auto-session" },
        },
        cmd = { "Telescope" },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                },

                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ["<M-d>"] = actions.delete_buffer + actions.move_to_top,
                            },
                        },
                    },
                },

                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    command_palette = {
                        {
                            "File",
                            { "File explorer", ":Fern ." },
                            { "File selector", ":Telescope find_files" },
                        },
                        { "Help", { "Notify list", ":Telescope notify" } },
                    },
                },
            })

            local wk = require("which-key")
            wk.register({
                ["<C-p>"] = { "<cmd>Telescope command_palette<CR>", "command palette" },
            }, {
                mode = "n",
                prefix = "<Leader>f",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = false,
                expr = false,
            })
            wk.register({
                [" "] = { "<cmd>Telescope buffers<CR>", "Search buffers" },
                ["b"] = { "<cmd>Telescope buffers<CR>", "Search buffers" },
                ["f"] = { "<cmd>Telescope find_files hidden=true<CR>", "Search file" },
                ["g"] = { "<cmd>Telescope grep_string<CR>", "Grep" },
                ["h"] = { "<cmd>Telescope oldfiles<CR>", "Search Recent File" },
                ["o"] = { "<cmd>Telescope aerial<CR>", "Search Outline" },
                ["p"] = { "<cmd>Telescope command_palette<CR>", "command palette" },
                ["r"] = { "<cmd>Telescope ghq list<CR>", "Search git repo" },
                ["s"] = { "<cmd>Telescope session-lens<CR>", "Search sessions" },
            }, {
                mode = "n",
                prefix = "<Leader>f",
                buffer = nil,
                silent = true,
                noremap = true,
                nowait = false,
                expr = false,
            })

            require("telescope").load_extension("ghq")
            require("telescope").load_extension("frecency")
            require("telescope").load_extension("command_palette")
            require("telescope").load_extension("notify")
            require("telescope").load_extension("session-lens")
        end,
    },
}
