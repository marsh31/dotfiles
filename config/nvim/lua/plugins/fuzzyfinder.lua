-- NAME:
-- AUTHOR: marsh
-- NOTE:
--
-- <C-n>/<Down>  Next item
-- <C-p>/<Up>    Previous item
-- j/k           Next/previous (in normal mode)
-- H/M/L         Select High/Middle/Low (in normal mode)
-- gg/G          Select the first/last item (in normal mode)
-- <CR>          Confirm selection
-- <C-x>         Go to file selection as a split
-- <C-v>         Go to file selection as a vsplit
-- <C-t>         Go to a file in a new tab
-- <C-u>         Scroll up in preview window
-- <C-d>         Scroll down in preview window
-- <C-/>         Show mappings for picker actions (insert mode)
-- ?             Show mappings for picker actions (normal mode)
-- <C-c>         Close telescope
-- <Esc>         Close telescope (in normal mode)
-- <Tab>         Toggle selection and move to next selection
-- <S-Tab>       Toggle selection and move to prev selection
-- <C-q>         Send all items not filtered to quickfixlist (qflist)
-- <M-q>         Send all selected items to qflist


return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },

      -- other plugins
      { "nvim-telescope/telescope-ghq.nvim" },
      { "nvim-telescope/telescope-frecency.nvim" },
      { "LinArcX/telescope-command-palette.nvim" },
    },
    cmd = { 'Telescope' },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy  = "horizontal",
          layout_config    = {
            -- prompt_position = "top"
          },
        },

        pickers = {
          buffers = {
            mappings = {
              i = {
                ["<M-d>"] = actions.delete_buffer + actions.move_to_top,
              }
            }
          }
        },

        extensions = {
          command_palette = {
            { "File",
              { "File explorer", "<cmd>Fern ." },
              { "File selector", "<cmd>Telescope find_files", },
            },
            { "Help",
              { "File selector", "<cmd>Telescope notify", },
            },
          }
        }
      })


      require("telescope").load_extension("ghq")
      require("telescope").load_extension("frecency")
      require('telescope').load_extension('command_palette')
      require('telescope').load_extension('notify')
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
  },
}
