--
-- NAME:   lua/modules/lsp/init.lua
-- AUTHOR: marsh
-- NOTE:
--
--
--

-- lsp
local lsp_config = require('lspconfig')

-- installer
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- linter and formatter
local mason_null_ls = require('mason-null-ls')
local null_ls = require('null-ls')

-- other
require('lspsaga').setup()
-- require('lspkind-nvim').init({ ... })
require('lsp_signature').setup({ hint_enable = false })
require('dressing').setup()
require('fidget').setup()


mason.setup()

--
-- lsp
--
mason_lspconfig.setup({
    ensure_installed = {
        "sumneko_lua"
    },

    automatic_installation = true,
})



--
-- linter and formatter
--   null-ls
--
mason_null_ls.setup({
    ensure_installed = {
        'stylua',
        "jq",
    },
    automatic_installation = true,
})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
    }
})


-- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
--    pattern = { '*' },
--    callback = function()
--        require("lspsaga.diagnostic").show_cursor_diagnostics()
--    end
--})



-- vim: sw=4 sts=4 expandtab fenc=utf-8
