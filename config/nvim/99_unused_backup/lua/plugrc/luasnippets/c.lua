------------------------------------------------------------
-- FILE:   lua/plugrc/luasnip/c.lua
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


c = {
    parse({trig = "header-guard"}, {
        "#ifndef ${1:GUARD_HEADER}",
        "#define ${1}",
        "${0}",
        "#endif",
    }),

    parse({trig = "main"}, {
        "int main(int argc, char *argv[]) {",
        "\t${0}",
        "\treturn 0;",
        "}",
    }),

    parse({trig = "function"}, {
        "${2:void} ${1:name}(${3:void}) {",
        "\t${0}",
        "}",
    }),

    parse({trig = "for-range"}, {
        "for (${1:i} = 0; ${1} < ${2:size}; ${3:${1}++}) {",
        "\t${0}",
        "}",
    })
}

return c


-- vim: sw=4 sts=4 expandtab fenc=utf-8
