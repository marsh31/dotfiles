-- NAME:   treesitter.lua
-- AUTHOR: marsh
-- NOTE:
--
--

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },

            { "RRethy/nvim-treesitter-textsubjects" },
            { "mfussenegger/nvim-treehopper" },
            { "David-Kunz/treesitter-unit" },

            { "yioneko/nvim-yati" },
            { "nvim-treesitter/nvim-treesitter-refactor" },
            { "theHamsta/nvim-treesitter-pairs" },
            { "p00f/nvim-ts-rainbow" },
            { "Dkendal/nvim-treeclimber" },
        },
        cmd = { "TSUpdateSync" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "awk",
                    "bash",
                    "c",
                    "cairo",
                    "cmake",
                    "comment",
                    "cpp",
                    "css",
                    "dart",
                    "diff",
                    "dockerfile",
                    "dot",
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "html",
                    "http",
                    "javascript",
                    "json",
                    "latex",
                    "lua",
                    "luadoc",
                    "luap",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "rust",
                    "scss",
                    "sql",
                    "todotxt",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "vue",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        node_decremental = "grm",
                        scope_incremental = "grc",
                    },
                },
                indent = { enable = false },

                refactor = {
                    highlight_definitions = { enable = false },
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
            })

            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

            -- vim.cmd.colorscheme([[kanagawa-dragon]])
            vim.cmd.colorscheme([[carbonfox]])
        end,
    },
}