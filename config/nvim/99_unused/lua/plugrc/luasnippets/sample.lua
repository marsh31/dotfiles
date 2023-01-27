------------------------------------------------------------
-- FILE:   lua/plugrc/luasnip/sample.lua
-- AUTHOR: marsh
--
--  * Snippet sample and my memo.
------------------------------------------------------------

-- luasnip utility.
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


-- vscode snippet style parser.
-- Ref: https://zenn.dev/tamago324/scraps/ea3763831596e5
--
-- what is ls.parser.parser(context, body, tab_stops, brackets)
--   use `:h luasniip-lsp-snippets`
--
-- why make this function?
-- the second argument of ls.parser.parser require string value like "{1} is {2:string}.\nSo, it is hard to understand snippet."
-- So, user must write "\n", in string if user want multiline snippet.
-- I don't want to do it, because I can't understand it at a glance.
--
-- the function make string to join '\n' if the body is table type.
-- So, user can write snippet easily like { "", "" }
local parse = function(context, body, tab_stops, brackets)
    if type(body) == 'table' then
        body = table.concat(body, '\n')
    end
    return ls.parser.parse_snippet(context, body, tab_stops, brackets)
end


--
-- * snippet node
-- s({first}, {second})
-- first is a table with the entries:
--   - trig
--   - name
--   - dscr
--   - wordTrig
--   - regTrig
--   - docstring
--   - docTrig
--   - hidden
-- second is a table containing all luasnip snippet node.
-- the table make snippet contents.
ls.snippets = {
    -- filetype. below is all type. if you want to write snippet for c type, 
    -- make `c = {...snippet...}`
    all = {

        -- text node
        -- t({string, ...})
        -- text data. if the table has multi-string,
        -- the result is multiline-string.
        --
        --
        -- insert node
        --
        -- i(i_num, string)
        -- - i [ insert node]
        --   - i_num: the order of jumping.
        --   - string: placeholder text.
        --
        s("trigger", {
            t({"if "}), i(1, {"condition"}), t({" then", ""}),
            i(0),
            t({"", "end"}),
        }),

        -- function node sample.
        --
        -- f(function(args, snip, user), i_num, user_arg_1)
        -- - f [ function node ]
        --   - arg1: function
        --   - i_num: the number of insert node user want captured.
        --   - user_arg_1: ???
        --
        -- - function [ functionnode arg1 ]
        --   - args: the insert node value of i_num.
        --   - snip: ??? (snip.env or snip.captures?)
        --   - user: user_args_1 value.
        s("function-node-sample", {
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
            "last test."),
            i(0)
        }),

        s({trig = "sample"}, {
            t({"Sample text!"}),
            i(0),
        }),
    },
}




-- vim: sw=4 sts=4 expandtab fenc=utf-8
