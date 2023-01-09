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


rust = {
    parse({trig = "testmodule"}, {
        "#[cfg(test)]",
        "mod tests {",
        "\t${1:testfunc}${0}",
        "}",
    }),

    parse({trig = "testfunc"}, {
        "#[test]",
        "fn ${1:it_work}() {",
        "\t${2:assert_eq!(result, 4);}${0}",
        "}",
    }),

    parse({trig = "->_ret_type"}, {
        "-> ${1:Result} ",
    }),

    parse({trig = "function"}, {
        "${1:pub }fn ${2:name}() ${3:->_ret_type}${4}{",
        "\t${0}",
        "}",
    }),

    parse({trig = "use"}, {
        "use ${1:std::io};${0}",
    }),

    parse({trig = "main"}, {
        "${1:async }fn main() ${2:-> }${3:std::io::Result<()> }{",
        "\t${0}",
        "}",
    }),

    parse({trig = "impl"}, {
        "impl ${1:Display} for ${2:Struct_name} {",
        "\t${0}",
        "}"
    }),

    parse({trig = "else-if"}, {
        "else if ${1:condition} {",
        "\t${2:process}",
        "}${0}",
    }),

    parse({trig = "else"}, {
        "else {",
        "\t${0}",
        "}",
    }),

    parse({trig = "if_elseif_else"}, {
        "if ${1:condition} {",
        "\t${2:process}",
        "}${0}",
    }),

    parse({trig = "match_case"}, {
        "${1:case} => ${2:process}",
        "${3:match_case}${0}"
    }),

    parse({trig = "match"}, {
        "match ${1:*self} {",
        "\t${2:match_case}${0}",
        "}",
    }),

    parse({trig = "struct_member"}, {
        "${1:pub }${2:name}: ${3:type},",
        "${4:struct_member}${0}"
    }),

    parse({trig = "struct"}, {
        "struct ${1:Name} {",
        "\t${2:struct_member}${0}",
        "}",
    }),

    parse({trig = "derive"}, {
        "#[derive(${1:Debug})]${0}"
    }),

    parse({trig = "repr"}, {
        "#[repr(${1:i32})]${0}"
    }),

    parse({trig = "r##"}, {
        "r#\"",
        "${1:text}",
        "\"#",
    })
}

return rust


-- vim: sw=4 sts=4 expandtab fenc=utf-8

