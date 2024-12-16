return {
    {
        "RaafatTurki/hex.nvim",
        cmd = "HexToggle",
        config = function()
            require("hex").setup()
        end,
    },
}
