--- NAME:   lua/cmp/cmp_markdown_tags.lua
--- AUTHOR: marsh
--- NOTE:
---
---
---

local M = {}

local function read_tags()
  local path = vim.fn.expand("~/.config/nvim/.markdown_tags.txt")
  if vim.fn.filereadable(path) == 0 then return {} end
  local lines = vim.fn.readfile(path)
  local out = {}
  for _, t in ipairs(lines) do
    t = vim.trim(t)
    if #t > 0 and not t:match("^#") then table.insert(out, t) end
  end
  return out
end

local source = {}
source.new = function()
  return setmetatable({ tags = read_tags() }, { __index = source })
end

function source:is_available()
  -- Markdown / MDXあたりでのみ有効化（必要なら拡張）
  local ft = vim.bo.filetype
  return ft == "markdown" or ft == "mdx" or ft == "markdown.mdx"
end

function source:get_debug_name()
  return "markdown_tags"
end

function source:complete(params, callback)
  local line = params.context.cursor_line
  local col = params.context.cursor.col
  local before = line:sub(1, col - 1)

  -- パターン1: ハッシュタグ (#tag…)
  local hash_prefix = before:match("#([%w_%-%/]+)$")

  -- パターン2: front-matter / 行内の tags: の直後
  -- 例: "tags: [ne" / "tags: ne" / "tags: - ne"
  local fm_prefix = before:match("tags:%s*[%[%-%s]*([%w_%-%/]*)$")

  local prefix = hash_prefix or fm_prefix
  if not prefix then
    return callback({ items = {}, isIncomplete = false })
  end

  local items = {}
  for _, t in ipairs(self.tags) do
    if t:find("^" .. vim.pesc(prefix)) then
      local label = t
      if hash_prefix then
        -- すでに '#' の後ろをタイプしているので残りだけ差し替え
        table.insert(items, { label = label, insertText = label, kind = 14 }) -- 14=Keyword-ish
      else
        -- front-matter のときはそのままタグ名だけ
        table.insert(items, { label = label, insertText = label, kind = 14 })
      end
    end
  end

  callback({ items = items, isIncomplete = false })
end

M.setup = function()
  local cmp = require("cmp")
  cmp.register_source("markdown_tags", source.new())
end

return M

