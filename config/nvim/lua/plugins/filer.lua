-- NAME:   filer.lua
-- AUTHOR: marsh
-- NOTE:
--

-- fern / nvim-tree / oil
local filer = "fern"
local M = {}

if filer == "fern" then
    M = {
        {
            "lambdalisue/fern.vim",
            dependencies = {
                { "LumaKernel/fern-mapping-reload-all.vim" },
                { "lambdalisue/fern-git-status.vim" },
                { "lambdalisue/fern-hijack.vim" },

                { "nvim-tree/nvim-web-devicons" },
                { "yuki-yano/fern-preview.vim" },
                { "TheLeoP/fern-renderer-web-devicons.nvim" },

                { "lambdalisue/glyph-palette.vim" },
            },
            cmd = { "Fern" },
            init = function()
                vim.g["fern#renderer"] = "nvim-web-devicons"

                vim.g["fern#disable_default_mappings"] = true
                vim.g["fern#disable_drawer_hover_popup"] = true

                vim.g["fern#default_hidden"] = 1
                vim.g["fern#drawer_width"] = 40
                vim.g["fern#hide_cursor"] = 0
                vim.g["fern#hide_cursor"] = true
                vim.g["fern#window_selector_use_popup"] = true
                vim.g["fern#scheme#file#show_absolute_path_on_root_label"] = 1

                vim.g["fern_preview_window_highlight"] = "Normal:Normal,FloatBorder:Normal"

                vim.g["fern_git_status#disable_ignore"] = 1
                vim.g["fern_git_status#disable_untracked"] = 1
                vim.g["fern_git_status#disable_submodules"] = 1
                vim.g["fern_git_status#disable_directories"] = 1
            end,

            config = function()
                vim.api.nvim_create_autocmd({ "FileType" }, {
                    pattern = { "fern" },
                    callback = function()
                        vim.api.nvim_set_hl(0, "FernRootSymbol", { link = "FernRootText" })

                        local opt_expr = { expr = true, silent = true, noremap = false, nowait = true }
                        local opt_silent = { silent = true, noremap = false, nowait = true }

                        local list = {
                            { key = "<Plug>(fern-page-down-wrapper)", cmd = "<C-d>", opt = opt_silent },
                            { key = "<Plug>(fern-page-up-wrapper)", cmd = "<C-u>", opt = opt_silent },
                            {
                                key = "<Plug>(fern-page-dow-or-scroll-down-preview)",
                                cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:scroll:down:half)", "<Plug>(fern-page-down-wrapper)")',
                                opt = opt_expr,
                            },
                            {
                                key = "<Plug>(fern-page-down-or-scroll-up-preview)",
                                cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:scroll:up:half)", "<Plug>(fern-page-up-wrapper)")',
                                opt = opt_expr,
                            },

                            {
                                key = "<Plug>(fern-action-expand-or-collapse)",
                                cmd = 'fern#smart#leaf("<Plug>(fern-action-collapse)", "<Plug>(fern-action-expand)", "<Plug>(fern-action-collapse)")',
                                opt = opt_expr,
                            },
                            {
                                key = "<Plug>(fern-action-open-system-or-open-file)",
                                cmd = 'fern#smart#leaf("<Plug>(fern-action-open:select)", "<Plug>(fern-action-open:system)")',
                                opt = opt_expr,
                            },
                            {
                                key = "<Plug>(fern-action-quit-or-close-preview)",
                                cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:close)<Plug>(fern-action-preview:auto:disable)", ":q<CR>")',
                                opt = opt_expr,
                            },
                            {
                                key = "<Plug>(fern-action-wipe-or-close-preview)",
                                cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:close)<Plug>(fern-action-preview:auto:disable)", ":bwipe!<CR>")',
                                opt = opt_expr,
                            },
                            {
                                key = "<Plug>(fern-action-page-down-or-scroll-down-preview)",
                                cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:scroll:down:half)", "<Plug>(fern-page-down-wrapper)")',
                                opt = opt_expr,
                            },
                            {
                                key = "<Plug>(fern-action-page-down-or-scroll-up-preview)",
                                cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:scroll:up:half)", "<Plug>(fern-page-up-wrapper)")',
                                opt = opt_expr,
                            },

                            -- keymap
                            { key = "<CR>", cmd = "<Plug>(fern-action-open-or-expand)", opt = opt_silent },
                            { key = "o", cmd = "<Plug>(fern-action-open-or-expand)", opt = opt_silent },

                            { key = "<C-i>", cmd = "<Plug>(fern-action-mark:toggle)j", opt = opt_silent },
                            { key = "x", cmd = "<Plug>(fern-action-mark:toggle)j", opt = opt_silent },

                            { key = "t", cmd = "<Plug>(fern-action-expand-or-collapse)", opt = opt_silent },
                            { key = "l", cmd = "<Plug>(fern-action-expand)", opt = opt_silent },
                            { key = "h", cmd = "<Plug>(fern-action-collapse)", opt = opt_silent },

                            { key = "s", cmd = "<Plug>(fern-action-open:select)", opt = opt_silent },

                            { key = "a", cmd = "<Plug>(fern-action-choice)", opt = opt_silent },


                            { key = "n", cmd = "v:hlsearch ? 'n' : '<Plug>(fern-action-new-file)'", opt = opt_expr },
                            { key = "N", cmd = "v:hlsearch ? 'N' : '<Plug>(fern-action-new-dir)'", opt = opt_expr },

                            { key = "K", cmd = "<Plug>(fern-action-new-dir)", opt = opt_silent },
                            { key = "d", cmd = "<Plug>(fern-action-trash)", opt = opt_silent },
                            { key = "r", cmd = "<Plug>(fern-action-rename)", opt = opt_silent },
                            { key = "c", cmd = "<Plug>(fern-action-copy)", opt = opt_silent },
                            { key = "C", cmd = "<Plug>(fern-action-clipboard-copy)", opt = opt_silent },
                            { key = "m", cmd = "<Plug>(fern-action-move)", opt = opt_silent },
                            { key = "M", cmd = "<Plug>(fern-action-clipboard-move)", opt = opt_silent },
                            { key = "P", cmd = "<Plug>(fern-action-clipboard-paste)", opt = opt_silent },
                            { key = "!", cmd = "<Plug>(fern-action-hidden:toggle)", opt = opt_silent },
                            { key = "y", cmd = "<Plug>(fern-action-yank)", opt = opt_silent },
                            { key = "R", cmd = "<Plug>(fern-action-reload:all)", opt = opt_silent },

                            { key = "?", cmd = "<Plug>(fern-action-help)", opt = opt_silent },
                            { key = ".", cmd = "<Plug>(fern-repeat)", opt = opt_silent },
                            { key = "q", cmd = "<Plug>(fern-action-quit-or-close-preview)", opt = opt_silent },
                            { key = "Q", cmd = "<Plug>(fern-action-wipe-or-close-preview)", opt = opt_silent },
                            { key = "p", cmd = "<Plug>(fern-action-preview:toggle)", opt = opt_silent },

                            { key = "<C-c>", cmd = "<Plug>(fern-action-cancel)", opt = opt_silent },
                            { key = "<C-g>", cmd = "<Plug>(fern-action-debug)", opt = opt_silent },
                            { key = "<C-p>", cmd = "<Plug>(fern-action-preview:auto:toggle)", opt = opt_silent },

                            { key = "<C-x>", cmd = "<Plug>(fern-action-open:split)", opt = opt_silent },
                            { key = "<C-v>", cmd = "<Plug>(fern-action-open:vsplit)", opt = opt_silent },
                            { key = "<C-t>", cmd = "<Plug>(fern-action-open:tabedit)", opt = opt_silent },

                            {
                                key = "<C-d>",
                                cmd = "<Plug>(fern-action-page-down-or-scroll-down-preview)",
                                opt = opt_silent,
                            },
                            {
                                key = "<C-u>",
                                cmd = "<Plug>(fern-action-page-down-or-scroll-up-preview)",
                                opt = opt_silent,
                            },
                        }

                        local xkeys = {
                            { key = "<C-i>", cmd = "<Plug>(fern-action-mark:toggle)", opt = opt_silent },
                            { key = "x", cmd = "<Plug>(fern-action-mark:toggle)j", opt = opt_silent },
                        }

                        for _, items in ipairs(list) do
                            vim.api.nvim_buf_set_keymap(0, "n", items.key, items.cmd, items.opt)
                        end

                        for _, items in ipairs(xkeys) do
                            vim.api.nvim_buf_set_keymap(0, "x", items.key, items.cmd, items.opt)
                        end

                        vim.opt_local.number = false
                        vim.opt_local.relativenumber = false
                    end,
                })
            end,
        },
        { "lambdalisue/fern-hijack.vim" },
    }
