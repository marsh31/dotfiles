------------------------------------------------------------
-- FILE:   lua/plugrc/luasnip/html.lua
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


html = {
    parse({trig = "init"}, {
        "<!DOCTYPE html>",
        "<html>",
        "\t<head>",
        "\t\t<meta charset=\"utf-8\">",
        "\t\t<title>${1:title}</title>",
        "\t\t<!-- change this up! http://www.bootstrapcdn.com/bootswatch/ -->",
        "\t\t<link href=\"https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/cosmo/bootstrap.min.css\" type=\"text/css\" rel=\"stylesheet\"/>",
        "\t</head>",
        "",
        "\t<body>",
        "\t\t<div id=\"app\"></div>",
        "\t\t<script src=\"${2:mainjs}\"></script>",
        "\t</body>",
        "</html>",
    }),

    parse({trig = "doctype"}, {
        "<!DOCTYPE html>"
    }),
}

return html


-- vim: sw=4 sts=4 expandtab fenc=utf-8


