return {
    {
        "kat0h/bufpreview.vim",
        build = "deno task prepare",
        cond = false,
        dependencies = {
            "vim-denops/denops.vim",
        },

        config = function()
            vim.g.bufpreview_browser = "firefox"
        end,
    },
}
