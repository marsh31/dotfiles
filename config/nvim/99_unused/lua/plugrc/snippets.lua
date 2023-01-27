-- # Snippet
-- ref: https://github.com/L3MON4D3/LuaSnip/wiki
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})

ls.snippets = {
    -- all         = require('plugrc.luasnippets.all'),
    all = {
        s({trig = "fullpath"}, {
            f(function(args, snip, user_arg_1)
                local fullpath = vim.api.nvim_buf_get_name('$')
                return fullpath
            end,
            {1},
            {}),
            i(1),
        }),
    },
    -- c           = require('plugrc.luasnip.c'),
    -- html        = require('plugrc.luasnip.html'),
    -- http        = require('plugrc.luasnip.http'),
    -- javascript  = require('plugrc.luasnip.javascript'),
    lua         = require('plugrc.luasnippets.lua'),
    -- python      = require('plugrc.luasnip.python3'),
    -- rust        = require('plugrc.luasnip.rust'),
    -- sh          = require('plugrc.luasnip.sh'),
    -- vim         = require('plugrc.luasnip.vim'),
}

