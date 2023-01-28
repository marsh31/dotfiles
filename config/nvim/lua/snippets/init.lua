-- NAME:   lua/snippets/init.lua
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

local function count(_, _, old_state)
    old_state = old_state or {
        updates = 0,
    }

    old_state.updates = old_state.updates + 1

    local snip = sn(nil, { t(tostring(old_state.updates)) })

    snip.old_state = old_state
    return snip
end

ls.add_snippets("all", {
    s("trig", {
        i(1, "change to update"), d(2, count, { 1 }),
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
})

ls.add_snippets("lua", {
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
            sn(nil, { t(""), i(1) })
        }),
        t({ "", "end" }),
        i(0),
    }),

    s("elif", {
        t("elseif "), i(1, "condition"), t(" then"),
        t({ "", "\t" }), i(2, "process"),
        t({ "", "" }), c(3, {
            sn(nil, { t("elif"), i(1) }),
            sn(nil, { t("else"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
    }),

    s("else", {
        t("else"),
        t({ "", "\t" }), i(2, "process"),
        t({ "", "" }), c(3, {
            sn(nil, { t("elif"), i(1) }),
            sn(nil, { t("else"), i(1) }),
            sn(nil, { t(""), i(1) }),
        }),
    }),
})

ls.add_snippets("markdown", {
    s({ trig = "h(%d)", regTrig = true }, {
        f(function(args, snip)
            local ret = ""
            for i = 1, snip.captures[1], 1 do
                ret = ret .. "#"
            end
            ret = ret .. " "
            return ret
        end, {}),
    }),
    s("->>", {
        i(1, "send"),
        t(" ->> "),
        i(2, "recv"),
        t(" : "),
        i(0, "msg"),
    }),
})

ls.add_snippets("sh", {
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
})

ls.add_snippets("vim", {
    s("vimgrep", {
        -- vimgrep!
        t("vimgrep "),
        t("/"),
        i(1, "pattern"),
        t("/j "),
        i(2, "%"),
    }),
})

-- vim: sw=4 sts=4 expandtab fenc=utf-8
