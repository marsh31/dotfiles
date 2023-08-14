-- 
-- NAME:   lua/config.lua
-- AUTHOR: marsh
-- NOTE:
-- 
--   Setting standard neovim config.
--

------------------------------------------------------------
-- Appearance
------------------------------------------------------------
vim.opt.belloff        = "all"

-- curosr
vim.opt.cursorcolumn   = false
vim.opt.cursorline     = true

-- line number
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = "yes:1"


-- status line
vim.opt.cmdheight      = 0                          -- command line height. 0: no line.
vim.opt.cmdwinheight   = 5                          -- command window height
vim.opt.laststatus     = 3
vim.opt.showmode       = false

-- tabline
vim.opt.showtabline    = 3

vim.opt.modeline       = true
vim.opt.modelines      = 2

vim.opt.scrolloff      = 2
vim.opt.sidescrolloff  = 2

vim.opt.list           = true
vim.opt.listchars      = "tab:>-,trail:^,eol:↲"
vim.opt.ambiwidth      = "single"
vim.opt.synmaxcol      = 512
vim.opt.termguicolors  = true
vim.opt.background     = "dark"
vim.opt.title          = true
vim.opt.wrap           = false
vim.opt.textwidth      = 0
vim.opt.scrollback     = 2000
vim.opt.fillchars      = {
  eob = " ",
}
vim.opt.inccommand     = "split"
vim.opt.conceallevel   = 3


-- fold
vim.opt.foldlevel      = 999


------------------------------------------------------------
-- Editor feature
------------------------------------------------------------
vim.opt.autoread       = true                      -- auto read when change current buffer file
vim.opt.backup         = false                     -- nobackup
vim.opt.clipboard      = "unnamedplus"             -- clipboard on.
vim.opt.hidden         = true                      -- enable to move the other buffer when change current buffer.
vim.opt.lazyredraw     = false                     -- lazyredraw
vim.opt.mouse          = "n"                       -- mouse
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.opt.shell          = "bash"                    -- bash, neovim terminal shell
vim.opt.splitbelow     = true                      -- split below
vim.opt.splitright     = true                      -- split right
vim.opt.swapfile       = false                     -- noswapfile
vim.opt.undofile       = true                      -- undofile
vim.opt.undodir        = vim.fn.expand("~/.local/state/nvim")
vim.opt.undolevels     = 10000
vim.opt.updatetime     = 200                       -- cursor hold time
vim.opt.virtualedit    = "block"                   -- virtualedit. move on blank on visual mode.
vim.opt.writebackup    = false                     -- nowritebackup
vim.opt.timeout        = true
vim.opt.timeoutlen     = 2000
vim.opt.ttimeout       = true
vim.opt.ttimeoutlen    = 300

vim.opt.autoindent     = true
vim.opt.cindent        = true
vim.opt.smartindent    = true
vim.opt.expandtab      = true
vim.opt.tabstop        = 2
vim.opt.softtabstop    = 2
vim.opt.shiftwidth     = 2


vim.opt.formatoptions:append {
  c = true,
  r = true,
  o = true,
  q = true,
}

vim.opt.backspace   = "indent,eol,start"
vim.opt.startofline = true


vim.api.nvim_create_autocmd({"TermOpen"}, {
    command = "startinsert",
})

------------------------------------------------------------
-- Complete
------------------------------------------------------------
vim.opt.completeopt:append {
    -- "menu",
    "noinsert",
    "menuone",
    "noselect",
}
vim.opt.pumblend       = 10
vim.opt.pumheight      = 10

------------------------------------------------------------
-- Diff
------------------------------------------------------------
vim.opt.diffopt:append {
    "filler",
    "iwhite",
    "vertical",
    "foldcolumn:0",
    "indent-heuristic",
}


------------------------------------------------------------
-- Search
------------------------------------------------------------
vim.opt.wildoptions = "pum"
vim.opt.wildmenu    = true
vim.opt.wildmode    = "longest:full"
vim.opt.incsearch   = true
vim.opt.hlsearch    = true
vim.opt.ignorecase  = true
vim.opt.smartcase   = true
vim.opt.suffixesadd = ".php,.tpl,.ts,.tsx,.css,.scss,.rb,.java,.json,.md,.as,.js,.jpg,.jpeg,.gif,.png,.vim"
vim.opt.matchpairs  = "(:),[:],{:}"
vim.opt.history     = 5000

if vim.fn.executable("rg") then
    vim.opt.grepprg = "rg --vimgrep --hidden"
    vim.opt.grepformat = "%f:%l:%c:%m"
end

-- vim: sw=4 sts=4 expandtab fenc=utf-8
