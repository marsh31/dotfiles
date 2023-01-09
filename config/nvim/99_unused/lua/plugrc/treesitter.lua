--=====================================
-- FILE:   lua/plugrc/treesitter.lua
-- AUTHOR: marsh
--
-- NOTE:
-- Config file for treesitter and colorscheme.
--
-- TODO: consider the keymap.
-- Current config is smaple keymap in README.
--=====================================


local configs = require('nvim-treesitter.configs')
configs.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        disable = { "markdown" },
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection    = "gnn",
            node_incremental  = "grn",
            node_decremental  = "grm",
            scope_incremental = "grc",
        },
    },
    indent = { enable = false },

    refactor = {
        highlight_definitions   = { enable = false },
        highlight_current_scope = { enable = false },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },

        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "gnu",
                goto_previous_usage = "gpu",
            },
        },
    },

    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
    },

    rainbow = {
        enable = true,
        extended_mode = true,
    },

    pairs = {
        enable = true,
        disable = {},
    },
}

-- require('github-theme').setup()

-- vim: sw=4 sts=2 expandtab fenc=utf-8
