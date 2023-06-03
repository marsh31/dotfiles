--
-- NAME:   lsp.vim
-- AUTHOR: marsh
-- NOTE:

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "folke/neodev.nvim" },
    },
    config = function()
      local lsp_config = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          local opts = {
            -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
            capabilities = require("cmp_nvim_lsp").default_capabilities(),

            handlers = {
              ["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                  virtual_text = false,
                }
              ),
            },
          }

          lsp_config[server_name].setup(opts)
        end,

        ["lua_ls"] = function()
          lsp_config.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },

                runtime = {
                  version = "Lua 5.1",
                },

                completion = {
                  callSnippet = "Replace"
                }
              },
            },
          })
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      { "jayp0521/mason-null-ls.nvim" },
    },

    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      -- linter and formatter
      local mason_null_ls = require("mason-null-ls")
      local null_ls = require("null-ls")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          -- lsp
          "bashls", -- bash
          "clangd", -- clang
          "dockerls", -- docker
          "dotls", -- dot
          "lua_ls",
          "gopls", -- go
          "html", -- html
          "jsonls", -- json
          "tsserver", -- javascript/typescript
          "rust_analyzer", -- rust
        },

        automatic_installation = true,
      })

      mason_null_ls.setup({
        ensure_installed = {
          "stylua",
          "jq",
        },
        automatic_installation = true,
        automatic_setup = true,
      })
      -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  {
    "tami5/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        code_action_prompt = {
          virtual_text = false,
        },
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        hint_enable = false,
      })
    end,
  },
  { "folke/trouble.nvim" },
}
