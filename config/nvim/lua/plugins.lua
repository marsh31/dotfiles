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

            { "hrsh7th/cmp-nvim-lsp" }, --, event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lua", event = { "InsertEnter" } },

            { "hrsh7th/cmp-nvim-lsp-document-symbol", event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lsp-signature-help", event = { "InsertEnter" } },
            { "onsails/lspkind-nvim" },

            { "saadparwaiz1/cmp_luasnip", event = { "InsertEnter" } },
            { "L3MON4D3/LuaSnip" },
        },
        wants = {
            "lspkind-nvim",
            "LuaSnip",
        },
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind =
                        require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                        return kind
                    end,
                },
                mapping = {
                    ["<C-x><C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "s" }),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            cmp.complete()
                        end
                    end, { "i", "s" }),

                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            cmp.complete()
                        end
                    end, { "i", "s" }),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable(-1) then
                            luasnip.jump(-1)
                        elseif cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
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

    -- @treesitter
    use({ -- nvim-treesitter
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
            { "Dkendal/nvim-treeclimber" },

            -- colorscheme
            { "sainnhe/everforest" },
            { "bluz71/vim-nightfly-guicolors" },
            { "navarasu/onedark.nvim" },
            { "folke/tokyonight.nvim" },
            { "catppuccin/nvim" },
            { "rebelot/kanagawa.nvim" },
            { "christianchiarulli/nvcode-color-schemes.vim" },
            { "EdenEast/nightfox.nvim" },
            { "projekt0n/github-nvim-theme" },
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

    -- @outline
    use({
        "stevearc/aerial.nvim",
        requires = {
            { "nvim-telescope/telescope.nvim" },
        },
        wants = {
            "telescope.nvim",
        },
        config = function()
            require("aerial").setup()
            require("telescope").load_extension("aerial")
        end,
    })
    use({ "simrat39/symbols-outline.nvim" })

    -- @fuzzyfinder
    use({ -- telescope.nvim
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },

            -- other plugins
            { "nvim-telescope/telescope-ghq.nvim" },
        },
        config = function()
            require("telescope").setup()
            require("telescope").load_extension("ghq")
        end,
    })

    -- @search
    use({ -- nvim-hlslens
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup()
        end,
    })

    -- @git
    use({ -- gitsigns.nvim
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signcolumn = false,
                numhl = true,
            })
        end,
    })
    use({ -- neogit
        "TimUntersberger/neogit",
        cmd = "Neogit",
    })
    use({ -- vgit.nvim
        "tanvirtin/vgit.nvim",
        config = function()
            require("vgit").setup({
                settings = {

                },
            })
        end,
    })
    use({ "sindrets/diffview.nvim" })

    -- @foldtext
    use({ -- pretty-fold.nvim
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

        config = function()
            require("nvim-tree").setup({})
        end,
    })

    -- @edit
    use({ -- vim-partedit
        "thinca/vim-partedit",
        config = function()
            vim.g["partedit#opener"] = "vsplit"

            -- prefix
            -- filetype
        end,
    })
    use({ -- winresizer
        "simeji/winresizer",
        -- cmd :WinResizerStartResize
        config = function()
            vim.g.winresizer_start_key = "<C-w><C-e>"
            vim.g.winresizer_vert_resize = 10
            vim.g.winresizer_horiz_resize = 5
        end,
    })
    use({ -- nvim-surround
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                keymaps = {
                    -- normal add
                    normal = "sa", -- general operation
                    normal_cur = "sas", -- line
                    normal_line = "sA", -- general operation, insert new line.
                    normal_cur_line = "sAS", -- line, and insert new line.

                    delete = "sd",
                    change = "sc",

                    insert = "<C-g>s",
                    insert_line = "<C-g>S",

                    visual = "S",
                    visual_line = "gS",
                },
            })
        end,
    })
    use({ -- nvim-autopairs
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                disable_filetype = { "TelescopePrompt" },
            })

            local rule = require("nvim-autopairs.rule")
            local npairs = require("nvim-autopairs")

            -- ... add rules ...
        end,
    })
    use({ -- Comment.nvim
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })
    use({ -- auto-session
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                -- :SaveSession, :RestoreSession, :DeleteSession
                auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
            })
        end,
    })

    -- @keyassistant
    use({ -- which-key
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                plugins = {
                    registers = false,
                },
            })
        end,
    })
    use({ "mrjones2014/legendary.nvim", wants = { "telescope", "dressing" } })

    -- @statusline
    use({ -- lualine.nvim
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                },
                extensions = {
                    "nvim-tree",
                    "quickfix",
                },
            })
        end,
    })

    -- @tabline
    use({ "nanozuki/tabby.nvim" })

    -- @startup
    use({ -- alpha-nvim
        "goolord/alpha-nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local alpha = require("alpha")
            local startify = require("alpha.themes.startify")

            alpha.setup(startify.config)
        end,
    })
    use({ "ahmedkhalf/project.nvim" })

    -- @motion
    use({ -- neoscroll.nvim
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    })
    use({ -- hop.nvim
        "phaazon/hop.nvim",
    })

    -- @hex
    use({ "RaafatTurki/hex.nvim" })

    -- @notify
    --     use({ -- noice.nvim
    --         "folke/noice.nvim",
    --         requires = {
    --             "MunifTanjim/nui.nvim",
    --             "rcarriga/nvim-notify",
    --         },
    --         config = function()
    --             require("noice").setup({
    --                 lsp = {
    --                     override = {
    --                         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                         ["vim.lsp.util.stylize_markdown"] = true,
    --                         ["cmp.entry.get_documentation"] = true,
    --                     },
    --                     signature = {
    --                         enabled = false,
    --                     },
    --                 },
    --
    --                 presets = {
    --                     bottom_search = true,
    --                     command_palette = true,
    --                     long_message_to_split = true,
    --                     inc_rename = false,
    --                     lsp_doc_border = true,
    --                 },
    --             })
    --         end,
    --     })
end)

-- vim: sw=4 sts=4 expandtab fenc=utf-8
