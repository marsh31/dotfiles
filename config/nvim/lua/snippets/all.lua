-- NAME:   lua/snippets/all.lua
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

local function count(_, _, old_state)
    old_state = old_state or {
        updates = 0,
    }

    old_state.updates = old_state.updates + 1

    local snip = sn(nil, { t(tostring(old_state.updates)) })

    snip.old_state = old_state
    return snip
end

local snippets = {
    s("trig", {
        i(1, "change to update"),
        d(2, count, { 1 }),
    }),

    s("date", {
        utils.date_input(),
    }),

    s("pnode", {
        c(1, {
            sn(nil, { t("("), r(1, "user_text"), t(")") }),
            sn(nil, { t("["), r(1, "user_text"), t("]") }),
            sn(nil, { t("{"), r(1, "user_text"), t("}") }),
        }),
    }, {
        stored = {
            ["user_text"] = i(1, "default_text"),
        },
    }),

    s("rand", {
      f(function (_, _, _)
        return utils.random0x16x(4)
      end, {}, {})
    }),

    s("uuid", {
      f(function (_, _, _)
        return utils.generate_uuid()
      end, {}, {})
    }),
}

return snippets
