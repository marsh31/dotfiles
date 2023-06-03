return {
  {
    "thinca/vim-partedit",
    config = function()
      vim.g["partedit#opener"] = "vsplit"

      -- prefix
      -- filetype
    end,
  },
  {
    "simeji/winresizer",
    -- cmd :WinResizerStartResize
    config = function()
      vim.g.winresizer_start_key = "<C-w><C-e>"
      vim.g.winresizer_vert_resize = 10
      vim.g.winresizer_horiz_resize = 5
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          -- normal add
          normal = "sa", -- general operation
          normal_cur = "sas", -- line
          normal_line = "sA", -- general operation, insert new line.
          normal_cur_line = "sAS", -- line, and insert new line.

          delete = "sd",
          change = "sc",

          insert = "<C-g>s",
          insert_line = "<C-g>S",

          visual = "S",
          visual_line = "gS",
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
          -- :SaveSession, :RestoreSession, :DeleteSession
          -- auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      })
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        plugins = {
          registers = false,
        },
      })
    end,
  },
  {
    "mrjones2014/legendary.nvim",
  },
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local theme = require("alpha.themes.dashboard")

      alpha.setup(theme.config)
    end,
  },
  { "ahmedkhalf/project.nvim" },
  {
    "phaazon/hop.nvim",
    config = function()
      local hop = require("hop")
      hop.setup({
        keys = "asdfqwerzxcv",
      })
    end,
  },
  { "RaafatTurki/hex.nvim" },
  {
    "kat0h/bufpreview.vim",
    build = "deno task prepare",
    dependencies = {
      "vim-denops/denops.vim",
    },

    config = function()
      vim.g.bufpreview_browser = "firefox"
    end,
  },
  {
    "stevearc/stickybuf.nvim",
    config = function ()
      require("stickybuf").setup()
    end,
  }
}
