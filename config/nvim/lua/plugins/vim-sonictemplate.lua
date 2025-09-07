-- NAME:   vim-sonictemplate.lua
-- AUTHOR: marsh
-- NOTE:
--
--

return {
  {
    "mattn/vim-sonictemplate",
    cond = true,
    lazy = true,
    cmd = { "Template" },
    init = function()
      vim.g["sonictemplate_vim_template_dir"] = {
        "$HOME/.config/nvim/template",
      }

      vim.g["sonictemplate_vim_vars"] = {}
    end,
  },
}
