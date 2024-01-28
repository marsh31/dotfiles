local devpath = "~/src/vimscript/vim-todotxt/"
local todotxt = {}
if vim.fn.isdirectory(vim.fn.expand(devpath)) ~= 0 then
    todotxt = { dir = "~/src/vimscript/vim-todotxt/" }
else
    todotxt = { "marsh31/vim-todotxt" }
end

local colorselector_devpath = "~/src/vimscript/vim-colorselector/"
local colorselector = {}
if vim.fn.isdirectory(vim.fn.expand(colorselector_devpath)) ~= 0 then
    colorselector = { dir = "~/src/vimscript/vim-colorselector/" }
else
    colorselector = { "marsh31/vim-colorselector" }
end

return {
    -- {
    --     "folke/neodev.nvim",
    --     opts = {},
    --     ft = { "lua" },
    -- },

    {
        "notomo/lreload.nvim",
        ft = { "lua" },
        config = function()
            require("lreload").enable("dev/qfapp")
        end,
    },
    { "marsh31/nvim-lua-logger" },
    todotxt,
    colorselector,

    --  {
    --    dir = "~/src/project/nvim-qf-helper",
    --    config = function()
    --      require("nvim_qf_helper").setup()
    --      require("lreload").enable("nvim_qf_helper")
    --      require("lreload").enable("dev")
    --      require("lreload").enable("dev/rg")
    --      require("lreload").enable("dev/nvim-submode")
    --      require("lreload").enable("dev/sample")
    --    end,
    --  },
    --  {
    --    dir = "~/src/project/nvim-lua-logger",
    --    config = function()
    --      require("lreload").enable("nvim_lua_logger")
    --      require("nvim_lua_logger").setup()
    --    end,
    --  },
}

-- vim: sw=4 sts=4 expandtab fenc=utf-8
