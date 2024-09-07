-- NAME:   lua/keymaps.lua
-- AUTHOR: marsh
-- NOTE:
--  keymaps

------------------------------------------------------------
-- @config
------------------------------------------------------------
local wk = require('which-key')
local keymap = vim.keymap.set

local function nop(mode, lhs)
    vim.keymap.set(mode, lhs, '<Nop>', { silent = true, nowait = true, remap = true })
end

local function noplist(mode, list)
    for _, item in ipairs(list) do
        nop(mode, item)
    end
end

local insert_index = {
    '<C-@>',
    '<C-a>',
    '<C-b>',
    '<C-c>',
    '<C-d>',
    '<C-e>',
    '<C-f>',
    '<C-k>',
    '<C-l>',
    '<C-q>',
    '<C-s>',
    '<C-t>',
    '<C-y>',
    '<C-z>',
}

local normal_index = {
    '<BS>',
    '<C-b>',
    '<C-f>',
    '<C-g>',
    '<C-h>',
    '<C-k>',
    '<C-n>',
    '<C-p>',
    '<C-q>',
    '<C-s>',
    '<C-t>',
    '<C-y>',
    '<C-z>',
    '<Space>',
    '!',
    '!!',
    '-',
    'K',
    'Q',
    'R',
    'S',
    'U',
}

local visual_index = {
}

local command_index = {

}


-- noplist("i", insert_index)
-- noplist("n", normal_index)
-- noplist("v", visual_index)
-- noplist("c", command_index)


-- @global
------------------------------------------------------------
keymap("n", "<MiddleMouse>", "<Nop>", { silent = true, nowait = true, remap = true })
keymap("n", "<Leader>lf", vim.lsp.buf.format)
keymap("t", "<A-j><A-j>", "<C-\\><C-n>", { silent = true, nowait = true, remap = true })

keymap("n", "w", "<Plug>CamelCaseMotion_w", { silent = true, nowait = true })
keymap("n", "b", "<Plug>CamelCaseMotion_b", { silent = true, nowait = true })
keymap("n", "e", "<Plug>CamelCaseMotion_e", { silent = true, nowait = true })
keymap("n", "ge", "<Plug>CamelCaseMotion_ge", { silent = true, nowait = true })

keymap("o", "iw", "<Plug>CamelCaseMotion_iw", { silent = true, nowait = true })
keymap("x", "iw", "<Plug>CamelCaseMotion_iw", { silent = true, nowait = true })
keymap("o", "ib", "<Plug>CamelCaseMotion_ib", { silent = true, nowait = true })
keymap("x", "ib", "<Plug>CamelCaseMotion_ib", { silent = true, nowait = true })
keymap("o", "ie", "<Plug>CamelCaseMotion_ie", { silent = true, nowait = true })
keymap("x", "ie", "<Plug>CamelCaseMotion_ie", { silent = true, nowait = true })


keymap("n", "*", "*N", { desc = "highlight cursor word", silent = true, nowait = true, remap = true })

keymap("n", "ga", "<Plug>(EasyAlign)", { silent = true, nowait = true, remap = true })
keymap("x", "ga", "<Plug>(EasyAlign)", { silent = true, nowait = true, remap = true })

keymap("n", "]b", "<Cmd>bnext<CR>", { desc = "jump to next buffer", silent = true, nowait = true, remap = true })
keymap("n", "[b", "<Cmd>bprevious<CR>", { desc = "jump to previous buffer", silent = true, nowait = true, remap = true })

keymap("n", "]q", "<Cmd>cnext<CR>", { desc = "jump next quickfix" })
keymap("n", "[q", "<Cmd>cprevious<CR>", { desc = "jump previous quickfix" })

keymap("n", "]d", vim.diagnostic.goto_next, { desc = "jump next diagnostic" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "jump prev diagnostic" })


