return {
  {
    "bkad/CamelCaseMotion",
  },
  {
    "phaazon/hop.nvim",
    config = function()
      local hop = require("hop")
      hop.setup({
        keys = "asdfqwerzxcv",
      })
    end,
  },
}
