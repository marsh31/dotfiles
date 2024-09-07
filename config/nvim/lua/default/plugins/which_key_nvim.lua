-- NAME: which_key_nvim.lua
--
--
-- NOTE:
--
-- After configuring, `:checkhealth which-key`
-- {
--   mode = "n"
--   prefix = "",
--   buffer = nil,
--   silent = true,
--   noremap = true,
--   nowait = false,
--   expr = false,
-- }
--
-- local wk = require("which-key")
-- wk.register({
--   f = {
--     ["1"] = ...
--   }
-- })

local list = require("default/pluginlist").get_list()
if list.which_key_nvim == nil then
  list.which_key_nvim = false
end

return {
  {
    "folke/which-key.nvim",
    cond = list.which_key_nvim,
    event = "VeryLazy",
    opts = {},
    config = function()
      require("which-key").setup({
        plugins = {
          marks = false,
          registers = false,
          spelling = {
            enabled = false,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            nav = false,
            z = false,
          },
        },
        triggers_nowait = {},
      })
    end,
  },
}
