-- NAME:   dev/init.lua
-- AUTHOR: marsh
-- 
-- NOTE:
-- # develop env.
--
-- ## nvim lua dev guide
-- https://github.com/nanotee/nvim-lua-guide
-- https://zenn.dev/slin/articles/2020-10-19-neovim-lua1
-- https://jacobsimpson.github.io/nvim-lua-manual/
--
-- ## lua language
-- https://ja.wikibooks.org/wiki/Lua
-- https://github.com/anthony-khong/nvim-education
-- https://light11.hatenadiary.com/archive/category/Lua
-- https://itsakura.com/other-pg
-- http://gurakura.sakura.ne.jp/lua/
-- http://www.rtpro.yamaha.co.jp/RT/docs/lua/tutorial/index.html
--
-- ## How to write plugin?
-- https://learnxinyminutes.com/docs/lua/
-- https://github.com/medwatt/Notes
-- https://speakerdeck.com/delphinus/neovim-dejin-feng-nopuraguinwoshu-kufang-fa?slide=11
--
-- ## Standard
-- https://github.com/norcalli/neovim-plugin
--
-- ## test
-- https://zenn.dev/notomo/articles/neovim-lua-plugin-testing
-- https://github.com/lunarmodules/busted
--



local group_name = "select_window"
local opts = {
  relative = "win",
  win = 0,
  width = 3,
  height = 3,
  col = 1,
  row = 1,
  anchor = "NW",
  style = "minimal",
  border = "rounded",
  noautocmd = false,
}

M = {}
M.origin_buf = 0
M.origin_win = 0
M.wins = {}
M.ignore = {
  "qf",
  "notify",
}

local signature = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local function isAlph(num)
  if (65 <= num and num <= 90) or (97 <= num and num <= 122) then
    return true
  else
    return false
  end
end

local function get_alphabet_keepress()
  local key = vim.fn.getchar()
  while not isAlph(key) do
    vim.notify("[nvim_qf_helper.open] Input a to z or A to Z", vim.log.levels.WARN)
    key = vim.fn.getchar()
  end

  return key
end

local function clear_float_window_ids()
  print(vim.inspect(M.wins))
  for _ = 1, #M.wins do
    table.remove(M.wins)
  end
end

local function close()
  for _, winid in pairs(M.wins) do
    vim.api.nvim_win_close(winid.float_winnr, true)
  end
end

local function open()
  clear_float_window_ids()

  local list_wins = vim.tbl_filter(function(winnr)
    local bufno = vim.fn.winbufnr(winnr)
    local buftype = vim.fn.getbufvar(bufno, "&filetype")
    local isOk = true

    for _, value in ipairs(M.ignore) do
      isOk = isOk and not (value == buftype)
    end
    return isOk
  end, vim.api.nvim_list_wins())

  for idx, winno in ipairs(list_wins) do
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "", string.format(" %s", string.sub(signature, idx, idx)), "" })

    local buf_opt = opts
    buf_opt.win = winno

    local winid = vim.api.nvim_open_win(buf, false, buf_opt)
    M.wins[string.sub(signature, idx, idx)] = {
      float_winnr = winid,
      target_winnr = winno
    }
  end

  vim.defer_fn(function()
    local key = get_alphabet_keepress()
    local sig = string.upper(string.char(key))
    while M.wins[sig] == nil do
      vim.notify("Please press A to Z", vim.log.levels.WARN)

      key = get_alphabet_keepress()
      sig = string.upper(string.char(key))
    end

    print(vim.inspect(M.wins))
    vim.notify(string.format("%s", M.wins[sig].target_winnr), vim.log.levels.INFO)
    vim.api.nvim_set_current_win(M.wins[sig].target_winnr)

    close()
  end, 500)
end

M.setup = function()
  vim.api.nvim_create_augroup("select_window", {})
end

M.select = function()
  open()
end

M.close = function()
  close()
end

M.show_winids = function()
  print(string.format("%s", vim.inspect(M.wins)))
end

M.show = function()
  print(string.format("%s", vim.inspect(vim.api.nvim_list_wins())))
end

return M
