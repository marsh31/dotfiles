return {
  {
    "phaazon/hop.nvim",
    cond = true,
    config = function()
      local hop = require("hop")
      hop.setup({
        keys = "asdfqwerzxcv",
      })
    end,
  },
}

