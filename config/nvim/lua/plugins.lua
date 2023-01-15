--
-- NAME:   lua/plugins.lua
-- AUTHOR: marsh
-- NOTE:
--
--   Using packer.nvim as package manager.
-- If you add package, do `:PackerInstall` to install package.
-- And after that, do `:PackerCompile` to compile package.
--
--   packer.nvim has 2 type of plugn.
-- 1. start plugins. load in start time.
-- 2. opt plugin. lazy load using packadd.
--
--
-- packer.nvim:
-- https://qiita.com/delphinus/items/8160d884d415d7425fcc
--
-- https://qiita.com/delphinus/items/fb905e452b2de72f1a0f
--

-- vim.cmd [[packadd packer.nvim]]
vim.cmd.packadd("packer.nvim")
return require("packer").startup(function(use)
    -- @package_manager
    use({ "wbthomason/packer.nvim", opt = true })

    -- @framework
    use({ "nvim-lua/plenary.nvim" })
    use({ "nvim-tree/nvim-web-devicons" })

    -- @lsp
    use({ -- lspconfig
        "neovim/nvim-lspconfig",
        requires = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        wants = {
            "mason.nvim",
            "mason-lspconfig.nvim",

            "cmp-nvim-lsp",
        },
        config = function()
            local lsp_config = require("lspconfig")

            -- installer
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            -- linter and formatter
            local mason_null_ls = require("mason-null-ls")
            local null_ls = require("null-ls")

            -- other
            require("lspsaga").setup()
            -- require('lspkind-nvim').init({ ... })
            require("lsp_signature").setup({ hint_enable = false })
            require("dressing").setup()
            require("fidget").setup()

            mason.setup()

            --
            -- lsp
            --
            mason_lspconfig.setup({
                ensure_installed = {
                    "sumneko_lua",
                },

                automatic_installation = true,
            })

            mason_lspconfig.setup_handlers({
                function(server_name)
                    local opts = {
                        -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),

                        handlers = {
                            ["textDocument/publishDiagnostics"] = vim.lsp.with(
                                vim.lsp.diagnostic.on_publish_diagnostics,
                                {
                                    virtual_text = false,
                                }
                            ),
                        },
                    }

                    lsp_config[server_name].setup(opts)
                end,
            })

            --
            -- linter and formatter
            --   null-ls
            --
            mason_null_ls.setup({
                ensure_installed = {
                    "stylua",
                    "jq",
                },
                automatic_installation = true,
            })

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                },
            })
        end,
    })
    use({ "jose-elias-alvarez/null-ls.nvim" }) -- linter and formatter
    use({ "jayp0521/mason-null-ls.nvim" }) -- linter and formatter

    use({ "tami5/lspsaga.nvim" })
    -- use({ "onsails/lspkind-nvim" })
    use({
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup()
        end,
    })
    use({ "stevearc/dressing.nvim" })
    use({ "j-hui/fidget.nvim" })

    use({ "folke/trouble.nvim" })

    -- @complete
    use({ -- nvim-cmp
        "hrsh7th/nvim-cmp",
        module = { "cmp" },
        requires = {
            { "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
            { "hrsh7th/cmp-cmdline", event = { "InsertEnter" } },
            { "hrsh7th/cmp-path", event = { "InsertEnter" } },

            { "hrsh7th/cmp-nvim-lsp" }, -- event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lua", event = { "InsertEnter" } },

            { "hrsh7th/cmp-nvim-lsp-document-symbol", event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lsp-signature-help", event = { "InsertEnter" } },
        },
        config = function()
            local lsp_config = require("lspconfig")
            local lspkind = require("lspkind")
            local cmp = require("cmp")

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    local opts = {
                        -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),

                        handlers = {
                            ["textDocument/publishDiagnostics"] = vim.lsp.with(
                                vim.lsp.diagnostic.on_publish_diagnostics,
                                {
                                    virtual_text = false,
                                }
                            ),
                        },
                    }

                    lsp_config[server_name].setup(opts)
                end,
            })

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
                mapping = {
                    ["<C-k>"] = cmp.mapping(cmp.mapping.complete(), { "i", "s" }),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            cmp.complete()
                            -- elseif has_words_before() then
                            --     cmp.complete()
                            -- else
                            --     fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            cmp.complete()
                            -- elseif has_words_before() then
                            --     cmp.complete()
                            -- else
                            --     fallback()
                        end
                    end, { "i", "s" }),

                    ["<CR>"] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                    }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "buffer" },
                },
            })

            require("modules/lsp")
        end,
    })

    -- @colorscheme
    use({ "sainnhe/everforest", opt = true })
    use({ "bluz71/vim-nightfly-guicolors", opt = true })
    use({ "christianchiarulli/nvcode-color-schemes.vim", opt = true })
    use({ "projekt0n/github-nvim-theme", opt = true })

    -- @treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = [[:TSUpdate]],
        requires = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "RRethy/nvim-treesitter-textsubjects" },
            { "mfussenegger/nvim-treehopper" },
            { "David-Kunz/treesitter-unit" },

            { "yioneko/nvim-yati" },
            { "nvim-treesitter/nvim-treesitter-refactor" },
            { "theHamsta/nvim-treesitter-pairs" },
            { "p00f/nvim-ts-rainbow" },
        },
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = "all",
                highlight = {
                    enable = true,
                    disable = { "markdown" },
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
            vim.cmd.colorscheme([[gruvbox]])
        end,
    })

    -- @fuzzyfinder
    use({
        "nvim-telescope/telescope.nvim",

        requires = {
            { "nvim-lua/plenary.nvim" },

            -- other plugins
            { "nvim-telescope/telescope-ghq.nvim", opt = true },
        },

        wants = {
            "telescope-ghq.nvim",
        },

        setup = function()
            local function builtin(name)
                return function(opt)
                    return function()
                        return require("telescope.builtin")[name](opt or {})
                    end
                end
            end

            local function extensions(name, prop)
                return function(opt)
                    return function()
                        local telescope = require("telescope")
                        telescope.load_extension(name)
                        return telescope.extensions[name][prop](opt or {})
                    end
                end
            end

            vim.keymap.set("n", "<Leader>f:", builtin("command_history"), {})
            vim.keymap.set("n", "<Leader>fg", builtin("grep_string"), {})
            vim.keymap.set("n", "<Leader>fq", extensions("ghq", "list"), {})
        end,
        config = function()
            require("telescope").setup()

    -- @search
    use({ -- nvim-hlslens
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup()
        end,
    })

    -- @git
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup {
                signcolumn = false,
                numhl = true,
            }
        end
    })

    -- @foldtext
    use({
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("pretty-fold").setup({
                sections = {
                    left = {
                        "content",
                    },
                    right = {
                        " ",
                        "number_of_folded_lines",
                        ": ",
                        "percentage",
                        " ",
                        function(config)
                            return config.fill_char:rep(3)
                        end,
                    },
                },
                fill_char = "•",

                remove_fold_markers = false,

                -- Keep the indentation of the content of the fold string.
                keep_indentation = true,

                -- Possible values:
                -- "delete" : Delete all comment signs from the fold string.
                -- "spaces" : Replace all comment signs with equal number of spaces.
                -- false    : Do nothing with comment signs.
                process_comment_signs = "spaces",

                -- Comment signs additional to the value of `&commentstring` option.
                comment_signs = {},

                -- List of patterns that will be removed from content foldtext section.
                stop_words = {
                    "@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
                },

                add_close_pattern = true, -- true, 'last_line' or false

                matchup_patterns = {
                    { "{", "}" },
                    { "%(", ")" }, -- % to escape lua pattern char
                    { "%[", "]" }, -- % to escape lua pattern char
                },

                ft_ignore = { "neorg" },
            })
        end,
    })

    -- @quickfix
    -- use({ -- nvim-bqf
    --     "kevinhwang91/nvim-bqf",
    --
    --     -- lazyload
    --     ft = { "qf" },
    --
    --     -- config
    --     config = function()
    --         require("bqf").setup({
    --             preview = {
    --                 win_height = 7,
    --                 win_vheight = 7,
    --             },
    --         })
    --     end,
    -- })
    -- use({ -- qf_helper.nvim
    --     "stevearc/qf_helper.nvim",
    -- })
    -- use({ -- vim-qfreplace
    --     "thinca/vim-qfreplace",
    --     cmd = "Qfreplace",
    -- })
    -- use({ "sk1418/QFGrep" })
    -- use({ "gabrielpoca/replacer.nvim" })

    -- @filer
    use({ -- nvim-tree.lua
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },

    -- @statusline
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                },
            })
        end,
    })
end)

-- vim: sw=4 sts=4 expandtab fenc=utf-8
