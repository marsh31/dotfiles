-- NAME:
-- AUTHOR: marsh
--
-- NOTE:
--
--  quickfix config.

return {
    {
        "thinca/vim-qfreplace",
        ft = { "qf" },
        cmd = "Qfreplace",
    },

    {
        "sk1418/QFGrep",
        ft = { "qf" },
        -- keymap: <leader>g, <leader>v, <leader>r
    },

    {
        "itchyny/vim-qfedit",
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
