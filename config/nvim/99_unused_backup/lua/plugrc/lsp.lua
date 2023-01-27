------------------------------------------------------------
-- FILE:   lua/init.lua
-- AUTHOR: marsh
--
-- Initial config file for lua settings.
--
-- NOTE:
-- - 'neovim/nvim-lspconfig'
-- - 'tami5/lspsaga.nvim'
-- - 'ray-x/lsp_signature.nvim'
-- - 'folke/trouble.nvim'
-- - 'liuchengxu/vista.vim'
--
-- TODO:
-- - TODO: keymap
-- - TODO: set more lspconfig
-- - TODO: set lspsaga.nvim
-- - TODO: set lsp_signature
-- - TODO: set config trouble.nvim
--
-- If this file is fat, make lua/plugrc/lsp/xxx.lua and
-- after that, it divided into their files.
------------------------------------------------------------


------------------------------------------------------------
-- nvim-lspconfig
------------------------------------------------------------
local lsp_installer = require('nvim-lsp-installer')


------------------------------------------------------------
-- nvim-lspconfig
------------------------------------------------------------
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '[d',        '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d',        '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_qflist()<CR>', opts)
    buf_set_keymap('n', '<space>f',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


local servers = {
    'bashls',         -- Install `sudo ...?`
    'clangd',         -- Install `sudo pacman -S clang`.
    -- 'html',           -- Install `sudo npm i -g vscode-langservers-extracted`
    -- 'eslint',         -- Install `sudo npm i -g vscode-langservers-extracted`
    'pyright',        -- Install `sudo npm install -g pyright`
    -- 'rls',            -- Installed with rustc.
    -- 'rust-analyzer',  -- Install `sudo pacman -S rust-analyzer`
    -- 'sumneko_lua',  -- Install is hard. See https://github.com/sumneko/lua-language-server/wiki/Build-and-Run
    'vimls'             -- vimls
}


nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})


-- need to set config of completion.lua before it.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },

        handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
            }
            ),
        },
    }
end


require('lspconfig').sumneko_lua.setup{
    capabilities = capabilities,
    cmd = {
        os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"
    },
    filetypes = { "lua" },
    root_dir = bufdir,
    settings = {
        Lua = {
            telemetry = {
                enable = false,
            },
        }
    },

    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
        }
        ),
    },
    single_file_support = true
}



------------------------------------------------------------
-- vista.vim
------------------------------------------------------------
vim.g.vista_sidebar_position = "vertical botright"
vim.g.vista_sidebar_width = 40
vim.g.vista_sidebar_open_cmd = "40vsplit"
vim.g.vista_sidebar_keepalt = 1

vim.g.vista_default_executive = "nvim_lsp"


-- vim: sw=4 sts=4 expandtab fenc=utf-8
