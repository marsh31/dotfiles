-- NAME:
-- AUTHOR: marsh
--
-- NOTE:
--
--  quickfix config.

return {
    {
        "thinca/vim-qfreplace",
        cond = true,
        ft = { "qf" },
        cmd = "Qfreplace",
    },

    {
        "sk1418/QFGrep",
        cond = true,
        ft = { "qf" },
        -- keymap: <leader>g, <leader>v, <leader>r
    },

    {
        -- この設定を入れるとquickfixtextfuncがうまく行かない。消えたりする
        "itchyny/vim-qfedit",
        cond = false,
        ft = { "qf" },
    },

    -- {
    --     "thinca/vim-qfhl",
    --     event = { "VeryLazy" },
    -- },

    -- {
    --     "ten3roberts/qf.nvim",
    --     event = { "VeryLazy" },
    -- },
}

-- vim: ft=lua sts=4 expandtab fenc=utf-8
