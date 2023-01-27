------------------------------------------------------------
-- FILE:   lua/plugrc/luasnip/python3.lua
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


python3 = {
    parse({trig = "main"}, {
        "def ${1:main}():",
        "\t${2:pass}",
        "",
        "if __name__ == \"__main__\":",
        "    ${1:main}()",
    }),

}

return python3


-- vim: sw=4 sts=4 expandtab fenc=utf-8

