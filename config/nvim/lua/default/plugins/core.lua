-- NAME:   core.lua
-- AUTHOR: marsh
--
-- NOTE:
--

return {
    -- plugin manager
    {
        "folke/lazy.nvim",
        cmd = { "Lazy", "LazyAll" },
        init = function()
            vim.keymap.set({ "n" }, "<leader>L", "<Cmd>Lazy<CR>")

            -- Load all plugins
            local did_load_all = false
            vim.api.nvim_create_user_command("LazyAll", function()
                if did_load_all then
                    return
                end

                local specs = require("lazy").plugins()
                local names = {}
                for _, spec in pairs(specs) do
                    if spec.lazy and not spec["_"].loaded and not spec["_"].dep then
                        table.insert(names, spec.name)
                    end
                end
                require("lazy").load({ plugins = names })
                did_load_all = true
            end, {})
        end,
    },

    -- vim
    { "vim-jp/vimdoc-ja", event = { "VeryLazy" } },
    { "tpope/vim-repeat", event = { "VeryLazy" } },
    { "tani/vim-artemis", event = { "VeryLazy" } },
    { "kana/vim-operator-user", event = { "VeryLazy" } },
    { "kana/vim-textobj-user", event = { "VeryLazy" } },
    { 'vim-denops/denops.vim', lazy = false },

    -- nvim
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-lua/popup.nvim", lazy = true },
    { "kkharji/sqlite.lua", event = { "VeryLazy" } },
    { "MunifTanjim/nui.nvim", event = { "VeryLazy" } },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        config = function()
            require("notify").setup({
                stages = "static",
                timeout = 3000,
            })

            vim.notify = function(...)
                vim.notify = require("notify")
                vim.notify(...)
            end

            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = { "notify" },
                callback = function()
                    vim.keymap.set({ "n" }, "q", "<Cmd>quit<CR>", { buffer = true })
                end,
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = { "VeryLazy" },
        config = function()
            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = { "DressingInput" },
                callback = function()
                    vim.keymap.set({ "n" }, "q", "<Cmd>quit<CR>", { buffer = true })
                end,
            })
        end,
    },
    {
        "rest-nvim/rest.nvim",
        event = { "VeryLazy" },
        config = function()
            require("rest-nvim").setup({
                result_split_horizontal = true,
                result_split_in_place = false,
                skip_ssl_verification = false,
                encode_url = true,
            })
        end,
    },
}

-- vim: ft=lua tabstop=4 shiftwidth=4
