-- NAME:   oil.lua
-- NOTE:
--
--
--

return {
  {
    -- /home/marsh/til/learn/memo/fleeting/20240512115646.md
    "stevearc/oil.nvim",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond = true,
    opts = {
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
      experimental_watch_for_changes = true,
      keymaps = {
        ["<Leader>t"] = "actions.open_terminal",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["gd"] = {
          desc = "Toggle detail view",
          callback = function()
            local oil = require("oil")
            local config = require("oil.config")
            if #config.columns == 1 then
              oil.set_columns({ "icon", "permissions", "size", "mtime" })
            else
              oil.set_columns({ "icon" })
            end
          end,
        },
        ["g?"] = "actions.show_help",
      },
      use_default_keymaps = false,
    },
    config = function(_, opts)
      local oil = require("oil")
      oil.setup(opts)

      local function grep_ce()
        local oil = require("oil")
        local cdir = oil.get_current_dir()
        if cdir ~= nil then
        end
      end
    end,
  },
}
