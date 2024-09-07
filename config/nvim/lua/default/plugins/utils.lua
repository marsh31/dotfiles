return {
    {
        "RaafatTurki/hex.nvim",
        cmd = "HexToggle",
        config = function()
            require("hex").setup()
        end,
    },
    {
        "junegunn/vim-easy-align",
    },
    {
        "thinca/vim-partedit",
        config = function()
            vim.g["partedit#opener"] = "vsplit"

            -- prefix
            -- filetype
        end,
    },
    {
        "simeji/winresizer",
        -- cmd :WinResizerStartResize
        config = function()
            vim.g.winresizer_start_key = "<C-w><C-e>"
            vim.g.winresizer_vert_resize = 10
            vim.g.winresizer_horiz_resize = 5
        end,
    },
    {
        "mrjones2014/legendary.nvim",
    },
    {
        "goolord/alpha-nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local alpha = require("alpha")
            local theme = require("alpha.themes.dashboard")

            alpha.setup(theme.config)
        end,
    },
    { "ahmedkhalf/project.nvim" },
    {
        "andymass/vim-matchup",
    },
    { "RaafatTurki/hex.nvim" },
    {
        "kat0h/bufpreview.vim",
        build = "deno task prepare",
        dependencies = {
            "vim-denops/denops.vim",
        },

        config = function()
            vim.g.bufpreview_browser = "firefox"
        end,
    },
    {
        "stevearc/stickybuf.nvim",
        config = function()
            require("stickybuf").setup()
        end,
    },
}

-- vim: sw=4 sts=4 expandtab fenc=utf-8
