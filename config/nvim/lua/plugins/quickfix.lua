-- NAME:
-- AUTHOR: marsh
--
-- NOTE:
--
--  quickfix config.

if vim.fn.executable("rg") then
    vim.opt.grepprg = "rg --vimgrep --hidden"
    vim.opt.grepformat = "%f:%l:%c:%m"
end

vim.api.nvim_create_augroup("GrepCmd", {})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    group = "GrepCmd",
    pattern = { "vimgrep,grep,grepadd" },
    callback = function()
        if vim.fn.len(vim.fn.getqflist()) ~= 0 then
            vim.api.nvim_command("botright copen")
        end
    end,
})

------------------------------------------------------------
-- quickfix window alignment.
--
--
local fn = vim.fn
function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({ id = info.id, items = 0 }).items
    else
        items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
    local validFmt = "%s │%5d:%-3d│%s %s"
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ""
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == "" then
                    fname = "[No Name]"
                else
                    fname = fname:gsub("^" .. vim.env.HOME, "~")
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

-- vim.opt.qftf = "{info -> v:lua._G.qftf(info)}"


return {
    {
        "thinca/vim-qfreplace",
        ft = { "qf" },
        cmd = "Qfreplace",
    },

    {
        "sk1418/QFGrep",
        ft = { "qf" },
        -- keymap: <leader>g, <leader>v, <leader>r
    },

    {
        "itchyny/vim-qfedit",
        ft = { "qf" },
    },

    -- {
    --     "thinca/vim-qfhl",
    --     event = { "VeryLazy" },
    -- },

    -- {
    --     "ten3roberts/qf.nvim",
    --     event = { "VeryLazy" },
    -- },
}

-- vim: ft=lua sts=4 expandtab fenc=utf-8