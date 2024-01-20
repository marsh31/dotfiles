vim.wo.number = true
vim.wo.wrap = false
vim.o.title = true
vim.wo.list = true
vim.o.listchars = "tab:»-,trail:-,eol:↲"

vim.o.showtabline = 2

vim.o.hidden = true
vim.o.helplang = "en"
vim.bo.fileencoding = "utf-8"

vim.o.whichwrap = "<,>,[,],b,s"
vim.o.showcmd = true
vim.wo.cursorcolumn = true
vim.wo.cursorline = true
vim.o.showmatch = true
vim.o.matchtime = 1
vim.bo.matchpairs = "(:),{:},[:],<:>"

vim.o.completeopt = "menu,longest"
vim.o.updatetime = 500
vim.o.mouse = "nvh"

vim.o.clipboard = "unnamedplus"

vim.o.undodir = vim.fn.expand("~/.config/nvim/undo")
vim.bo.undofile = true

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 10


vim.o.expandtab = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true

vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.autoindent = true
vim.bo.smartindent = true

vim.o.wildignorecase = true
vim.o.wildignore = "*.o,*.jpg,*.png,*.pdf,*.so,*.dll,tags"

vim.bo.swapfile = false
vim.o.writebackup = false

vim.o.foldlevelstart = 99
vim.wo.signcolumn = "yes:2"
vim.wo.foldmethod = "marker"
vim.wo.fillchars = "vert: ,fold: "
-- vim.wo.foldtext = "fold#MyFoldText()"
vim.wo.foldtext = vim.treesitter.foldtext()

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = true

if vim.fn.executable("rg") then
	vim.o.grepprg = "rg --vimgrep --no-heading";
	vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

