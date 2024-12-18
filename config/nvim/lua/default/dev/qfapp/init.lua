-- NAME:   lua/dev/qfapp/init.lua
-- AUTHOR: marsh
--
-- NOTE:
--
--

local M = {}
local log = require("nvim_lua_logger")
log.setup({
    filename = vim.fn.expand("~/qfapp.log"),
    hotreload = true,
})


function _G.qftf(info)
    local fn = vim.fn
    local items
    local ret = {}

    log.write(string.format("- start %s", vim.inspect(info)), "qfapp.info")

    if info.quickfix == 1 and info.winid ~= 0 then
        return ret
    end

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
        log.write(string.format("%s to %s", str, vim.inspect(ret)), "qfapp.table.insert")
        table.insert(ret, str)
    end

    log.write(string.format("- end   %s", vim.inspect(ret)), "qfapp.ret")
    return ret
end

M.setup = function(isUsedDefault)
    if isUsedDefault then
        vim.opt.qftf = nil
    else
        vim.opt.qftf = "{info -> v:lua._G.qftf(info)}"
    end
end

return M

-- vim: sw=4 sts=4 expandtab fenc=utf-8
