-- NAME:   vim-submode.lua
-- AUTHOR: marsh
-- NOTE:
--

local enter_with = vim.fn["submode#enter_with"]
local map = vim.fn["submode#map"]
local leave_with = vim.fn["submode#leave_with"]


-- undo / redo
local function enter_undo_redo(lhs, rhs)
  enter_with("undo/redo", "n", "", lhs, rhs)
end

local function map_undo_redo(lhs, rhs)
  map("undo/redo", "n", "", lhs, rhs)
end


-- winsize
local function enter_winsize(lhs, rhs)
  enter_with("winsize", "n", "", lhs, rhs)
end

local function map_winsize(lhs, rhs)
  map("winsize", "n", "", lhs, rhs)
end

local function leave_winsize(lhs)
  leave_with('winsize', 'n', '', lhs)
end


-- winmove
local function enter_winmove(lhs, rhs)
  enter_with("winmove", "n", "", lhs, rhs)
end

local function map_winmove(lhs, rhs)
  map("winmove", "n", "", lhs, rhs)
end

local function leave_winmove(lhs)
  leave_with('winmove', 'n', '', lhs)
end

return {
  {
    "kana/vim-submode",
    cond = true,
    config = function()
      vim.g.submode_keep_leaving_key = false
      vim.g.submode_always_show_submode = 1

      -- undo redo
      enter_undo_redo("g-", "g-")
      enter_undo_redo("g+", "g+")
      map_undo_redo("-", "g-")
      map_undo_redo("+", "g+")


      -- winsize
      enter_winsize('<C-w>>', '<C-w>>')
      enter_winsize('<C-w><', '<C-w><')
      enter_winsize('<C-w>+', '<C-w>+')
      enter_winsize('<C-w>-', '<C-w>-')
      map_winsize('>', '<C-w>>')
      map_winsize('<', '<C-w><')
      map_winsize('+', '<C-w>+')
      map_winsize('-', '<C-w>-')
      leave_winsize('<Esc>')


      -- winmove
      enter_winmove('gt', 'gt')
      enter_winmove('gT', 'gT')
      enter_winmove('<C-w>j', '<C-w>j')
      enter_winmove('<C-w>k', '<C-w>k')
      enter_winmove('<C-w>l', '<C-w>l')
      enter_winmove('<C-w>h', '<C-w>h')
      enter_winmove('<C-w>w', '<C-w>w')
      enter_winmove('<C-w><C-j>', '<C-w>j')
      enter_winmove('<C-w><C-k>', '<C-w>k')
      enter_winmove('<C-w><C-l>', '<C-w>l')
      enter_winmove('<C-w><C-h>', '<C-w>h')
      enter_winmove('<C-w><C-w>', '<C-w>w')

      map_winmove('t', 'gt')
      map_winmove('T', 'gT')
      map_winmove('<C-j>', '<C-w>j')
      map_winmove('<C-k>', '<C-w>k')
      map_winmove('<C-l>', '<C-w>l')
      map_winmove('<C-h>', '<C-w>h')
      map_winmove('<C-w>', '<C-w>w')

      leave_winmove('<Esc>')
      leave_winmove('<Cr>')

    end,
  },
}