vim.g.mapleader = [[ ]]
-- vim.g.maplocalleader = [[_]]
--

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
            { key = "<C-i>",  cmd = '<Plug>(fern-action-mark:toggle)',     opt = opt_silent },

            { key = "h",      cmd = '<Plug>(fern-action-collapse)',         opt = opt_silent },
            { key = "l",      cmd = '<Plug>(fern-action-expand)',           opt = opt_silent },
            { key = "q",      cmd = '<cmd>close<CR>',                       opt = opt_silent },
            { key = "r",      cmd = '<cmd>lua _G.load_fern_keymaps()<CR>',  opt = opt_silent },
            { key = "s",      cmd = '<Plug>(fern-action-open:split)',       opt = opt_silent },
            { key = "t",      cmd = '<Plug>(fern-action-open:tabedit)',     opt = opt_silent },
            { key = "v",      cmd = '<Plug>(fern-action-open:vsplit)',      opt = opt_silent },
            { key = "y",      cmd = '<Plug>(fern-action-yank:bufname)',     opt = opt_silent },

            { key = "R",      cmd = '<Plug>(fern-action-reload:all)',       opt = opt_silent },
        }
    -- Keymap n <silent> <buffer>        <Plug>(fern-page-down-wrapper)                <C-d>
    -- Keymap n <silent> <buffer>        <Plug>(fern-page-up-wrapper)                  <C-u>
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-page-down-or-scroll-down-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:scroll:down:half)", "\<Plug>(fern-page-down-wrapper)")
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-page-down-or-scroll-up-preview)   fern_preview#smart_preview("\<Plug>(fern-action-preview:scroll:up:half)", "\<Plug>(fern-page-up-wrapper)")
    -- Keymap n <silent> <buffer>        <Plug>(fern-search-prev)                      N
    --
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-expand-or-collapse)                 fern#smart#leaf("\<Plug>(fern-action-collapse)", "\<Plug>(fern-action-expand)", "\<Plug>(fern-action-collapse)")
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-open-system-directory-or-open-file) fern#smart#leaf("\<Plug>(fern-action-open:select)", "\<Plug>(fern-action-open:system)")
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview)              fern_preview#smart_preview("\<Plug>(fern-action-preview:close)\<Plug>(fern-action-preview:auto:disable)", ":q\<CR>")
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-wipe-or-close-preview)              fern_preview#smart_preview("\<Plug>(fern-action-preview:close)\<Plug>(fern-action-preview:auto:disable)", ":bwipe!\<CR>")
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-page-down-or-scroll-down-preview)   fern_preview#smart_preview("\<Plug>(fern-action-preview:scroll:down:half)", "\<Plug>(fern-page-down-wrapper)")
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-page-down-or-scroll-up-preview)     fern_preview#smart_preview("\<Plug>(fern-action-preview:scroll:up:half)", "\<Plug>(fern-page-up-wrapper)")
    -- Keymap n <silent> <buffer> <expr> <Plug>(fern-new-file-or-search-prev)            v:hlsearch ? "\<Plug>(fern-search-prev)" : "\<Plug>(fern-action-new-file)"
    --
    -- Keymap n  <silent> <buffer> <nowait> a       <Plug>(fern-choice)
    -- Keymap n  <silent> <buffer> <nowait> <CR>    <Plug>(fern-open-system-directory-or-open-file)
    -- Keymap n  <silent> <buffer> <nowait> t       <Plug>(fern-expand-or-collapse)
    -- Keymap n  <silent> <buffer> <nowait> l       <Plug>(fern-open-or-enter)
    -- Keymap n  <silent> <buffer> <nowait> h       <Plug>(fern-action-leave)
    -- Keymap nx <silent> <buffer> <nowait> x       <Plug>(fern-action-mark:toggle)j
    -- Keymap nx <silent> <buffer> <nowait> <Space> <Plug>(fern-action-mark:toggle)j
    -- Keymap n  <silent> <buffer> <nowait> N       <Plug>(fern-new-file-or-search-prev)
    -- Keymap n  <silent> <buffer> <nowait> K       <Plug>(fern-action-new-dir)
    -- Keymap n  <silent> <buffer> <nowait> d       <Plug>(fern-action-trash)
    -- Keymap n  <silent> <buffer> <nowait> r       <Plug>(fern-action-rename)
    -- Keymap n  <silent> <buffer> <nowait> c       <Plug>(fern-action-copy)
    -- Keymap n  <silent> <buffer> <nowait> C       <Plug>(fern-action-clipboard-copy)
    -- Keymap n  <silent> <buffer> <nowait> m       <Plug>(fern-action-move)
    -- Keymap n  <silent> <buffer> <nowait> M       <Plug>(fern-action-clipboard-move)
    -- Keymap n  <silent> <buffer> <nowait> P       <Plug>(fern-action-clipboard-paste)
    -- Keymap n  <silent> <buffer> <nowait> !       <Plug>(fern-action-hidden:toggle)
    -- Keymap n  <silent> <buffer> <nowait> y       <Plug>(fern-action-yank)
    -- Keymap n  <silent> <buffer> <nowait> <C-g>   <Plug>(fern-action-debug)
    -- Keymap n  <silent> <buffer> <nowait> ?       <Plug>(fern-action-help)
    -- Keymap n  <silent> <buffer> <nowait> <C-c>   <Plug>(fern-action-cancel)
    -- Keymap n  <silent> <buffer> <nowait> .       <Plug>(fern-repeat)
    -- Keymap n  <silent> <buffer> <nowait> q       <Plug>(fern-quit-or-close-preview)
    -- Keymap n  <silent> <buffer> <nowait> Q       <Plug>(fern-wipe-or-close-preview)
    -- Keymap n  <silent> <buffer> <nowait> p       <Plug>(fern-action-preview:toggle)
    -- Keymap n  <silent> <buffer> <nowait> <C-p>   <Plug>(fern-action-preview:auto:toggle)
    -- Keymap n  <silent> <buffer> <nowait> <C-d>   <Plug>(fern-page-down-or-scroll-down-preview)
    -- Keymap n  <silent> <buffer> <nowait> <C-u>   <Plug>(fern-page-down-or-scroll-up-preview)
    -- Keymap n  <silent> <buffer> <nowait> R       <Plug>(fern-action-reload:all)
    -- Keymap n  <silent> <buffer> <nowait> ;f      <Plug>(fern-action-fzf-root-files)
    -- Keymap n  <silent> <buffer> <nowait> ;d      <Plug>(fern-action-fzf-root-dirs)
    -- Keymap n  <silent> <buffer> <nowait> ;a      <Plug>(fern-action-fzf-root-both)

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
    let g:fern#hide_cursor                          = 1

    augroup fern-custom
        autocmd!
        autocmd FileType fern lua _G.load_fern_keymaps()
    augroup END
    ]], true)

end

