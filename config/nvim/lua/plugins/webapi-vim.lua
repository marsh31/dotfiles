--- NAME:   webapi-vim.lua
--- AUTHOR: marsh
--- NOTE:
---
--- 基本的には、プラグインを補助する形。
--- APIを叩いて、プラグインを実装するときにしか利用しない。
---

return {
  "mattn/webapi-vim",
  cond = true,
  event = "VeryLazy",
  init = function ()
    vim.g["webapi#debug"]   = 1
    vim.g["webapi#timeout"] = 10
  end
}
