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

return {
  {
    "folke/which-key.nvim",
    cond = true,
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function () require("which-key").show({ global = false }) end,
        desc = "Buffer local keymaps (which-key)",
      },
    },
    opts = {
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,

      plugins = {
        marks = false,
        registers = false,
        spelling = {
          enabled = false,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = false,
          z = false,
          g = true,
        },
      },

      win = {
        no_overlap = true,
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,

        bo = {},
        wo = {}
      }
    },
  },
}
