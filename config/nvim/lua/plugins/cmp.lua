-- NAME:   coding.lua
-- AUTHOR: marsh
-- NOTE:
--
--

local run_luasnip = true
local run_skkeleton = false
local run_cmp = true

return {
    {
        "L3MON4D3/LuaSnip",
        cond = run_luasnip,
        tag = "2.*",
        build = "make install_jsregexp",
        config = function()
            local luasnip = require("luasnip")
            local types = require("luasnip.util.types")

            luasnip.config.setup({
                history = true,
                delete_check_events = "TextChanged,TextChangedI",
                ext_opts = {
                    [types.choiceNode] = {
                        active = {
                            virt_text = { { " ", "Repeat" } },
                        },
                    },
                    [types.insertNode] = {
                        active = {
                            virt_text = { { " ", "Keyword" } },
                        },
                    },
                },
            })
        end,
    },

    {
        "vim-skk/skkeleton",
        cond = run_skkeleton,
        dependencies = {
            "vim-denops/denops.vim",
        },
        config = function()
            vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(skkeleton-toggle)", { noremap = true })
            vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(skkeleton-toggle)", { noremap = true })

            local function init()
                -- table.insert(vim.g["skkeleton#mapped_keys"], '<C-v>')
                return vim.fn["skkeleton#config"]({
                    globalDictionaries = { "~/.SKK-JISYO.L" },
                    immediatelyDictionaryRW = true,
                    keepState = true,
                    selectCandidateKeys = "asdfjkl",
                    setUndoPoint = true,
                    showCandidatesCount = 4,
                    usePopup = true,
                    eggLikeNewline = true,
                    registerConvertResult = false,
                    userDictionary = "~/.skk-jisyo",
                })
            end

            local function enable_pre()
                local cmp = require("cmp")
                return cmp.setup.buffer({ view = { entries = "native" } })
            end

            local function disable_pre()
                local cmp = require("cmp")
                return cmp.setup.buffer({ view = { entries = "custom" } })
            end

            local group_5_auto = vim.api.nvim_create_augroup("init-skkeleton", { clear = true })
            vim.api.nvim_create_autocmd(
                { "User" },
                { callback = init, group = group_5_auto, pattern = "skkeleton-initialize-pre" }
            )
            vim.api.nvim_create_autocmd(
                { "User" },
                { callback = enable_pre, group = group_5_auto, pattern = "skkeleton-enable-pre" }
            )
            vim.api.nvim_create_autocmd(
                { "User" },
                { callback = disable_pre, group = group_5_auto, pattern = "skkeleton-disable-pre" }
            )

            vim.api.nvim_create_autocmd(
                { "User" },
                { command = "redrawstatus", group = group_5_auto, pattern = "skkeleton-mode-changed" }
            ) --
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        cond = run_cmp,
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-omni" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- 使うなら
            { "hrsh7th/cmp-nvim-lsp-document-symbol" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },

            { "saadparwaiz1/cmp_luasnip" },
            { "onsails/lspkind-nvim" },
            { "windwp/nvim-autopairs" },

            { "rinx/cmp-skkeleton", event = { "InsertEnter" } },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local defaults = require("cmp.config.default")()

            local ok_pairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
            if ok_pairs then
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                if col == 0 then
                    return false
                end
                local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
                return text:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                    keyword_length = 2,
                },
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
                        local kind = require("lspkind").cmp_format({
                            mode = "symbol_text",
                            maxwidth = 50,
                        })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                        return kind
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    -- { name = "skkeleton" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "omni" },
                    { name = "nvim_lua" },
                },
                sorting = defaults.sorting,
                -- experimental = {
                --     ghost_text = {
                --         hl_group = "CmpGhostText",
                --     },
                -- },
                mapping = {
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                            cmp.complete()
                        end
                    end, { "i", "s" }),

                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                        else
                            cmp.complete()
                        end
                    end, { "i", "s" }),

                    ["<C-b>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.scroll_docs(-4)
                        else
                            fallback()
                        end
                    end, { "i" }),

                    ["<C-f>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.scroll_docs(4)
                        else
                            fallback()
                        end
                    end, { "i" }),

                    ["<C-e>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        elseif luasnip.choice_active() then
                            luasnip.change_choice(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            cmp.complete({
                                config = {
                                    sources = {
                                        { name = "luasnip" },
                                    },
                                },
                            })
                            -- fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-l>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<CR>"] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                    }),
                },
            })

            -- filetypeごとの調整例 Omni / buffer
            cmp.setup.filetype({ "tex", "html" }, {
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "omni" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

            -- git commit
            cmp.setup.filetype({ "gitcommit" }, {
                sources = cmp.config.sources({
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

            -- markdown
            require("cmp.cmp_markdown_tags").setup()
            cmp.setup.filetype({ "markdown", "mdx" }, {
                sources = {
                    { name = "markdown_tags" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "omni" },
                },
            })

            -- cmdline 補完
            -- cmp.setup.cmdline({ "/", "?" }, {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = { { name = "buffer" } },
            -- })
            -- cmp.setup.cmdline(":", {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
            -- })

            -- ~/.config/nvim/lua/snippets/init.lua
            require("snippets")
        end,
    },
}

--
-- vim: sw=4 sts=4 expandtab fenc=utf-8
