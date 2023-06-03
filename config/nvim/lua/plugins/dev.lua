return {
    {
        "folke/neodev.nvim",
        opts = {},
        ft = { "lua" },
    },

    { "notomo/lreload.nvim", ft = { "lua" } },
    {
        dir = "~/src/project/nvim-qf-helper",
        config = function()
            require("nvim_qf_helper").setup()
            require("lreload").enable("nvim_qf_helper")
            require("lreload").enable("dev")
            require("lreload").enable("dev/rg")
        end,
    },
}
