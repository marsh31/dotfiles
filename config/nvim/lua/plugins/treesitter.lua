-- NAME:   treesitter.lua
-- AUTHOR: marsh
-- NOTE:
--
--

return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate',
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "RRethy/nvim-treesitter-textsubjects" },
      { "mfussenegger/nvim-treehopper" },
      { "David-Kunz/treesitter-unit" },

      { "yioneko/nvim-yati" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "theHamsta/nvim-treesitter-pairs" },
      { "p00f/nvim-ts-rainbow" },
      { "Dkendal/nvim-treeclimber" },

    },
    event = { 'BufRead', 'BufNewFile', 'InsertEnter' },
    cmd = { 'TSHighlightCapturesUnderCursor' },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
          disable = function(lang, bufnr)
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
            if ok and stats and stats.size > 1024 * 1024 then
              vim.notify('File too large: tree-sitter disabled.', vim.log.levels.WARN)
              return true
            end
            local ok = true
            ok = pcall(function()
              vim.treesitter.get_parser(bufnr, lang):parse()
            end) and ok
            ok = pcall(function()
              vim.treesitter.get_query(lang, 'highlights')
            end) and ok
            if not ok then
              return true
            end
            return false
          end,
          additional_vim_regex_highlighting = false,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            node_decremental = "grm",
            scope_incremental = "grc",
          },
        },
        indent = { enable = false },

        refactor = {
          highlight_definitions = { enable = false },
          highlight_current_scope = { enable = false },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "grr",
            },
          },

          navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD",
              list_definitions_toc = "gO",
              goto_next_usage = "gnu",
              goto_previous_usage = "gpu",
            },
          },
        },

        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },

        rainbow = {
          enable = true,
          extended_mode = true,
        },

        pairs = {
          enable = true,
          disable = {},
        },
      })

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

      vim.cmd.colorscheme([[kanagawa-dragon]])
    end,
  }
}



