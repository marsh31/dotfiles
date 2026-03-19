-- NAME:   core.lua
-- AUTHOR: marsh
--
-- NOTE:
--

return {
    -- plugin manager
    {
        "folke/lazy.nvim",
        cmd = { "Lazy" },
        init = function()
            vim.keymap.set({ "n" }, "<leader>L", "<Cmd>Lazy<CR>", { desc = "Open Lazy" })

            -- Load all plugins
            local group = vim.api.nvim_create_augroup("my_lazy_all", { clear = true })
            vim.api.nvim_create_user_command("LazyAll", function()
                local lazy = require("lazy")
                local names = {}

                for _, spec in pairs(lazy.plugins()) do
                    if spec.lazy and not spec._.loaded and not spec._.dep then
                        table.insert(names, spec.name)
                    end
                end

                if #names > 0 then
                    lazy.load({ plugins = names })
                end
            end, {})
        end,
    },

    -- vim
    { "vim-jp/vimdoc-ja", lazy = false },
    { "tpope/vim-repeat", lazy = false },
    { "tani/vim-artemis", event = { "VeryLazy" } },
    { "vim-denops/denops.vim", lazy = false },

    { "kana/vim-operator-user", lazy = false },
    { "kana/vim-textobj-user", lazy = false },

    -- nvim
    { "nvim-lua/plenary.nvim", lazy = true },
    { "kkharji/sqlite.lua", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        opts = {
            stages = "static",
            timeout = 3000,
        },
        init = function()
            local orig = vim.notify
            vim.schedule_wrap(function(...)
                local ok, n = pcall(require, "notify")
                vim.notify = ok and n or orig
                vim.notify(...)
            end)
        end,
        config = function()
            local grp = vim.api.nvim_create_augroup("notify_q_close", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = grp,
                pattern = "notify",
                callback = function(args)
                    vim.keymap.set("n", "q", "<Cmd>quit<CR>", { buffer = args.buf, silent = true })
                end,
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        opts = {},
        init = function()
            local function lazy_require(func)
                return function(...)
                    require("dressing")[func](...)
                end
            end

            vim.ui.select = lazy_require("select")
            vim.ui.input = lazy_require("input")
        end,
        config = function()
            local grp = vim.api.nvim_create_augroup("dressing_q_close", { clear = true })
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = grp,
                pattern = { "DressingInput" },
                callback = function()
                    vim.keymap.set({ "n" }, "q", "<Cmd>quit<CR>", { buffer = true })
                end,
            })
        end,
    },
    {
        "rest-nvim/rest.nvim",
        ft = { "http" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            result_split_horizontal = true,
            result_split_in_place = false,
            skip_ssl_verification = false,
            encode_url = true,
        },
        config = function()
            local grp = vim.api.nvim_create_augroup("rest_nvim_keys", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "http",
                group = grp,
                callback = function(ev) 
                    local map = function (lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
                    end
                    map("<Leader>rr", "<Plug>RestNvim",        "REST: Run request under cursor")
                    map("<Leader>rl", "<Plug>RestNvimLast",    "REST: Re-run last")
                    map("<Leader>rp", "<Plug>RestNvimPreview", "REST: Preview cURL")
                end,
            })
        end,
    },
}

-- vim: ft=lua tabstop=4 shiftwidth=4
