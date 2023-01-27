------------------------------------------------------------
-- FILE:   lua/plugrc/luasnip/lua.lua
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


lua = {
    parse({trig = "if-then"}, {
        "if ${1:condition} then",
        "\t${0}",
        "end"
    }),

    parse({trig = "for-ipair"}, {
        "for ${1:_index}, ${2:_value} in ${3:table} do",
        "\t${0}",
        "end"
    }),

    parse({trig = "for-index"}, {
        "for ${1:_index} = ${2:start}, ${3:end} do",
        "\t${0}",
        "end"
    }),

    s({trig = '%d.value', regTrig = true, wordTrig = true}, {
        f(function (args)
            return {
                "Captured Text: " .. args[1].captures[1] .. '.'
            }
        end, {}),
        i(0)
    }),
}

return lua


-- vim: sw=4 sts=4 expandtab fenc=utf-8
