-- NAME:   lua/snippets/sh.lua
-- AUTHOR: marsh
-- NOTE:
--
--

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
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet


local snippets = {
    s("#!", {
        t("#!/"),
        i(1, "bin/bash"),
        i(0),
    }),
    s("#name", {
        t("# NAME:   "),
        d(1, function(args)
            local percent_echo = vim.api.nvim_exec("echo @%", true)
            return sn(nil, {
                i(1, percent_echo),
            })
        end),
    }),
    s("#author", {
        t("# AUTHOR: "),
        i(1, "marsh"),
        i(0),
    }),
    s("fn", {
        i(1, "fun_name"),
        t("() {"),
        t({ "", "\t" }),
        i(0),
        t({ "", "}" }),
    }),
}

return snippets
