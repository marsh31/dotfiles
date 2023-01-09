------------------------------------------------------------
-- FILE:   lua/plugrc/filetree.lua
-- AUTHOR: marsh
--
-- File tree config file for lua settings.
-- Plugin:
--   - 'kyazdani42/nvim-tree.lua'
------------------------------------------------------------

if vim.g.enable_nvim_tree then
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    local list = {
        { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
        { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
        { key = "<C-v>",                        cb = tree_cb("vsplit") },
        { key = "<C-x>",                        cb = tree_cb("split") },
        { key = "<C-t>",                        cb = tree_cb("tabnew") },
        { key = "<",                            cb = tree_cb("prev_sibling") },
        { key = ">",                            cb = tree_cb("next_sibling") },
        { key = "P",                            cb = tree_cb("parent_node") },
        { key = "<BS>",                         cb = tree_cb("close_node") },
        { key = "<S-CR>",                       cb = tree_cb("close_node") },
        { key = "<Tab>",                        cb = tree_cb("preview") },
        { key = "K",                            cb = tree_cb("first_sibling") },
        { key = "J",                            cb = tree_cb("last_sibling") },
        { key = "I",                            cb = tree_cb("toggle_ignored") },
        { key = "H",                            cb = tree_cb("toggle_dotfiles") },
        { key = "R",                            cb = tree_cb("refresh") },
        { key = "a",                            cb = tree_cb("create") },
        { key = "d",                            cb = tree_cb("remove") },
        { key = "D",                            cb = tree_cb("trash") },
        { key = "r",                            cb = tree_cb("rename") },
        { key = "<C-r>",                        cb = tree_cb("full_rename") },
        { key = "x",                            cb = tree_cb("cut") },
        { key = "c",                            cb = tree_cb("copy") },
        { key = "p",                            cb = tree_cb("paste") },
        { key = "y",                            cb = tree_cb("copy_name") },
        { key = "Y",                            cb = tree_cb("copy_path") },
        { key = "gy",                           cb = tree_cb("copy_absolute_path") },
        { key = "[c",                           cb = tree_cb("prev_git_item") },
        { key = "]c",                           cb = tree_cb("next_git_item") },
        { key = "-",                            cb = tree_cb("dir_up") },
        { key = "s",                            cb = tree_cb("system_open") },
        { key = "q",                            cb = tree_cb("close") },
        { key = "g?",                           cb = tree_cb("toggle_help") },
    }

    require("nvim-tree").setup {
        disable_netrw       = true,
        hijack_netrw        = true,
        open_on_setup       = false,
        ignore_ft_on_setup  = {},
        update_to_buf_dir   = {
            enable = true,
            auto_open = true,
        },
        auto_close          = true,
        open_on_tab         = false,
        hijack_cursor       = false,
        update_cwd          = false,
        diagnostics         = {
            enable = false,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            }
        },
        update_focused_file = {
            enable      = false,
            update_cwd  = false,
            ignore_list = {}
        },
        system_open = {
            cmd  = nil,
            args = {}
        },
        git = {
            enable = true,
            ignore = true,
        },
        view = {
            width = 30,
            height = 30,
            side = 'left',
            auto_resize = true,
            number = false,
            relativenumber = false,
            mappings = {
                custom_only = false,
                list = list
            }
        },
        filters = {
            dotfiles = false,
            custom = {}
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        }
    }
end


if vim.g.enable_fern then
    vim.g.cursorhold_updatetime = 500

    -- keymap
    function load_fern_keymaps()
        local opt_expr   = { expr = true, silent = true, noremap = false }
        local opt_silent = { silent = true, noremap = false, nowait = true }
        local list = {
            { key = "<CR>",   cmd = '<Plug>(fern-action-open-or-expand)',   opt = opt_silent },
            { key = '<C-c>',  cmd = '<Plug>(fern-action-cancel)',           opt = opt_silent },
            { key = "<C-i>",  cmd = '<Plug>(fern-action-mark:toggle)',      opt = opt_silent },

            { key = "os",     cmd = '<Plug>(fern-action-open:split)',       opt = opt_silent },
            { key = "ov",     cmd = '<Plug>(fern-action-open:vsplit)',      opt = opt_silent },
            { key = "ot",     cmd = '<Plug>(fern-action-open:tabedit)',     opt = opt_silent },
            { key = "oo",     cmd = '<Plug>(fern-action-open:select)',      opt = opt_silent },

            { key = "h",      cmd = '<Plug>(fern-action-collapse)',         opt = opt_silent },
            { key = "l",      cmd = '<Plug>(fern-action-expand)',           opt = opt_silent },
            { key = "q",      cmd = '<cmd>close<CR>',                       opt = opt_silent },
            { key = "r",      cmd = '<cmd>lua _G.load_fern_keymaps()<CR>',  opt = opt_silent },
            { key = "y",      cmd = '<Plug>(fern-action-yank:bufname)',     opt = opt_silent },

            { key = "R",      cmd = '<Plug>(fern-action-reload:all)',       opt = opt_silent },
            { key = "?",      cmd = '<Plug>(fern-action-help)',             opt = opt_silent },
        }
        for _, items in ipairs(list) do
            vim.api.nvim_buf_set_keymap(0, "n", items.key, items.cmd, items.opt)
        end
    end


    vim.api.nvim_exec([[
    let g:fern#default_hidden = 1
    let g:fern#scheme#file#show_absolute_path_on_root_label = 1

    let g:fern#renderer = "nerdfont"
    let g:fern#disable_default_mappings             = 1
    let g:fern#mapping#fzf#disable_default_mappings = 1
    let g:fern#drawer_width                         = 30
    let g:fern#renderer                             = 'nerdfont'
    let g:fern#renderer#nerdfont#padding            = '  '
    let g:fern#hide_cursor                          = 0
    ]], true)

    local fernKeyCustom = vim.api.nvim_create_augroup("FernCustomKeys", { clear = true })
    vim.api.nvim_create_autocmd("FileType", { pattern = { "fern" }, command = [[silent! lua _G.load_fern_keymaps()]], group = fernKeyCusto }
