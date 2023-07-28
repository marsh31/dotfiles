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

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
            { "hrsh7th/cmp-cmdline", event = { "InsertEnter" } },
            { "hrsh7th/cmp-path", event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lsp" }, --, event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lua", event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lsp-document-symbol", event = { "InsertEnter" } },
            { "hrsh7th/cmp-nvim-lsp-signature-help", event = { "InsertEnter" } },
            { "onsails/lspkind-nvim" },
            { "windwp/nvim-autopairs" },

            { "saadparwaiz1/cmp_luasnip", event = { "InsertEnter" } },
            { "L3MON4D3/LuaSnip" },
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

                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if luasnip.expandable() then
                            luasnip.expand()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
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
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "nvim_lua" },
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

            local rule = require("nvim-autopairs.rule")
            local npairs = require("nvim-autopairs")

            -- ... add rules ...
        end,
    },
    {
        "RaafatTurki/hex.nvim",
        cmd = "HexToggle",
        config = function()
            require("hex").setup()
        end,
    },

    {
        "junegunn/vim-easy-align",
    },
}

-- vim: sw=4 sts=4 expandtab fenc=utf-8
