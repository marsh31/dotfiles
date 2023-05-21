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
                vim.g["fern_preview_window_calculator"] = {
                    width = function()
                        return vim.fn.min({ vim.fn.float2nr(vim.o.columns * 0.8), 200 })
                    end,
                }

                vim.g["fern_git_status#disable_ignore"] = 1
                vim.g["fern_git_status#disable_untracked"] = 1
                vim.g["fern_git_status#disable_submodules"] = 1
                vim.g["fern_git_status#disable_directories"] = 1
            end,

            config = function()
                vim.api.nvim_create_autocmd({ "FileType" }, {
                    pattern = { "fern" },
                    callback = function()
                        vim.cmd([[
            highlight! link FernRootSymbol FernRootText

            nnoremap <silent>        <buffer> <Plug>(fern-page-down-wrapper) <C-d>
            nnoremap <silent>        <buffer> <Plug>(fern-page-up-wrapper)   <C-u>
            nnoremap <silent> <expr> <buffer> <Plug>(fern-page-down-or-scroll-down-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:scroll:down:half)", "\<Plug>(fern-page-down-wrapper)")
            nnoremap <silent> <expr> <buffer> <Plug>(fern-page-down-or-scroll-up-preview)   fern_preview#smart_preview("\<Plug>(fern-action-preview:scroll:up:half)", "\<Plug>(fern-page-up-wrapper)")

            nnoremap <silent> <expr> <buffer> <Plug>(fern-action-expand-or-collapse)               fern#smart#leaf("\<Plug>(fern-action-collapse)", "\<Plug>(fern-action-expand)", "\<Plug>(fern-action-collapse)")
            nnoremap <silent> <expr> <buffer> <Plug>(fern-action-open-system-or-open-file)         fern#smart#leaf("\<Plug>(fern-action-open:select)", "\<Plug>(fern-action-open:system)")
            nnoremap <silent> <expr> <buffer> <Plug>(fern-action-quit-or-close-preview)            fern_preview#smart_preview("\<Plug>(fern-action-preview:close)\<Plug>(fern-action-preview:auto:disable)", ":q\<CR>")
            nnoremap <silent> <expr> <buffer> <Plug>(fern-action-wipe-or-close-preview)            fern_preview#smart_preview("\<Plug>(fern-action-preview:close)\<Plug>(fern-action-preview:auto:disable)", ":bwipe!\<CR>")
            nnoremap <silent> <expr> <buffer> <Plug>(fern-action-page-down-or-scroll-down-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:scroll:down:half)", "\<Plug>(fern-page-down-wrapper)")
            nnoremap <silent> <expr> <buffer> <Plug>(fern-action-page-down-or-scroll-up-preview)   fern_preview#smart_preview("\<Plug>(fern-action-preview:scroll:up:half)", "\<Plug>(fern-page-up-wrapper)")

            nnoremap <silent>        <buffer> <nowait> a       <Plug>(fern-action-choice)
            nnoremap <silent>        <buffer> <nowait> <CR>    <Plug>(fern-action-open-system-or-open-file)
            nnoremap <silent>        <buffer> <nowait> t       <Plug>(fern-action-expand-or-collapse)
            nnoremap <silent>        <buffer> <nowait> l       <Plug>(fern-action-open-or-enter)
            nnoremap <silent>        <buffer> <nowait> h       <Plug>(fern-action-leave)
            nnoremap <silent>        <buffer> <nowait> x       <Plug>(fern-action-mark:toggle)j
            xnoremap <silent>        <buffer> <nowait> x       <Plug>(fern-action-mark:toggle)j
            nnoremap <silent>        <buffer> <nowait> <Space> <Plug>(fern-action-mark:toggle)j
            xnoremap <silent>        <buffer> <nowait> <Space> <Plug>(fern-action-mark:toggle)j
            nnoremap <silent> <expr> <buffer> <nowait> N       v:hlsearch ? 'N' : '<Plug>(fern-action-new-file)'
            nnoremap <silent>        <buffer> <nowait> K       <Plug>(fern-action-new-dir)
            nnoremap <silent>        <buffer> <nowait> d       <Plug>(fern-action-trash)
            nnoremap <silent>        <buffer> <nowait> r       <Plug>(fern-action-rename)
            nnoremap <silent>        <buffer> <nowait> c       <Plug>(fern-action-copy)
            nnoremap <silent>        <buffer> <nowait> C       <Plug>(fern-action-clipboard-copy)
            nnoremap <silent>        <buffer> <nowait> m       <Plug>(fern-action-move)
            nnoremap <silent>        <buffer> <nowait> M       <Plug>(fern-action-clipboard-move)
            nnoremap <silent>        <buffer> <nowait> P       <Plug>(fern-action-clipboard-paste)
            nnoremap <silent>        <buffer> <nowait> !       <Plug>(fern-action-hidden:toggle)
            nnoremap <silent>        <buffer> <nowait> y       <Plug>(fern-action-yank)
            nnoremap <silent>        <buffer> <nowait> <C-g>   <Plug>(fern-action-debug)
            nnoremap <silent>        <buffer> <nowait> ?       <Plug>(fern-action-help)
            nnoremap <silent>        <buffer> <nowait> <C-c>   <Plug>(fern-action-cancel)
            nnoremap <silent>        <buffer> <nowait> .       <Plug>(fern-repeat)
            nnoremap <silent>        <buffer> <nowait> q       <Plug>(fern-action-quit-or-close-preview)
            nnoremap <silent>        <buffer> <nowait> Q       <Plug>(fern-action-wipe-or-close-preview)
            nnoremap <silent>        <buffer> <nowait> p       <Plug>(fern-action-preview:toggle)

            nnoremap <silent>        <buffer> <nowait> o       <Plug>(fern-action-open:select)
            nnoremap <silent>        <buffer> <nowait> <C-x>   <Plug>(fern-action-open:split)
            nnoremap <silent>        <buffer> <nowait> <C-v>   <Plug>(fern-action-open:vsplit)
            nnoremap <silent>        <buffer> <nowait> <C-t>   <Plug>(fern-action-open:tabedit)

            nnoremap <silent>        <buffer> <nowait> <C-p>   <Plug>(fern-action-preview:auto:toggle)
            nnoremap <silent>        <buffer> <nowait> <C-d>   <Plug>(fern-action-page-down-or-scroll-down-preview)
            nnoremap <silent>        <buffer> <nowait> <C-u>   <Plug>(fern-action-page-down-or-scroll-up-preview)
            nnoremap <silent>        <buffer> <nowait> R       <Plug>(fern-action-reload:all)
            ]])

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
