-- NAME:   lua/snippets/rust.lua
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
    -- test
    s("testmodule", {
        t({ "#[cfg(test)]", "" }),
        t({ "mod tests {", "" }),
        t({ "\tuse super::*;", "", "" }),
        t({ "\ttestfn" }),
        i(0),
        t({ "", "}" }),
    }),
    s("testfn", {
        t({ "#[test]", "" }),
        t({ "fn " }),
        i(1, "testfunc_name"),
        t({ "() {", "\t" }),
        i(0),
        t({ "", "}" }),
    }),

    -- fn
    s("fn", {
        c(1, {
            sn(nil, { t("pub "), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
        t({ "fn " }),
        r(2, "func_name"),
        t({ "(" }),
        i(3, "arg"),
        t({ ")" }),
        c(4, {
            sn(nil, { t(" -> "), i(1, "type") }),
            sn(nil, { i(1, "") }),
        }),
        c(5, {
            sn(nil, { t({ "", "where " }), i(1, "condition"), t({ "", "" }) }),
            sn(nil, { t(" "), i(1) }),
        }),
        t({ "{", "\t" }),
        r(6, "process"),
        i(0),
        t({ "", "}" }),
    }, {
        stored = {
            ["func_name"] = i(1, "func_name"),
            ["process"] = i(2, "unimplemented!();"),
        },
    }),

    -- match
    s("match", {
        t("match "),
        i(1, "value"),
        t({ " {", "\t" }),
        t("matchcase"),
        i(2),
        t({ "", "}" }),
    }),

    s("matchcase", {
        c(1, {
            sn(nil, {
                i(1, "value"),
                t(" => "),
                r(2, "exp"),
                t({ ",", "" }),
            }),
            sn(nil, {
                t("_ => "),
                r(1, "exp"),
                t({ ",", "" }),
            }),
        }),
        c(2, {
            sn(nil, { t("matchcase"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
    }, {
        stored = {
            ["exp"] = i(1, "exp"),
        },
    }),

    -- if
    s("if", {
        t({ "if " }),
        i(1, "condition"),
        t({ " {", "\t" }),
        i(2, "proc"),
        t({ "", "}" }),
    }),

    s("else", {
        t({ "else {", "\t" }),
        i(1, "proc"),
        t({ "", "}" }),
    }),

    s("iflet", {
        t({ "if let " }),
        i(1, "value"),
        t(" = "),
        i(2, "some_value"),
        t({ " {", "\t" }),
        i(2, "proc"),
        t({ "", "}" }),
    }),

    -- for
    s("for", {
        t({ "for " }),
        i(1, "i"),
        t(" in "),
        i(2, "range"),
        t({ " {", "\t" }),
        i(3, "proc"),
        t({ "", "}" }),
    }),
}

return snippets
