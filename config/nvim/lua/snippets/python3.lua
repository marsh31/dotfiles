-- NAME:   lua/snippets/python3.lua
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
local utils = require("snippets.utils")

local snippets = {
    s("shebang", {
        t("#!/usr/bin/env python3"),
    }),

    s("main", {
        t("def main():"),
        t({ "", "\t" }),
        i(1, "pass"),
        i(0),
        t({ "", "" }),
        t({ "", "if __name__ == '__main__':" }),
        t({ "", "\tmain()" }),
    }),

    s("fn", {
        t("def "), i(1), t("("), c(2, {
            sn(nil, { i(1, "args") }),
            sn(nil, { i(1, "") }),
        }),
        t("):"),
        t({ "", "\t" }),
        i(3, "process"),
        i(0),
    }),
}

return snippets
