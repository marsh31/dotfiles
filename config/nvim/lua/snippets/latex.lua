-- NAME:   latex.lua
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
local utils = require("snippets.utils")

local rec_ls
rec_ls = function()
    return sn(nil, {
        c(1, {
            -- important!! Having the sn(...) as the first choice will cause infinite recursion.
            t({ "" }),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        }),
    })
end

local function column_count_from_string(descr)
    -- this won't work for all cases, but it's simple to improve
    -- (feel free to do so! :D )
    return #(descr:gsub("[^clm]", ""))
end

-- function for the dynamicNode.
local tab = function(args, snip)
    local cols = column_count_from_string(args[1][1])
    -- snip.rows will not be set by default, so handle that case.
    -- it's also the value set by the functions called from dynamic_node_external_update().
    if not snip.rows then
        snip.rows = 1
    end
    local nodes = {}
    -- keep track of which insert-index we're at.
    local ins_indx = 1
    for j = 1, snip.rows do
        -- use restoreNode to not lose content when updating.
        table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert(nodes, t(" & "))
            table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ "\\\\", "" }))
    end
    -- fix last node.
    nodes[#nodes] = t("")
    return sn(nil, nodes)
end

local snippets = {
    s("ls", {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(1),
        d(2, rec_ls, {}),
        t({ "", "\\end{itemize}" }),
        i(0),
    }),
    s(
        "tab",
        fmt(
            [[
\begin{{tabular}}{{{}}}
{}
\end{{tabular}}
]]           ,
            {
                i(1, "c"),
                d(2, tab, { 1 }, {
                    user_args = {
                        -- Pass the functions used to manually update the dynamicNode as user args.
                        -- The n-th of these functions will be called by dynamic_node_external_update(n).
                        -- These functions are pretty simple, there's probably some cool stuff one could do
                        -- with `ui.input`
                        function(snip)
                            snip.rows = snip.rows + 1
                        end,
                        -- don't drop below one.
                        function(snip)
                            snip.rows = math.max(snip.rows - 1, 1)
                        end,
                    },
                }),
            }
        )
    ),
}

return snippets

-- vim: sw=4 sts=4 expandtab fenc=utf-8
