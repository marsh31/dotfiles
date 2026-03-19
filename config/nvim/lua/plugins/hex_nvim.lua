return {
    {
        "RaafatTurki/hex.nvim",
        cond = false,
        cmd = "HexToggle",
        config = function()
            require("hex").setup()
        end,
    },
}