wk.register({
    ["<C-c>"] = { "<ESC>", "escape" },

    ["s"] = {
        ["s"] = {
            ["b"] = { "<cmd>HopWord<CR>", "hop words in buffer" },
            ["c"] = { "<cmd>HopChar1<CR>", "hop character in buffer" },
            ["l"] = { "<cmd>HopLineStart<CR>", "hop line in buffer" },
            ["s"] = {
                function()
                    require("hop").hint_words({
                        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
                        current_line_only = true,
                    })
                end,
                "hop line char in buffer",
            },
            ["*"] = {
                function()
                    vim.api.nvim_exec([[normal! "ayiw]], true)

                    local sword = vim.api.nvim_exec("echo @a", true)
                    require("hop").hint_patterns({}, sword)
                end,
                "hop pattern use * in buffer",
            },
        },
    },

    ["<Leader>"] = {
        ["a"] = { -- toggle
            name = "toggle",
            ["a"] = { "<cmd>AerialToggle!<CR>", "Toggle Aerial" },
        },

        ["d"] = { name = "disable feature" },
        ["dc"] = { "<cmd>nohlsearch<CR>", "Disable Highlight" },
        ["de"] = { "<cmd>NvimTreeClose<CR>", "Close Nvimtree" },

        ["e"] = { -- explorer
            -- ["d"] = { "<Cmd>Fern . -drawer<CR><C-w>=", "Open filer" },
            -- ["D"] = { "<Cmd>Fern . -drawer -reveal=%<CR><C-w>=", "Open filer" },
            --
            -- ["w"] = { "<Cmd>Fern . -reveal=%<CR><C-w>=", "Open filer in current window" },
            -- ["W"] = { "<Cmd>Fern .<CR>", "Open filer in current window" },
            --
            -- ["l"] = { "<Cmd>vertical rightbelow split | Fern . -reveal=%<CR><C-w>=", "Open filer in left window" },
            -- ["L"] = { "<Cmd>vertical rightbelow split | Fern .<CR>", "Open filer in right window" },
            --
            -- ["h"] = { "<Cmd>vertical leftabove split | Fern . -reveal=%<CR><C-w>=", "Open filer in left window" },
            -- ["H"] = { "<Cmd>vertical leftabove split | Fern .<CR>", "Open filer in right window" },
            --
            -- ["j"] = { "<Cmd>rightbelow split | Fern . -reveal=%<CR><C-w>=", "Open filer in below window" },
            -- ["J"] = { "<Cmd>rightbelow split | Fern .<CR>", "Open filer in below window" },
            --
            -- ["k"] = { "<Cmd>leftabove split | Fern . -reveal=%<CR><C-w>=", "Open filer in above window" },
            -- ["K"] = { "<Cmd>leftabove split | Fern .<CR>", "Open filer in above window" },
            --
            -- ["o"] = { "<Cmd>vertical botright split | Fern . -reveal=%<CR><C-w>=", "Open filer in left window" },
            -- ["O"] = { "<Cmd>vertical botright split | Fern .<CR>", "Open filer in right window" },
            --
            -- ["y"] = { "<Cmd>vertical topleft split | Fern . -reveal=%<CR><C-w>=", "Open filer in left window" },
            -- ["Y"] = { "<Cmd>vertical topleft split | Fern .<CR>", "Open filer in right window" },
            --
            -- ["u"] = { "<Cmd>botright split | Fern . -reveal=%<CR><C-w>=", "Open filer in below window" },
            -- ["U"] = { "<Cmd>botright split | Fern .<CR>", "Open filer in below window" },
            --
            -- ["i"] = { "<Cmd>topleft split | Fern . -reveal=%<CR><C-w>=", "Open filer in above window" },
            -- ["I"] = { "<Cmd>topleft split | Fern .<CR>", "Open filer in above window" },
            --
            -- ["n"] = { "<Cmd>enew<CR>", "New File" },
            ["w"] = { "<Cmd>Oil<CR>", "Open current buffer parent" },
            ["l"] = { "<Cmd>vertical rightbelow split | Oil<CR>", "Open oil buffer right current buffer." },
            ["h"] = { "<Cmd>vertical leftabove  split | Oil<CR>", "Open oil buffer left current buffer." },
            ["j"] = { "<Cmd>rightbelow split | Oil<CR>", "Open oil buffer below current buffer." },
            ["k"] = { "<Cmd>leftabove  split | Oil<CR>", "Open oil buffer above current buffer." },
        },

        ["g"] = { -- go
            name = "go",

            ["q"] = { "<cmd>copen<CR>", "go quickfix window" },
        },

        ["r"] = { "<cmd>source %<CR>", "load the buffer file" },

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
            -- ["f"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "formatting" },
            ["r"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
        },
    },
}, {
    mode = "n",
})


------------------------------------------------------------
-- @insert mode
------------------------------------------------------------
keymap("i", "jj", "<ESC>", { silent = true, nowait = true, remap = true })
keymap("i", "<A-j><A-j>", "<ESC>", { silent = true, nowait = true, remap = true })

keymap("i", "<middleMouse>", "<Nop>", { silent = true, nowait = true, remap = true })

keymap("i", "<C-a>", "<Home>")
keymap("i", "<C-e>", "<End>")
keymap("i", "<C-l>", "<C-g>u<C-o>:update<CR>")

keymap("i", ",", ",<C-g>u")
keymap("i", ".", ".<C-g>u")
keymap("i", ";", ";<C-g>u")

------------------------------------------------------------
-- @operator
------------------------------------------------------------
keymap("o", "i8", "i(", { silent = true, nowait = true, remap = false })
keymap("o", "i9", "i)", { silent = true, nowait = true, remap = false })
keymap("o", "i2", 'i"', { silent = true, nowait = true, remap = false })
keymap("o", "i7", "i'", { silent = true, nowait = true, remap = false })
keymap("o", "i@", "i`", { silent = true, nowait = true, remap = false })


keymap("o", "a8", "a(", { silent = true, nowait = true, remap = false })
keymap("o", "a9", "a)", { silent = true, nowait = true, remap = false })
keymap("o", "a2", 'a"', { silent = true, nowait = true, remap = false })
keymap("o", "a7", "a'", { silent = true, nowait = true, remap = false })
keymap("o", "a@", "a`", { silent = true, nowait = true, remap = false })



keymap("n", "vi8", "vi(", { silent = true, nowait = true, remap = false })
keymap("n", "vi9", "vi)", { silent = true, nowait = true, remap = false })
keymap("n", "vi2", 'vi"', { silent = true, nowait = true, remap = false })
keymap("n", "vi7", "vi'", { silent = true, nowait = true, remap = false })
keymap("n", "vi@", "vi`", { silent = true, nowait = true, remap = false })

keymap("n", "va8", "va(", { silent = true, nowait = true, remap = false })
keymap("n", "va9", "va)", { silent = true, nowait = true, remap = false })
keymap("n", "va2", 'va"', { silent = true, nowait = true, remap = false })
keymap("n", "va7", "va'", { silent = true, nowait = true, remap = false })
keymap("n", "va@", "va`", { silent = true, nowait = true, remap = false })

keymap("n", "*", "*N", { silent = true, nowait = true, remap = false })



------------------------------------------------------------
-- @cmdline
------------------------------------------------------------
keymap("c", "<C-a>", "<C-b>", { desc = "Move to top" })
keymap("c", "<C-e>", "<C-e>", { desc = "Move to tail" })
keymap("c", "<C-b>", "<Left>", { desc = "Move to left" })
keymap("c", "<C-f>", "<Right>", { desc = "Move to right" })

keymap("c", "<C-k>", "<C-f><Esc>", { desc = "Move to cmdline window" })

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
                ["o"] = { "<cmd>lua require('nvim_qf_helper').edit()<CR>", "edit" },

                ["<C-o>"] = { "<cmd>lua require('nvim_qf_helper').edit()<CR>", "edit" },
                ["<C-v>"] = { "<cmd>lua require('nvim_qf_helper').vsplit()<CR>", "vsplit" },
                ["<C-x>"] = { "<cmd>lua require('nvim_qf_helper').vsplit()<CR>", "split" },
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
