return {
    {
        "stevearc/stickybuf.nvim",
        cond = false,
        config = function()
            require("stickybuf").setup()
        end,
    },
}
