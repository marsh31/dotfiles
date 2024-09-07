-- NAME:   vim-sonictemplate.lua
-- AUTHOR: marsh
-- NOTE:
--

local list = require("default.pluginlist").get_list()

return {
  {
    "mattn/vim-sonictemplate",
    cond = (list.sonictemplate),
    config = function()
      vim.g["sonictemplate_vim_template_dir"] = {
        "$HOME/.config/nvim/template"
      }

      vim.g["sonictemplate_vim_vars"] = {}
    end
  }
}
