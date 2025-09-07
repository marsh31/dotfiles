--- NAME:   nvim-surround.lua
--- AUTHOR: marsh
--- NOTE:
---
---
---

return {
    {
        "kylechui/nvim-surround",
        cond = true,
        init = function ()
          vim.keymap.set("n", "s", "<Nop>", { desc = "built-in key not used" })
        end,
        keys = {
          { "sa",      mode = "n",  desc = "Nvim-Surround: surround (motion)" },
          { "sail",    mode = "n",  desc = "Nvim-Surround: surround current line" },
          { "sA",      mode = "n",  desc = "Nvim-Surround: surround on new lines" },
          { "sAS",     mode = "n",  desc = "Nvim-Surround: surround current line on new line" },

          { "ds",      mode = "n",  desc = "Nvim-Surround: delete surround" },
          { "cs",      mode = "n",  desc = "Nvim-Surround: change surround" },

          { "<C-g>s",  mode = "i",  desc = "Nvim-Surround: surround (insert)" },
          { "<C-g>S",  mode = "i",  desc = "Nvim-Surround: surround line (insert)" },

          { "s",       mode = "x",  desc = "Nvim-Surround: surround (visual)" },
          { "gS",      mode = "x",  desc = "Nvim-Surround: surround line (visual)" },
        },
        config = function()
            local nvim_surround_config = require("nvim-surround.config")
            require("nvim-surround").setup({
                keymaps = {
                    -- normal add
                    normal = "sa",           -- general operation
                    normal_cur = "sail",     -- line
                    normal_line = "sA",      -- general operation, insert new line.
                    normal_cur_line = "sAS", -- line, and insert new line.

                    delete = "s",
                    change = "cs",

                    insert = "<C-g>s",
                    insert_line = "<C-g>S",

                    visual = "s",
                    visual_line = "gs",
                  },

                  surrouns = {
                  [","] = {
                    add = { ",", "," },
                    find = function ()
                      return nvim_surround_config.get_selection({ motion = "a," })
                    end,
                  }
                }
            })
        end,
    },
}
