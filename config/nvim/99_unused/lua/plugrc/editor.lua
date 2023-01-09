------------------------------------------------------------
-- FILE:   lua/plugrc/editor.lua
-- AUTHOR: marsh
--
-- Editor config file for lua settings.
-- Load from ../init.lua.
--
-- NOTE:
--  - 'phaazon/hop.nvim'             -> ok
--  - 'simeji/winresizer'            -> ok
--  - 'sindrets/diffview.nvim'       -> yet
--  - 'rmagatti/auto-session'        -> ok
--  - 'notomo/cmdbuf.nvim'           -> ok
--  - 'ethanholz/nvim-lastplace'     -> ok
--  - 'steelsojka/pears.nvim'        -> ok
--  - 'Chiel92/vim-autoformat'       -> ok
--  - 'blackCauldron7/surround.nvim' -> ok
------------------------------------------------------------


------------------------------------------------------------
-- hop.nvim
require("hop").setup()


------------------------------------------------------------
-- winresizer
--  <C-w><C-e> :WinResizerStartResize
vim.g.winresizer_start_key = "<C-w><C-e>"
vim.g.winresizer_vert_resize = 5
vim.g.winresizer_horiz_resize = 2


------------------------------------------------------------
-- diffview.nvim <not setting>


------------------------------------------------------------
-- auto-session
--
-- NOTE:
--   - SaveSession
--   - RestoreSession
--   - DeleteSession
--
require("auto-session").setup {
    auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
}
vim.o.sessionoptions="blank,buffers,folds,help,tabpages,winsize,winpos"


------------------------------------------------------------
-- cmdbuf.nvim
-- Set cmdbuf.nvim config to ../../plugins/keys.vim
--


------------------------------------------------------------
-- nvim-lastplace
require("nvim-lastplace").setup {
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
    lastplace_open_folds = true,
}


------------------------------------------------------------
-- pears.nvim
require("pears").setup (function(conf)
    conf.pair("<", ">")
    conf.expand_on_enter(true)
end)


------------------------------------------------------------
-- vim-autoformat
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.autoformat_remove_trailing_space = true

------------------------------------------------------------
-- surround.nvim
require("surround").setup {
    mappings_style = "surround",
    map_insert_mode = true,
    pairs = {
        nestable = {{"(", ")"}, {"[", "]"}, {"{", "}"}, {"<", ">"}},
        linear = {{"'", "'"}, {"`", "`"}, {'"', '"'}}
    },
}



require("rest-nvim").setup {
    -- Open request results in a horizontal split
    result_split_horizontal = false,

    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = false,

    -- Highlight request on run
    highlight = {
        enabled = true,
        timeout = 150,
    },
    result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
    },

    -- Jump to request line on run
    jump_to_request = false,
    env_file = '.env',
    custom_dynamic_variables = {},
    yank_dry_run = true,
}


-- vim: sw=4 sts=4 expandtab fenc=utf-8
