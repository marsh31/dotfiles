-- NAME:   lua/snippets/json.lua
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

local snippets = {
    s("anki_clozen", {
      t("{{c"), i(1, "1"), t("::"), i(2, "word"), t("}}")
    }),

    s("anki_eng", {
      t("{"),
      t({"", "\t"}), t("\"id\": \""), i(1, "uuid"), t("\","),
      t({"", "\t"}), t("\"front\": ["),
      t({"", "\t\t"}), i(2, "front"),
      t({"", "\t"}), t("],"),
      t({"", "\t"}), t("\"back\": ["),
      t({"", "\t\t"}), i(3, "back"),
      t({"", "\t"}), t("],"),
      t({"", "\t"}), t("\"tags\": ["),
      t({"", "\t\t"}), i(4, "tag"),
      t({"", "\t"}), t("]"),
      t({"", "}"})
    }),

}

return snippets
