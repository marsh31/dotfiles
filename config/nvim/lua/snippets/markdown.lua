-- NAME:   lua/snippets/markdown.lua
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

---@param  num integer 1 to 6
---@return SnippetNode
local function header(num)
  local label = ""
  for index = 1, num, 1 do
    label = label .. "#"
  end

  return s("h" .. num, {
    t(label .. " "),
    i(0),
  })
end

local attrs = {
  { head = "*", tail = "*" },
  { head = "_", tail = "_" },
  { head = "**", tail = "**" },
  { head = "`", tail = "`" },
  { head = "~~", tail = "~~" },
}

---@param  order integer
---@return ChoiceNode
local function choice_attrs(order)
  local nodes = {}
  for index, value in ipairs(attrs) do
    nodes[index] = sn(nil, {
      t(value["head"]),
      i(1),
      t(value["tail"]),
    })
  end

  return c(order, nodes)
end

------------------------------------------------------------
--- Snippets
------------------------------------------------------------
local snippets = {
  s({ trig = "h(%d)", regTrig = true }, {
    f(function(args, snip)
      local ret = ""
      for i = 1, snip.captures[1], 1 do
        ret = ret .. "#"
      end
      ret = ret .. " "
      return ret
    end, {}),
  }),

  header(1),
  header(2),
  header(3),
  header(4),
  header(5),
  header(6),

  s("attr", {
    choice_attrs(1),
  }),

  s("codeb", {
    t("```"),
    i(1, "lang"),
    t(":"),
    i(2, "filename"),
    t({ "", "" }),
    i(0),
    t({ "", "```" }),
  }),

  s("code", {
    t("`"),
    i(1, "code"),
    t("`"),
  }),

  s("mermaid_seq", {
    t("```mermaid"),
    t({ "", "sequenceDiagram", "" }),
    i(0),
    t({ "", "```" }),
  }),

  s("task", {
    t("- [ ] "),
    i(0),
  }),

  s("->>", {
    i(1, "send"),
    t(" ->> "),
    i(2, "recv"),
    t(" : "),
    i(0, "msg"),
  }),
}

return snippets
