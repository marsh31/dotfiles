------------------------------------------------------------
-- AUTHOR: marsh
--
-- Completion and Snippet config file for lua settings.
--
-- NOTE: plugins
--
--  * Completion
--  - 'hrsh7th/cmp-nvim-lsp'
--  - 'hrsh7th/cmp-buffer'
--  - 'hrsh7th/cmp-path'
--  - 'hrsh7th/cmp-cmdline'
--  - 'hrsh7th/nvim-cmp'
--  -
--
--  * Snippet
--  - 'L3MON4D3/LuaSnip'
--  - 'saadparwaiz1/cmp_luasnip'
------------------------------------------------------------
local cmp = require'cmp'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local ctrlp = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif has_words_before() then
        cmp.complete()
    else
        fallback()
    end
end


-- ## Completion
require'cmp'.setup({
    -- mappings
    mapping = {
        -- snippets
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            else
                fallback()
            end
        end, { "i", "s" }),


        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            else
                fallback()
            end
        end, { "i", "s" }),


        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),


        ["<C-p>"] = cmp.mapping({
            i = ctrlp,
            s = ctrlp,
        }),

        ['<C-k>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end
        }),
    },

    
    -- snippets
    snippet = {
        expand = function(args)
            -- require'luasnip'.lsp_expand(args.body)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },

    -- sources = cmp.config.sources({
    --     { name = 'nvim_lsp' },
    --     -- { name = 'luasnip' }, -- For luasnip users.
    --     -- { name = 'snippy' }, -- For snippy users.
    --     -- { name = 'ultisnips' }, -- For ultisnips users.
    -- }, {
    -- }, {
    --     { name = 'buffer' },
    --     { name = 'path' },
    --     { name = 'vsnip' }, -- For vsnip users.
    --     -- { name = 'cmp-nvim-lua' },
    -- })
    sources = {
        { name = 'vsnip' },
    },
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    -- mapping = cmp.mapping.preset.cmdline(),
    completion = {
        autocompletion = false
    },
    sources = {
        { name = 'path' },
        { name = 'cmdline' },
    }
})


-- vim: sw=4 sts=4 expandtab fenc=utf-8
