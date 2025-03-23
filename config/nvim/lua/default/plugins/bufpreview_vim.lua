return {
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
}
