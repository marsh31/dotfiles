------------------------------------------------------------
-- FILE:   lua/plugrc/luasnip/http.lua
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

-- Reference:
-- https://github.com/NTBBloodbath/rest.nvim/tree/main/tests
http = {
    parse({trig = "get"}, {
        "GET ${1:https}://${2:localhost:8080}/${0}"
    }),

    parse({trig = "contenttype_application-json"}, {
        "Content-Type: application/json",
    }),

    parse({trig = "post"}, {
        "POST ${1:https}://${2:localhost:8080}/${3:something}",
        "contenttype_application-json${5}",
        "",
        "{",
        "\t${0}",
        "}"
    })
}

return http


-- vim: sw=4 sts=4 expandtab fenc=utf-8
