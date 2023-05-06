-- NAME:   lua/snippets/typescript.lua
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
    s("val", {
        c(1, {
            sn(nil, { t("const "), r(1, "value_name"), t(": "), i(2, "type"), t(" = "), i(3, "init_value"), t(";") }),
            sn(nil, { t("let "), r(1, "value_name"), t(": "), i(2, "type"), t(" = "), i(3, "init_value"), t(";") }),
        }),
    }, {
        stored = { ["value_name"] = i(1, "value") },
    }),

    -- if-elseif-else
    s("if", {
        t("if ("),
        i(1, "condition"),
        t({ ") {", "\t" }),
        i(2, "process"),
        t({ "", "}" }),

        c(3, {
            sn(nil, { t(" elif"), i(1) }),
            sn(nil, { t(" else"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
    }),
    s("elif", {
        t("else if ("),
        i(1, "condition"),
        t({ ") {", "\t" }),
        i(2, "process"),
        t({ "", "}" }),

        c(3, {
            sn(nil, { t(" elif"), i(1) }),
            sn(nil, { t(" else"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
    }),
    s("else", {
        t({ "else {", "\t" }),
        i(2, "process"),
        t({ "", "}" }),
    }),

    -- switch
    s("switch", {
        t("switch ("),
        i(1, "value"),
        t({ ") {", "\t" }),

        c(2, {
            sn(nil, { t("case"), i(1) }),
            sn(nil, { t("default"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
        i(0),

        t({ "", "}" }),
    }),
    s("case", {
        t("case "),
        i(1, "value"),
        t({ ":", "\t" }),
        i(2, "process"),
        t({ "", "\tbreak;", "" }),

        c(3, {
            sn(nil, { t("case"), i(1) }),
            sn(nil, { t("default"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
    }),
    s("default", {
        t({ "default:", "\t" }),
        i(1, "process"),
    }),

    -- while
    s("while", {
        t("while ("),
        i(1, "condition"),
        t({ ") {", "\t" }),
        i(2, "process"),
        t({ "", "}" }),
    }),

    s("console", {
        t("console.log("),
        i("message"),
        t(")"),
    }),

    -- for
    s("for", {
        t("for (let "),
        i(1, "i: number = 0"),
        t("; "),
        i(2, "condition"),
        t(";"),
        i(3, "i++"),
        t({ ") {", "\t" }),
        i(4, "process"),
        t({ "", "}" }),
    }),

    -- obj
    -- const obj : {
    --   foo: number,
    --   bar: string,
    -- } = {
    --   foo: 1234,
    --   bar: "test",
    -- }
    s("obj", {
        t("{"),
        c(2, {
            sn(nil, { t(" "), i(1, "obj_value"), t(" ") }), -- oneline
            sn(nil, { t({ "", "\t" }), i(1, "obj_value"), t({ "", "" }) }), -- multiline
        }),
        t("}"),
        i(1, ";"),
    }),
    s("obj_value", {
        i(1, "key"),
        t(": "),
        i(2, "value"),
        t(","),
    }),

    -- retype
    s("type", { t("type "), i(1, "newtype"), t(" = "), i(2, "oldtype") }),
    s("interface", {
        t("interface "),
        i(1, "interfacename"),
        t({ " {", "\t" }),
        i(2, "obj_type"),
        i(0),
        t({ "", "}" }),
    }),
    s("obj_type", {
        i(1, "key"),
        t(": "),
        i(2, "value"),
        t(","),
    }),

    -- fn
    s("fn", {
        i(1, "func_name"),
        t(" ("),
        i(2, "arg"),
        t({ ") {", "" }),
        t("\t"),
        i(0),
        t({ "", "}" }),
    }),

    s("import", {
        t("import { "),
        i(1, "module"),
        t(" } from "),
        i(2, "module"),
        t(";"),
    }),
}

return snippets
