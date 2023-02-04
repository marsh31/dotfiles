-- NAME:   lua/snippets/typescript.lua
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

local snippets = {
  s("val", {
    c(1, {
      sn(nil, { t("const "), r(1, "value_name"), t(": "), i(2, "type"), t(" = "), i(3, "init_value"), t(";") }),
      sn(nil, { t("let "), r(1, "value_name"), t(": "), i(2, "type"), t(" = "), i(3, "init_value"), t(";") })
    })
  }, {
    stored = { ["value_name"] = i (1, "value") },
  }),

  s("console", {
    t("console.log("), i("message"), t(")"),
  }),

  s ("import", {
    t("import { "), i(1, "module"), t(" } from "), i(2, "module"), t(";")
  }),
}

return snippets
