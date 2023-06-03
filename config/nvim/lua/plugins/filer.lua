-- NAME:   filer.lua
-- AUTHOR: marsh
-- NOTE:
--

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

                            { key = "<C-i>", cmd = "<Plug>(fern-action-mark:toggle)j", opt = opt_silent },
                            { key = "x", cmd = "<Plug>(fern-action-mark:toggle)j", opt = opt_silent },

                            { key = "t", cmd = "<Plug>(fern-action-expand-or-collapse)", opt = opt_silent },
                            { key = "l", cmd = "<Plug>(fern-action-expand)", opt = opt_silent },
                            { key = "h", cmd = "<Plug>(fern-action-collapse)", opt = opt_silent },
                            { key = "o", cmd = "<Plug>(fern-action-open:select)", opt = opt_silent },

                            { key = "a", cmd = "<Plug>(fern-action-choice)", opt = opt_silent },
                            { key = "N", cmd = "v:hlsearch ? 'N' : '<Plug>(fern-action-new-file)'", opt = opt_expr },
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
else
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
end

return M
