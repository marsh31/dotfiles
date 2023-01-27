-- NAME:   lsp.lua
-- AUTHOR: marsh31
-- NOTE:
-- installer:
--    install `clangd` or `clang-tools` or `llvm`.
--    go install golang.org/x/tools/gopls@latest
--    npm install -g vim-language-server
--    npm install -g typescript typescript-language-server
--    npm install -g @ansible/ansible-language-server
--    each env is diff to install rust-analyzer
--    npm install -g vscode-langservers-extracted
--    npm install -g vscode-langservers-extracted
--    yarn global add yaml-language-server
--

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_init = function(client)
  client.config.flags = {}
  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
    client.config.flags.debounce_text_changes = 200
  end
end

require'lspconfig'.clangd.setup {
  on_init = on_init;
  capabilities = capabilities;
}
require'lspconfig'.gopls.setup {
  capabilities = capabilities,
  on_init = on_init;
  init_options = {
    gofumpt = true,
    usePlaceholders = true,
    semanticTokens = true,
    staticcheck = true,
    experimentalPostfixCompletions = true,
    hoverKind = 'Structured',
    analyses = {
      nilness = true,
      shadow = true,
      unusedparams = true,
      unusedwrite = true,
      fieldalignment = true
    },
    codelenses = {
      gc_details = true,
      tidy = true
    }
  }
}
require'lspconfig'.vimls.setup {
  on_init = on_init;
  capabilities = capabilities,
}
require'lspconfig'.tsserver.setup {
  on_init = on_init;
  capabilities = capabilities,
  on_attach = function(client)
    client.resolved_capabilities.documentFormattingProvider = false
  end,
}
require'lspconfig'.ansiblels.setup{
  on_init = on_init;
  capabilities = capabilities,
}
require'lspconfig'.rust_analyzer.setup {
  on_init = on_init;
  capabilities = capabilities,
}
require'lspconfig'.intelephense.setup {
  on_init = on_init;
  capabilities = capabilities,
  settings = {
    intelephense = {
      format = {
        braces = 'k&r'
      }
    }
  }
}
require'lspconfig'.cssls.setup {
  on_init = on_init;
  capabilities = capabilities,
}
require'lspconfig'.html.setup {
  on_init = on_init;
  capabilities = capabilities,
}
require'lspconfig'.jsonls.setup {
  on_init = on_init;
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}
require'lspconfig'.yamlls.setup {
  on_init = on_init;
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}
require'lspconfig'.eslint.setup {
  on_init = on_init,
  capabilities = capabilities,
}
require'lspconfig'.sumneko_lua.setup {
  on_init = on_init,
  cmd = { 
        os.getenv("HOME") .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = {
        globals = { 'vim', 'before_each', 'after_each', 'describe', 'it' },
      },
      workspace = {
        library = vim.tbl_values(vim.g.vimrc.pkg.paths),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.diagnostic.config({
  virtual_text = false,
})
vim.cmd([[
  nnoremap <silent> <Leader>gdo  <Cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> <Leader>gdv  <Cmd>vsplit<CR><Cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> <Leader>gds  <Cmd>split<CR><Cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> <Leader>gr   <Cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> <Leader>f    <Cmd>lua vim.lsp.buf.formatting()<CR>
  nnoremap <silent> <Leader>r    <Cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <silent> <Leader>d    <Cmd>lua vim.lsp.diagnostic.set_qflist()<CR>
  nnoremap <silent> <C-k>        <Cmd>lua vim.lsp.buf.hover()<CR>

  nnoremap <silent> [d           <Cmd>lua vim.diagnostic.goto_prev()<CR>
  nnoremap <silent> ]d           <Cmd>lua vim.diagnostic.goto_next()<CR>
]])
  -- nnoremap <silent> <C-k>        <Cmd>lua vim.diagnostic.goto_prev()<CR>
  -- nnoremap <silent> <C-j>        <Cmd>lua vim.diagnostic.goto_next()<CR>
  -- nnoremap <silent> <Leader><CR> <Cmd>lua vim.lsp.buf.code_action()<CR>

if require('jetpack').tap('nvim-exp') == 1 then
  require('exp').setup({
    location = {
      window = function()
        local winnrs = vim.fn['vimrc#filter_winnrs'](vim.fn['vimrc#get_special_filetypes']())
        if vim.tbl_contains(winnrs, vim.fn.winnr()) then
          return vim.api.nvim_get_current_win()
        end
        if #winnrs == 1 then
          return vim.fn.win_getid(winnrs[1])
        end
        local winnr = vim.fn['choosewin#start'](winnrs, {
          auto_choose = 1,
          blink_on_land = 0,
          noop = 1
        })
        return vim.fn.win_getid(winnr[2])
      end
    }
  })
  vim.cmd([[
    nnoremap <silent> gf<CR> <Cmd>lua require('exp').goto_definition({ cmd = 'edit' })<CR>
    nnoremap <silent> gfv    <Cmd>lua require('exp').goto_definition({ cmd = 'vsplit' })<CR>
    nnoremap <silent> gfs    <Cmd>lua rqquire('exp').goto_definition({ cmd = 'split' })<CR>
  ]])
end