elseif filer == "nvim-tree" then
    M = {
        {
            "nvim-tree/nvim-tree.lua",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },

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
elseif filer == "oil" then
    M = {
        {
            "stevearc/oil.nvim",
            -- Optional dependencies
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require("oil").setup({
                    columns = {
                        "icon",
                    },

                    buf_options = {
                        buflisted = false,
                        bufhidden = "hide",
                    },

                    win_options = {
                        wrap = false,
                        -- signcolumn = false,
                        cursorcolumn = false,
                        foldcolumn = "0",
                    --     spell = false,
                        list = false,
                        conceallevel = 3,
                        concealcursor = "n",
                    },

                    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
                    default_file_explorer = true,

                    -- Restore window options to previous values when leaving an oil buffer
                    restore_win_options = true,

                    -- Skip the confirmation popup for simple operations
                    skip_confirm_for_simple_edits = false,

                    -- Deleted files will be removed with the trash_command (below).
                    delete_to_trash = false,

                    -- Change this to customize the command used when deleting to trash
                    trash_command = "trash-put",

                    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
                    prompt_save_on_select_new_entry = true,

                    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
                    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
                    -- Additionally, if it is a string that matches "actions.<name>",
                    -- it will use the mapping at require("oil.actions").<name>
                    -- Set to `false` to remove a keymap
                    -- See :help oil-actions for a list of all available actions
                    keymaps = {
                        ["g?"] = "actions.show_help",
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
                        ["g."] = "actions.toggle_hidden",
                    },

                    use_default_keymaps = true,
                    view_options = {
                        -- Show files and directories that start with "."
                        show_hidden = false,
                        -- This function defines what is considered a "hidden" file
                        is_hidden_file = function(name, bufnr)
                            return vim.startswith(name, ".")
                        end,
                        -- This function defines what will never be shown, even when `show_hidden` is set
                        is_always_hidden = function(name, bufnr)
                            return false
                        end,
                    },

                    -- Configuration for the floating window in oil.open_float
                    float = {
                        -- Padding around the floating window
                        padding = 2,
                        max_width = 0,
                        max_height = 0,
                        border = "rounded",
                        win_options = {
                            winblend = 10,
                        },
                    },

                    -- Configuration for the actions floating preview window
                    preview = {
                        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                        -- min_width and max_width can be a single value or a list of mixed integer/float types.
                        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                        max_width = 0.9,
                        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                        min_width = { 40, 0.4 },
                        -- optionally define an integer/float for the exact width of the preview window
                        width = nil,
                        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                        -- min_height and max_height can be a single value or a list of mixed integer/float types.
                        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                        max_height = 0.9,
                        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                        min_height = { 5, 0.1 },
                        -- optionally define an integer/float for the exact height of the preview window
                        height = nil,
                        border = "rounded",
                        win_options = {
                            winblend = 0,
                        },
                    },

                    -- Configuration for the floating progress window
                    progress = {
                        max_width = 0.9,
                        min_width = { 40, 0.4 },
                        width = nil,
                        max_height = { 10, 0.9 },
                        min_height = { 5, 0.1 },
                        height = nil,
                        border = "rounded",
                        minimized_border = "none",
                        win_options = {
                            winblend = 0,
                        },
                    },
                })
            end,
        },
    }
else
    M = {}
end

return M
