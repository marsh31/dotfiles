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
-- lua:
-- https://zenn.dev/slin/articles/2020-11-03-neovim-lua2#ex%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89
-- https://github.com/nanotee/nvim-lua-guide
--
--
-- packer.nvim:
-- https://github.com/wbthomason/packer.nvim
--
-- https://qiita.com/delphinus/items/8160d884d415d7425fcc
--
-- https://qiita.com/delphinus/items/fb905e452b2de72f1a0f
--
--
-- plugin:
-- https://github.com/folke/noice.nvim
-- https://github.com/Shatur/neovim-session-manager
--
--

vim.cmd.packadd("packer.nvim")
return require("packer").startup(function(use)
    -- @package_manager
    use({ "wbthomason/packer.nvim", opt = true })

    -- @framework
    use({ "nvim-lua/plenary.nvim" })
    use({ "nvim-tree/nvim-web-devicons" })
    use({ "nvim-lua/popup.nvim" })
    use({ "MunifTanjim/nui.nvim" })
    use({ "rcarriga/nvim-notify" })

    -- @lsp
    use({ -- lspconfig
        "neovim/nvim-lspconfig",
        requires = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },
            { "jayp0521/mason-null-ls.nvim" },
            { "tami5/lspsaga.nvim" },
            { "j-hui/fidget.nvim" },
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
            require("lspsaga").setup({
                code_action_prompt = {
                    virtual_text = false,
                }
            })
            require("dressing").setup()
            require("fidget").setup()

            mason.setup()

            --
            -- lsp
            --
            mason_lspconfig.setup({
                ensure_installed = {
                    -- lsp
                    "bashls",                   -- bash
                    "clangd",                   -- clang
                    "dockerls",                 -- docker
                    "dotls",                    -- dot
                    "sumneko_lua",              -- lua
                    "gopls",                    -- go
                    "html",                     -- html
                    "jsonls",                   -- json
                    "tsserver",                 -- javascript/typescript
                    "rust_analyzer",            -- rust
                    "sqls",                     -- sql
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
                                    signs = false,
                                }
                            ),
                        },
                    }

                    lsp_config[server_name].setup(opts)
                end,


                ["sumneko_lua"] = function ()
                    lsp_config.sumneko_lua.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    })
                end
            })

            mason_null_ls.setup({
                ensure_installed = {
                    "stylua",
                    "jq",
                },
                automatic_installation = true,
                automatic_setup = true,
            })
            -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                },
            })
        end,
    })

    use({ -- lsp_signature
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({
                hint_enable = false,
            })
        end,
    })
    use({ "stevearc/dressing.nvim" })
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
            local types = require("luasnip.util.types")
            luasnip.config.setup({
                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { " ⮃", "Repeat" } },
                        },
                    },
                    [types.insertNode] = {
                        active = {
                            virt_text = { { " ⮄", "Keyword" } },
                        },
                    },
                },
            })

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

                    ["<C-e>"] = cmp.mapping(function(fallback)
                        if luasnip.choice_active() then
                            luasnip.change_choice(1)
                        else
                            fallback()
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
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                            -- elseif cmp.visible() then
                            --     cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                            -- elseif cmp.visible() then
                            --     cmp.select_prev_item()
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
                    -- { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
            })

            -- ~/.config/nvim/lua/snippets/init.lua
            require("snippets")
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
    use({ -- aerial
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
        disable = true,
        config = function()
            require("vgit").setup({
                settings = {},
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
    use({ -- vim-qfreplace
        "thinca/vim-qfreplace",
        cmd = "Qfreplace",
    })
    use({ -- QFGrep
        "sk1418/QFGrep",
        ft = { "qf" },
        -- keymap: <leader>g, <leader>v, <leader>r
    })

    -- @filer
    use({ -- nvim-tree.lua
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },

        config = function()
            local lib = require("nvim-tree.lib")
            local view = require("nvim-tree.view")

            local function collapse_all()
                require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
            end

            local function edit_or_open()
                local action = "edit"
                local node = lib.get_node_at_cursor()

                if node.link_to and node.nodes then
                    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
                    view.close()
                elseif node.nodes ~= nil then
                    lib.expand_or_collapse(node)
                else
                    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
                    view.close()
                end
            end

            local function vsplit_preview()
                local action = "vsplit"
                local node = lib.get_node_at_cursor()

                if node.link_to and not node.nodes then
                    require("nvim-tree.action.node.open-file").fn(action, node.link_to)
                elseif node.nodes ~= nil then
                    lib.expand_or_collapse(node)
                else
                    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
                end

                view.focus()
            end

            require("nvim-tree").setup({
                view = {
                    width = 20,
                    mappings = {
                        custom_only = true,
                        list = {
                            { key = { "<CR>", "o" }, action = "edit" },
                            { key = "<C-e>", action = "edit_in_place" },
                            { key = "O", action = "edit_no_picker" },
                            { key = "<C-]>", action = "cd" },

                            { key = "l", action = "edit", action_cb = edit_or_open },
                            { key = "h", action = "close_node" },
                            { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                            { key = "H", action = "collapse_all", action_cb = collapse_all },

                            { key = "<C-v>", action = "vsplit" },
                            { key = "<C-x>", action = "split" },
                            { key = "<C-t>", action = "tabnew" },

                            { key = "<", action = "prev_sibling" },
                            { key = ">", action = "next_sibling" },
                            { key = "P", action = "parent_node" },
                            { key = "<BS>", action = "close_node" },
                            { key = "<Tab>", action = "preview" },
                            { key = "K", action = "first_sibling" },
                            { key = "J", action = "last_sibling" },
                            { key = "C", action = "toggle_git_clean" },
                            { key = "I", action = "toggle_git_ignored" },
                            { key = "H", action = "toggle_dotfiles" },
                            { key = "B", action = "toggle_no_buffer" },
                            { key = "U", action = "toggle_custom" },
                            { key = "R", action = "refresh" },
                            { key = "a", action = "create" },
                            { key = "d", action = "remove" },
                            { key = "D", action = "trash" },
                            { key = "r", action = "rename" },
                            { key = "<C-r>", action = "full_rename" },
                            { key = "e", action = "rename_basename" },
                            { key = "x", action = "cut" },
                            { key = "c", action = "copy" },
                            { key = "p", action = "paste" },
                            { key = "y", action = "copy_name" },
                            { key = "Y", action = "copy_path" },
                            { key = "gy", action = "copy_absolute_path" },
                            { key = "[e", action = "prev_diag_item" },
                            { key = "[c", action = "prev_git_item" },
                            { key = "]e", action = "next_diag_item" },
                            { key = "]c", action = "next_git_item" },
                            { key = "-", action = "dir_up" },
                            { key = "s", action = "system_open" },
                            { key = "f", action = "live_filter" },
                            { key = "F", action = "clear_live_filter" },
                            { key = "q", action = "close" },
                            { key = "W", action = "collapse_all" },
                            { key = "E", action = "expand_all" },
                            { key = "S", action = "search_node" },
                            { key = ".", action = "run_file_command" },
                            { key = "<C-k>", action = "toggle_file_info" },
                            { key = "g?", action = "toggle_help" },
                            { key = "m", action = "toggle_mark" },
                            { key = "bmv", action = "bulk_move" },
                        },
                    },
                },

                filters = {
                    custom = {
                        "^.git$",
                    },
                },

                renderer = {
                    indent_markers = {
                        enable = true,
                    },
                },
            })
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

                -- ... fast wrap ...
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                    end_key = "$",
                    keys = "qwertyuiiopzxcvnmasdfghkl",
                    check_comma = true,
                    highlight = "Search",
                    highligh_grey = "Comment",
                },
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
            -- require("auto-session").setup({
            --     -- :SaveSession, :RestoreSession, :DeleteSession
            --     -- auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
            -- })
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
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
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
                tabline = {
                    lualine_a = {},
                    lualine_b = { { "tabs", mode = 2 } },
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = { { "windows", mode = 2 } },
                    lualine_z = {},
                },
                winbar = {},
                inactive_winbar = {},
                extensions = {
                    "nvim-tree",
                    "quickfix",
                },
            })
        end,
    })

    -- @startup
    use({ -- alpha-nvim
        "goolord/alpha-nvim",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local alpha = require("alpha")
            local theme = require("alpha.themes.dashboard")

            alpha.setup(theme.config)
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
        config = function()
            local hop = require("hop")
            hop.setup({
                keys = "asdfqwerzxcv",
            })
        end,
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
