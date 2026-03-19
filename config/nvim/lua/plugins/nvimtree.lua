
local list = require("default.pluginlist").get_list()
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cond = false, -- 使わないため、OK。
    config = function()
      local lib = require("nvim-tree.lib")
      local view = require("nvim-tree.view")

      local function collapse_all()
        require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
      end

      local function edit_or_open()
        local action = "edit"
        local node = lib.get_node_at_cursor()

        if node.link_to and node.nodes then
          require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
          view.close()
        elseif node.nodes ~= nil then
          lib.expand_or_collapse(node)
        else
          require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
          view.close()
        end
      end

      local function edit_or_open_and_not_close()
        local action = "edit"
        local node = lib.get_node_at_cursor()

        if node.link_to and node.nodes then
          require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
        elseif node.nodes ~= nil then
          lib.expand_or_collapse(node)
        else
          require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
        end
      end

      local function vsplit_preview()
        local action = "vsplit"
        local node = lib.get_node_at_cursor()

        if node.link_to and not node.nodes then
          require("nvim-tree.action.node.open-file").fn(action, node.link_to)
        elseif node.nodes ~= nil then
          lib.expand_or_collapse(node)
        else
          require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
        end

        view.focus()
      end

      require("nvim-tree").setup({
        view = {
          width = 30,
          mappings = {
            custom_only = true,
            list = {
              { key = "<CR>", action = "edit", action_cb = edit_or_open_and_not_close },
              { key = "o", action = "open" },
              { key = "<C-e>", action = "edit_in_place" },
              { key = "O", action = "edit_no_picker" },
              { key = "<C-]>", action = "cd" },
              { key = "l", action = "edit", action_cb = edit_or_open },
              { key = "h", action = "close_node" },
              { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
              { key = "H", action = "collapse_all", action_cb = collapse_all },
              { key = "<C-v>", action = "vsplit" },
              { key = "<C-x>", action = "split" },
              { key = "<C-t>", action = "tabnew" },

              { key = "<", action = "prev_sibling" },
              { key = ">", action = "next_sibling" },
              { key = "P", action = "parent_node" },
              { key = "<BS>", action = "close_node" },
              { key = "<Tab>", action = "preview" },
              { key = "K", action = "first_sibling" },
              { key = "J", action = "last_sibling" },
              { key = "C", action = "toggle_git_clean" },
              { key = "I", action = "toggle_git_ignored" },
              { key = "H", action = "toggle_dotfiles" },
              { key = "B", action = "toggle_no_buffer" },
              { key = "U", action = "toggle_custom" },
              { key = "R", action = "refresh" },
              { key = "a", action = "create" },
              { key = "d", action = "remove" },
              { key = "D", action = "trash" },
              { key = "r", action = "rename" },
              { key = "<C-r>", action = "full_rename" },
              { key = "e", action = "rename_basename" },
              { key = "x", action = "cut" },
              { key = "c", action = "copy" },
              { key = "p", action = "paste" },
              { key = "y", action = "copy_name" },
              { key = "Y", action = "copy_path" },
              { key = "gy", action = "copy_absolute_path" },
              { key = "[e", action = "prev_diag_item" },
              { key = "[c", action = "prev_git_item" },
              { key = "]e", action = "next_diag_item" },
              { key = "]c", action = "next_git_item" },
              { key = "-", action = "dir_up" },
              { key = "s", action = "system_open" },
              { key = "f", action = "live_filter" },
              { key = "F", action = "clear_live_filter" },
              { key = "q", action = "close" },
              { key = "W", action = "collapse_all" },
              { key = "E", action = "expand_all" },
              { key = "S", action = "search_node" },
              { key = ".", action = "run_file_command" },
              { key = "<C-k>", action = "toggle_file_info" },
              { key = "g?", action = "toggle_help" },
              { key = "m", action = "toggle_mark" },
              { key = "bmv", action = "bulk_move" },
            },
          },
        },

        filters = {
          custom = {
            "^.git$",
          },
        },

        renderer = {
          indent_markers = {
            enable = true,
          },

          icons = {
            padding = " ",
          },
        },

        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
    end,
  },
}
