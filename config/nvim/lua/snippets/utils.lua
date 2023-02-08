-- NAME:   lua/snippets/utils.lua
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

local utils = {}


utils.date_input = function (args, state, fmt)
  local fmt = fmt or "%Y-%m-%d"
  return sn(nil, i(1, os.date(fmt)))
end


utils.random0x16x = function(cnt)
  math.randomseed(os.time())
  local random = math.random
  local template = ""
  for i = 1, cnt, 1 do
    template = template .. "x"
  end

  return string.gsub(template, "x", function()
    local v = random(0, 0xf)
    return string.format("%x", v)
  end)
end


utils.generate_uuid = function()
  math.randomseed(os.time())
  local random = math.random
  local template = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  -- return template
  return string.gsub(template, "x", function()
    local v = random(0, 0xf)
    return string.format("%x", v)
  end)
  --   local v = random(0, 0xf)
  --   return string.format("%x", v)
  -- end)
end


return utils
