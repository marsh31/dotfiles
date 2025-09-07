return {
    {
        "stevearc/aerial.nvim",
        cond = false,
        config = function()
            require("aerial").setup()
            require("telescope").load_extension("aerial")
        end,
    },

    {
        "simrat39/symbols-outline.nvim",
        cond = false,
    },

    {
        "sidebar-nvim/sidebar.nvim",
        cond = false,
    },
}
