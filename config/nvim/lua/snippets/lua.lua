-- NAME:   lua/snippets/lua.lua
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
    s("fn", {
        t("function "),
        i(1),
        t("("),
        i(2, "args"),
        t(")"),
        t({ "", "\t" }),
        i(3, "process"),
        i(0),
        t({ "", "end" }),
    }),

    s("dict", {
        i(1, "key"),
        t(" = "),
        c(2, {
            sn(nil, { i(1, "value") }),
            sn(nil, {
                t("{"),
                t({ "", "\t" }),
                i(1, "value"),
                t({ "", "}" }),
            }),
        }),
        t(","),
        i(0),
    }),

    s("if", {
        t("if "),
        i(1, "condition"),
        t(" then"),
        t({ "", "\t" }),
        i(2, "process"),
        t({ "", "" }),
        c(3, {
            sn(nil, { t("elif"), i(1) }),
            sn(nil, { t("else"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
        t({ "", "end" }),
        i(0),
    }),

    s("elif", {
        t("elseif "),
        i(1, "condition"),
        t(" then"),
        t({ "", "\t" }),
        i(2, "process"),
        t({ "", "" }),
        c(3, {
            sn(nil, { t("elif"), i(1) }),
            sn(nil, { t("else"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
    }),

    s("else", {
        t("else"),
        t({ "", "\t" }),
        i(2, "process"),
        t({ "", "" }),
        c(3, {
            sn(nil, { t("elif"), i(1) }),
            sn(nil, { t("else"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
    }),
}

return snippets
