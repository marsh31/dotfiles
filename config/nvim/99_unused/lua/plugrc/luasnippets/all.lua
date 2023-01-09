------------------------------------------------------------
-- FILE:   lua/plugrc/luasnip/test.lua
-- AUTHOR: marsh
--
--  * Snippet
------------------------------------------------------------


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


local parse = function(context, body, tab_stops, brackets)
    if type(body) == 'table' then
        body = table.concat(body, '\n')
    end
    return ls.parser.parse_snippet(context, body, tab_stops, brackets)
end

all = {
    s("trigger", {
        t({"if "}), i(1, {"condition"}), t({" then", ""}),
        i(0),
        t({"", "end"}),
    }),

    s({trig = "fullpath"}, {
        f(function(args, snip, user_arg_1) 
            local fullpath = vim.api.nvim_buf_get_name('$')
            return fullpath
        end,
        {1},
        {}),
        i(1),
    }),

    s({trig = "filename"}, {
        f(function(args, snip, user_arg_1) 
            local fullpath = vim.api.nvim_buf_get_name('$')
            local name = vim.fn.fnamemodify(fullpath, ":t")
            return name
        end,
        {1},
        {}),
        i(1),
    }),

    s("trig", {
        i(2),
        t{"", ""},

        i(1),
        t{"", ""},
        f(function(args, snip, user_arg_1) return args[1][1]  end,
        {2},
        {}),
        t{"", ""},

        f(function(args, snip, user_arg_1) return args[1][1]  end,
        {1},
        {}),
        t{"", ""},

        f(function(args, snip, user_arg_1) return args[1][1] .. user_arg_1  end,
        {2},
        "the last string!!!"),
        i(0)
    }),

    s({trig = "header-file"}, {
        t{"===============================================", ""},
        t{"", ""},
        t{"NAME:   "}, i(1, "filename"), t{"", ""},
        t{"AUTHOR: "}, i(2, "marsh"), t{"", ""},
        t{"", ""},
        t{"NOTE:", ""},
        t{"\t"}, i(3, "some things"),
    }),

    s({trig = "sample"}, {
        t({"Sample text!"}),
        i(0),
    }),
}

return all

-- vim: sw=4 sts=4 expandtab fenc=utf-8
