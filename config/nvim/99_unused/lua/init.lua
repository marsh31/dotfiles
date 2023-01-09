------------------------------------------------------------
-- FILE:   lua/init.lua
-- AUTHOR: marsh
--
-- Initial config file for lua settings.
-- Load these files.
--  - ./plugrc/lsp.lua
--  - ./plugrc/editor.lua
--  - ./plugrc/comment.lua
--  - ./plugrc/completion.lua
--  - ./plugrc/treesitter.lua
--  - ./plugrc/luasnip/**.lua [luasnip snippet files]
------------------------------------------------------------

--  - ./plugrc/lsp.lua
require('plugrc.lsp')


--  - ./plugrc/completion.lua
require('plugrc.completion')
-- require('plugrc.snippets')
-- local luasnip = require'luasnip'
-- local cmp     = require'cmp'
-- cmp.setup {
--     snippet = {
--         expand = function(args)
--             require'luasnip'.lsp_expand(args.body)
--         end
--     },
--     mapping = {
--         ['<C-p>'] = cmp.mapping.select_prev_item(),
--         ['<C-n>'] = cmp.mapping.select_next_item(),
--         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-e>'] = cmp.mapping.close(),
--         ['<C-k>'] = cmp.mapping(function (fallback)
--             if luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),
--     },
-- 
--     sources = {
--         { name = 'luasnip' },
--         { name = 'buffer' },
--     },
-- }

-- local ls = require'luasnip'
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require'luasnip.util.events'
-- local ai = require'luasnip.nodes.absolute_indexer'
-- 
-- ls.snippets = {
--     all = {
--         s("trig1", {t("for all snippet")}),
--     },
--     lua = {
--         s( "trig2", { t("for lua snippet") } ),
--     },
-- }






-- load treesitter config.
-- - ./plugrc/treesitter.lua
require('plugrc.treesitter')


-- comment
--  - ./plugrc/comment.lua
require('plugrc.comment')


-- status line
require('lualine').setup()


-- file explorer
require('plugrc.filetree')


-- ./plugrc/editor.lua
require('plugrc.editor')


-- ./plugrc/lualine.lua
-- require('plugrc.indent')


-- vim: sw=4 sts=4 expandtab fenc=utf-8
