local async = require("plenary.async")
local async_system = async.wrap(vim.system, 3)

---@alias RgInfo { filename: string, lnum: number, col: number, text: string}

---parse rg result to data
---@param input string
---@return RgInfo | nil data
local function parse(input)
  local data = vim.split(input, ":")

  local row = tonumber(data[2])
  local col = tonumber(data[3])
  local line = ""
  for i = 4, #data do
    line = line .. data[i]
  end

  if row == nil or col == nil or line == "" then
    return nil
  end

  return {
    filename = data[1],
    lnum = row,
    col = col,
    text = line,
  }
end

local function search(word)
  local result = async_system({ "rg", "--vimgrep", "--no-heading", word })
  local items = {}
  
  for line in vim.gsplit(result.stdout, "[\r\n]") do
    table.insert(items, line)
  end
  vim.fn.setqflist(items, "r")
  return word, #result.stdout, result.stdout
end

local function print_result(word, size, result)
  print(("> %s"):format(word))
end

async.util.block_on(function()
  async.run(function()
    return search("test")
  end, print_result)
  print("TEST")
end)

vim.wait(1000)

-- local string = [[things
-- isn
-- test.]]
--
--
-- print(string)
-- for index, value in ipairs(vim.split(string, "[\r\n]")) do
--   print(("%d > %s"):format(index, value))
-- end
