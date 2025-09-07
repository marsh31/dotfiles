return {
    {
        "goolord/alpha-nvim",
        cond = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local alpha = require("alpha")
            local theme = require("alpha.themes.dashboard")

            alpha.setup(theme.config)
        end,
    },
}
