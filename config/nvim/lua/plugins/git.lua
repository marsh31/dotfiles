return {
    {
        "dinhhuy258/git.nvim",
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signcolumn = false,
                numhl = true,
            })
        end,
    },

    {
        "TimUntersberger/neogit",
        cmd = "Neogit",
    },
    {
        "tanvirtin/vgit.nvim",
        enabled = false,
        config = function()
            require("vgit").setup({
                settings = {},
            })
        end,
    },

    { "sindrets/diffview.nvim" },
    { "akinsho/git-conflict.nvim" },
}
