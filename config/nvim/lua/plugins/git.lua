-- NAME:   lua/plugins/git.lua
-- AUTHOR: marsh
-- NOTE:
--
--
--
--


return {
    {
        "dinhhuy258/git.nvim",
        cond = false,
    },

    {
        "TimUntersberger/neogit",
        cond = false,
        cmd = "Neogit",
    },
    {
        "tanvirtin/vgit.nvim",
        cond = false,
        enabled = false,
        config = function()
            require("vgit").setup({
                settings = {},
            })
        end,
    },

    {
      "sindrets/diffview.nvim",
      cond = false,
    },
    {
      "akinsho/git-conflict.nvim",
      cond = false,
    },
}
