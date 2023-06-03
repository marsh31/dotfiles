local M = {}

local function exec_rg(search_word, fn)
  local uv = vim.loop

  local cmd = "rg"
  local cmd_args = { "--vimgrep", "--hidden", search_word }

  local return_value = {}

  local stdio_pipe = uv.new_pipe()
  local options = {
    args = cmd_args,
    stdio = { nil, stdio_pipe, nil },
  }

  local handle = nil
  local on_exit = function(status)
    vim.notify(vim.inspect(status), vim.log.levels.INFO)
    uv.close(handle)

    fn(return_value)
  end

  handle = uv.spawn(cmd, options, on_exit)

  uv.read_start(stdio_pipe, function(_, data)
    if data then
      for _, value in ipairs(vim.split(data, "\n", nil)) do
        local search_results = vim.split(value, ":")

        local search_result = {
          filename = search_results[1],
          lnum = search_results[2],
          col = search_results[3],
          text = search_results[4],
        }

        table.insert(return_value, search_result)
      end
    end
  end)
end

M.search = function()
  exec_rg("return", function(data)
    vim.notify(vim.inspect(data), vim.log.levels.INFO)
    vim.cmd("echo test")
  end)
end

return M
