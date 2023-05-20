
return {
{
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },

            -- other plugins
            { "nvim-telescope/telescope-ghq.nvim" },
        },
        config = function()
            require("telescope").setup()
            require("telescope").load_extension("ghq")
        end,
    }
}
