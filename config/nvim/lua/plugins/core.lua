

return {
  {
    'folke/lazy.nvim',
    cmd = { 'Lazy', 'LazyAll' },
    init = function()
      vim.keymap.set({ 'n' }, '<leader>L', '<Cmd>Lazy<CR>')

      -- Load all plugins
      local did_load_all = false
      vim.api.nvim_create_user_command('LazyAll', function()
        if did_load_all then
          return
        end

        local specs = require('lazy').plugins()
        local names = {}
        for _, spec in pairs(specs) do
          if spec.lazy and not spec['_'].loaded and not spec['_'].dep then
            table.insert(names, spec.name)
          end
        end
        require('lazy').load({ plugins = names })
        did_load_all = true
      end, {})
    end,
  },

  { 'tani/vim-artemis' },
  { 'kana/vim-operator-user' },
  { 'kana/vim-textobj-user' },
  { 'tpope/vim-repeat', event = { 'VeryLazy' } },
  {
    'stevearc/dressing.nvim',
    event = { 'VeryLazy' },
    config = function()
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'DressingInput' },
        callback = function()
          vim.keymap.set({ 'n' }, 'q', '<Cmd>quit<CR>', { buffer = true })
        end,
      })
    end,
  },
  {
    "rest-nvim/rest.nvim" ,
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { "VeryLazy" },
    config = function ()
      require("rest-nvim").setup({
        result_split_horizontal = true,
        result_split_in_place = false,
        skip_ssl_verification = false,
        encode_url = true,
      })
    end
  },

  { 'MunifTanjim/nui.nvim' },
  { 'nvim-lua/plenary.nvim' },
  {
    'rcarriga/nvim-notify',
    event = { 'VeryLazy' },
    config = function()
      require('notify').setup({ stages = 'static' })

      -- NOTE: override vim.notify
      vim.notify = function(...)
        vim.notify = require('notify')
        vim.notify(...)
      end

      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'notify' },
        callback = function()
          vim.keymap.set({ 'n' }, 'q', '<Cmd>quit<CR>', { buffer = true })
        end,
      })
    end,
  },
}

