-- NAME:   lua/keymaps.lua
-- AUTHOR: marsh
-- NOTE:
--  keymaps

------------------------------------------------------------
-- @config
------------------------------------------------------------
local wk = require("which-key")
local keymap = vim.keymap.set

------------------------------------------------------------
-- @global
------------------------------------------------------------

keymap("", "<MiddleMouse>", "<Nop>", { silent = true, nowait = true, remap = true })
keymap("i", "<middleMouse>", "<Nop>", { silent = true, nowait = true, remap = true })
keymap("i", "jj", "<ESC>", { silent = true, nowait = true, remap = true })

wk.register({
    ["<C-c"] = { "<ESC>", "escape" },

    ["s"] = {
        -- ["a"] = {},
        -- ["as"] = {},
        -- ["A"] = {}.
        -- ["AS"] = {},

        ["s"] = {
            ["b"] = { "<cmd>HopWord<CR>", "hop words in buffer" },
            ["c"] = { "<cmd>HopChar1<CR>", "hop character in buffer" },
            ["l"] = { "<cmd>HopLineStart<CR>", "hop line in buffer" },
            ["s"] = { function()
                require("hop").hint_words({
                    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
                    current_line_only = true
                })
            end, "hop line char in buffer" },
            ["*"] = { function()
                vim.api.nvim_exec([[normal! "ayiw]], true)

                local sword = vim.api.nvim_exec('echo @a', true)
                require("hop").hint_patterns({}, sword)
            end, "hop pattern use * in buffer" }
        },
    },

    ["<Leader>"] = {
        ["a"] = { -- toggle
            name = "toggle",
            ["a"] = { "<cmd>AerialToggle!<CR>", "Toggle Aerial" },
        },

        ["d"] = { name = "disable feature" },
        ["dc"] = { "<cmd>nohlsearch<CR>", "Disable Highlight" },

        ["e"] = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
        ["f"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "formatting" },

        ["g"] = { -- go
            name = "go",
        },

        ["r"] = { "<cmd>source %<CR>", "load the buffer file" },
        ["s"] = { -- search
            name = "search",
            ["b"] = { "<cmd>Telescope buffers<CR>", "Search buffers" },
            ["f"] = { "<cmd>Telescope find_files hidden=true<CR>", "Search file" },
            ["g"] = { "<cmd>Telescope grep_string<CR>", "Grep" },
            ["p"] = { "<cmd>Telescope ghq list<CR>", "Search git repo" },
            ["o"] = { "<cmd>Telescope aerial<CR>", "Search Outline" },
            ["r"] = { "<cmd>Telescope oldfiles<CR>", "Search Recent File" },
        },

        ["l"] = { -- lsp
            name = "lsp",
            ["a"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "code action" },
            ["d"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "show diagnostic" },
            ["g"] = {
                ["r"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "lsp reference" },
                ["d"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "lsp definition" },
                ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "lsp declaration" },
                ["i"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "lsp implementation" },
                ["t"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "lsp show type definition" },
            },
            ["k"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "hover" },
            ["f"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "formatting" },
            ["r"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "rename" },
        },
    },

    ["["] = {
        ["g"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "go to previous diagnostic error" },
    },

    ["]"] = {
        ["g"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "go to next diagnostic error" },
    },
}, {
    mode = "n",
})




------------------------------------------------------------
-- @buffer
------------------------------------------------------------
vim.api.nvim_create_augroup("my_filetype_keymapping", {})
vim.api.nvim_create_autocmd("FileType", {
    group = "my_filetype_keymapping",
    pattern = "*",
    callback = function()
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")
        local filename = vim.fn.expand("%")
        local nopts = { mode = "n", buffer = 0 }
        local iopts = { mode = "i", buffer = 0 }

        if filetype == "qf" then
            wk.register({
                ["<Leader>q"] = { "<cmd>quit<CR>", "exit quickfix window" },
                ["q"] = { "<cmd>quit<CR>", "exit quickfix window" },
            }, nopts)
        elseif filetype == "vim" then
            if filename == "[Command Line]" then
                wk.register({
                    ["<Leader>q"] = { "<cmd>quit<CR>", "exit command line window" },
                    ["<C-c>"] = { "<cmd>quit<CR>", "exit command line window" },
                    ["q"] = { "<cmd>quit<CR>", "exit command line window" },
                    ["/"] = { "G?", "Search previous history" },
                    ["?"] = { "G?", "Search next history" },
                }, nopts)

                wk.register({
                    ["<C-c>"] = { "<ESC><cmd>quit<CR>", "exit command line window" },
                }, iopts)
            end
        end
    end,
})

-- vim: sw=4 sts=4 expandtab fenc=utf-8
