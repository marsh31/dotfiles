-- NAME:   lua/snippets/json.lua
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

-- arg: type
--  <nil>:    return i(jump_index, default)
--  <string>: return t(default)
--  node:     return node
local function make_node(jump_index, node, default)
    local ret_node
    local ret_idx = jump_index
    if not node then
        ret_node = i(jump_index, default)
        ret_idx = jump_index + 1
    elseif type(node) == "string" then
        ret_node = t(node)
    else
        ret_node = node
    end

    return ret_node, ret_idx
end

local function make_bracket(left, right, indent)
    local indent_txt = ""
    local indent_cnt = indent or 0
    for _ = 1, indent_cnt do
        indent_txt = indent_txt .. "\t"
    end

    local leftnode, rightnode
    if not left then
        leftnode = t("")
    else
        leftnode = t({ left, indent_txt .. "\t" })
    end

    if not right then
        rightnode = t("")
    else
        rightnode = t({ "", indent_txt .. right })
    end

    return leftnode, rightnode
end

-- "key": value
-- if key is nil, use default.
-- if value is nil, use default.
local function obj(jump_index, key, arr, bracket_type, indent)
    local btype_idx = bracket_type or 0
    local btypes = {
        [0] = { nil, nil },
        [1] = { "[", "]" },
        [2] = { "{", "}" },
    }
    local indent_txt = ""
    local indent_cnt = indent or 0
    for _ = 1, indent_cnt do
        indent_txt = indent_txt .. "\t"
    end

    local leftnode, rightnode = make_bracket(btypes[btype_idx][1], btypes[btype_idx][2], indent)
    local cnt = 1
    local keynode, valuenode
    keynode, cnt = make_node(cnt, key, "key")
    valuenode, _ = make_node(cnt, arr, "value")

    return sn(jump_index, {
        t(indent_txt .. '"'),
        keynode,
        t('": '),
        leftnode,
        valuenode,
        rightnode,
    })
end

local snippets = {
    s("ini", {
        c(1, {
            sn(nil, { t({ "{", "\t" }), r(1, "obj"), t({ "", "}" }) }),
            sn(nil, { t({ "[", "\t" }), r(1, "obj"), t({ "", "]" }) }),
        }),
    }, {
        stored = { ["obj"] = i(1, "obj") },
    }),

    s("obj", {
        c(1, {
            obj(1, r(1, "key"), r(2, "value"), 0, nil), -- nil, nil
            obj(1, r(1, "key"), r(2, "value"), 1, nil), -- [, ]
            obj(1, r(1, "key"), r(2, "value"), 2, nil), -- {, }
        }),
    }, { stored = {
        ["key"]   = i(1, "key"),
        ["value"] = i(2, "value"),
    } }),

    s("anki_eng", {
        t({ "{", "" }),
        obj(1, "id", i(1, "uuid"), 0, 1),
        t({ ",", "" }),
        obj(2, "front", i(1, "front"), 1, 1),
        t({ ",", "" }),
        obj(3, "back", i(1, "back"), 1, 1),
        t({ ",", "" }),
        obj(4, "tags", i(1, "tags"), 1, 1),
        t({ "", "}" }),
    }),

    s("anki_clozen", {
        t("{{c"),
        i(1, "1"),
        t("::"),
        i(2, "word"),
        t("}}"),
    }),

    s(",", { t({ ",", "" }) }),
}

return snippets
