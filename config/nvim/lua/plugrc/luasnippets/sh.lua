------------------------------------------------------------
-- FILE:   lua/plugrc/luasnip/sh.lua
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


sh = {
    parse({trig = "init"}, {
        "#!/usr/bin/bash",
        "# ",
        "# NAME:   ${1:filename}",
        "# AUTHOR: marsh",
        "# ",
        "# NOTE:",
        "# 	${0}",
        "# tools:",
    })
}

return sh


-- vim: sw=4 sts=4 expandtab fenc=utf-8


