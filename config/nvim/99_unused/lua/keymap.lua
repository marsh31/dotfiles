------------------------------------------------------------
-- File:   keymap.lua
-- Author: marsh
--
-- keymap
--
-- doc:
--  http://deris.hatenablog.jp/entry/2013/05/02/192415
--  https://gist.github.com/deris/5501282
------------------------------------------------------------
local util = require("config.utils.utils")
local map = util.map


-------------------------------------
--  local variable for map option  --
-------------------------------------
local silent = {silent = true}

-- vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")


-----------
--  map  --
-----------
map("n", "j",  "gj")
map("n", "k",  "gk")

map("n", "gj",  "j")
map("n", "gk",  "k")

map("n", "gg", "ggzz")
map("n", "G",  "Gzz")

map("n","<C-o>","<C-o>zz")
map("n","<C-i>","<C-i>zz")

map("n","<C-c><C-c>",":nohlsearch<CR><ESC>", silent)
map("n","<Leader><CR>", ":<C-u>nohlsearch<CR>", silent)

map("n","s","\"_s")
map("v","s","\"_s")
map("n","S","\"_S")
map("v","S","\"_S")

map("c","<C-a>","<HOME>")
map("c","<C-b>","<Left>")
map("c","<C-d>","<Del>")
map("c","<C-e>","<End>")
map("c","<C-f>","<Right>")
map("c","<M-b>","<S-Left>")
map("c","<M-f>","<S-Right>")

function _G.smart_replace_in_cmd(x)
    return vim.fn.getcmdtype() == x and [[\]]..x or x
end
map("c", "/", "v:lua.smart_replace_in_cmd('/')", {expr = true})
map("c", "?", "v:lua.smart_replace_in_cmd('?')", {expr = true})

map("n", "mm", ":<C-u>call mark#AutoMarkrement()<CR>", silent)

map("x", "*", ":<C-u>call keys#VSetSearch()<CR>/<C-r>=@/<CR><CR>", silent)
map("x", "#", ":<C-u>call keys#VSetSearch()<CR>/<C-r>=@/<CR><CR>", silent)

map({"n", "c", "v"},"<MiddleMouse>","<Nop>")
map({"n", "c", "v"},"<2-MiddleMouse>","<Nop>")
map({"n", "c", "v"},"<3-MiddleMouse>","<Nop>")
map({"n", "c", "v"},"<4-MiddleMouse>","<Nop>")
map("i","<MiddleMouse>","<Nop>")
map("i","<2-MiddleMouse>","<Nop>")
map("i","<3-MiddleMouse>","<Nop>")
map("i","<4-MiddleMouse>","<Nop>")

vim.cmd("command! W execute 'w !sudo tee % > /dev/null' <bar> edit!")


local tab_leader = "<C-t>"
map("n", tab_leader.."h", "gT")
map("n", tab_leader.."j", "gt")
map("n", tab_leader.."k", "gT")
map("n", tab_leader.."l", "gt")

map("n", tab_leader.."c", ":<C-u>tabclose<CR>")
map("n", tab_leader.."n", ":<C-u>tabnew<CR>")

-- map("n", tab_leader.."<C-h>", ":<C-u>tabfirst<CR>")
map("n", tab_leader.."<C-h>", "gT")
map("n", tab_leader.."<C-j>", "gt")
map("n", tab_leader.."<C-k>", "gT")
-- map("n", tab_leader.."<C-l>", ":<C-u>tablast<CR>")
map("n", tab_leader.."<C-l>", "gt")

map("n", tab_leader.."^", ":<C-u>tabfirst<CR>")
map("n", tab_leader.."$", ":<C-u>tablast<CR>")

map("n", tab_leader.."<C-c>", ":<C-u>tabclose<CR>")
map("n", tab_leader.."<C-n>", ":<C-u>tabnew<CR>")


for var=1,9 do
    map("n", tab_leader..tostring(var), ":<C-u>tabnext"..tostring(var).."<CR>")
end

map("n", "<Leader><Leader>", ":<C-u>FindBuffers<CR>")


map("n", "<Leader>f", ":<C-u>Autoformat<CR>", silent)


-----------------------------------
--  Commands for lsp completion  --
-----------------------------------
local opts = {noremap = true, silent = true, expr = true}

------------------------------------
--  Commands using function keys  --
------------------------------------
map("n", "<F5>", "<cmd>MundoToggle<CR>", { noremap = true, silent = true })
map('n', '<F8>', ':<C-u>Vista<CR>', { noremap = true, silent = true })
map('i', '<F8>', '<C-o>:<C-u>Vista<CR><ESC>', { noremap = true, silent = true })


----------------------------------
--  Commands starting with 'g'  --
----------------------------------
map("n", "gb", ":<C-u>Vista<CR>", { noremap = true, silent = true })
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
map("n", "gq", "<cmd>copen<CR>", { noremap = true, silent = true })
map("n", "gld", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", { noremap = true, silent = true })
map("n", "glr", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
map("n", "glt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = true })

map("n", "g:", ":<C-u>FindHistory:<CR>", { noremap = true, silent = true })
map("n", "g/", ":<C-u>FindHistory/<CR>", { noremap = true, silent = true })


--------------------------
--  Commands using [,]  --
--------------------------
map("n", "[d", ":<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
map("n", "]d", ":<C-u>lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true, silent = true })


-------------------------------
--  Commands using Ctrl key  --
-------------------------------
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })


------------------------
--  commands using m  --
------------------------
map("n", "mw", "<cmd>HopWord<CR>", silent)
map("n", "mp", "<cmd>HopPattern<CR>", silent)
map("n", "mca", "<cmd>HopChar1<CR>", silent)
map("n", "mcb", "<cmd>HopChar2<CR>", silent)
map("n", "ml", "<cmd>HopLine<CR>", silent)

------------------------
--  commands using t  --
------------------------
map("n", "tm", "<cmd>MundoToggle<CR>", { noremap = true, silent = true })
map("n", "tg", "<cmd>GitGutterLineHighlightsToggle | GitGutterLineNrHighlightsToggle<CR>", { noremap = true, silent = true })

--------------------------------
--  commands using <leader>s  --
--------------------------------
map("n", "<Leader>ss", "<cmd>SaveSession<CR>", silent)
map("n", "<Leader>sl", "<cmd>RestoreSession<CR>", silent)

-- TODO: gitgutter


----------------------
--  command using q --
----------------------
map("n", "q:", "<cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight)<CR>", { noremap = true, silent = true })
map("c", "<C-f>", [[<cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })<CR><C-c>]], { noremap = true, silent = true})
map("n", "ql", [[<cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, { type = "lua/cmd" })<CR>]], { noremap = true, silent = true })
map("n", "q/", [[<cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, { type = "vim/search/forward" })<CR>]], { noremap = true, silent = true })
map("n", "q?", [[<cmd>lua require('cmdbuf').split_open(vim.o.cmdwinheight, { type = "vim/search/backward" })<CR>]], { noremap = true, silent = true })
