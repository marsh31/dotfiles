-- NAME:   coding.lua
-- AUTHOR: marsh
-- NOTE:
--
--

return {
    {
        "L3MON4D3/LuaSnip",
        tag = "2.*",
        build = "make install_jsregexp",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },

    -- {
    --     "vim-skk/skkeleton",
    --     dependencies = {
    --         "vim-denops/denops.vim",
    --     },
    --     config = function()
    --         vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(skkeleton-toggle)", { noremap = true })
    --         vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(skkeleton-toggle)", { noremap = true })
    --         vim.api.nvim_exec(
    --             [[
    --             call skkeleton#config({
    --                 \  'globalJisyo': expand('/usr/share/skk/SKK-JISYO.L'),
    --                 \  'eggLikeNewline': v:true,
    --                 \ })
    --         ]],
    --             false
    --         )
    --     end,
    -- },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-buffer",                   event = { "InsertEnter" } },
            { "hrsh7th/cmp-cmdline",                  event = { "InsertEnter" } },
            { "hrsh7th/cmp-path",                     event = { "InsertEnter" } },
            { "hrsh7th/cmp-omni",                     event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lsp" }, --, event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lua",                 event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lsp-document-symbol", event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lsp-signature-help",  event = { "InsertEnter" } },
            { "onsails/lspkind-nvim" },
            { "windwp/nvim-autopairs" },

            { "saadparwaiz1/cmp_luasnip",             event = { "InsertEnter" } },
            { "L3MON4D3/LuaSnip" },

            -- { "rinx/cmp-skkeleton" },
        },
        config = function()
            local luasnip = require("luasnip")
            local types = require("luasnip.util.types")
            luasnip.config.setup({
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
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
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
                        local kind =
                            require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
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

            -- ~/.config/nvim/lua/snippets/init.lua
            require("snippets")
        end,
    },
    {
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

            local npairs = require("nvim-autopairs")
            local rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")

            -- npairs.add_rules({
            --     rule("\\begin{%w*} $", "tex")
            --         :replace_endpair(function(opts)
            --             local beforeText = string.sub(opts.line, 0, opts.col)
            --             local _, _, match = beforeText:find("\\begin(%w*)")
            --
            --             if match and #match > 0 then
            --                 return "\\end" .. match
            --             end
            --
            --             return ""
            --         end)
            --         :with_move(cond.none())
            --         :use_key("<space>")
            --         :use_regex(true),
            -- })

            -- ... add rules ...
        end,
    },
} -- vim: sw=4 sts=4 expandtab fenc=utf-8
