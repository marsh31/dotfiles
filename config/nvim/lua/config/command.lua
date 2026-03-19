-- NAME:   lua/command.lus
-- AUTHOR: marsh
--
-- NOTE:
--
-- vim.api.nvim_create_user_command ({name}, {command}, {*opts})
--
-- :call nvim_create_user_command('SayHello', 'echo "Hello world!"', {})
--
-- {command}
-- <args>
-- <f-args>
-- <bang>
-- <line1>
-- <line2>
-- <range>
-- <count>
-- <reg>
-- <mods>
--
-- {opts}
-- <args>
-- -nargs=0    引数を取らない (デフォルト)
-- -nargs=1    1個の引数が必要 (空白で区切られない)
-- -nargs=*    いくつでも引数を取れる (0個以上) 空白で区切られる
-- -nargs=?    0 もしくは 1 個の引数が取れる
-- -nargs=+    引数が必ず必要。数はいくつでもよい
--
-- -range      範囲指定が可能になります、無指定時は現在行
-- -range=%    範囲指定が可能になります、無指定時はファイル全体(1,$)
-- -range=N    カウント(無指定時はN)を行番号位置に指定できます (例 |:split|)。行番号に 0 を指定可能になる。
-- -count=N    カウント(無指定時はN)を行番号位置か、初期化引数に指定できます (例 |:Next|)。
-- -count      -count=0 と同じです

vim.api.nvim_create_user_command("DisableIME", function(opts)
    vim.fn.system("fcitx5-remote -c")
end, {
    nargs = 0,
})

vim.api.nvim_create_user_command("EnableIME", function(opts)
    vim.fn.system("fcitx5-remote -o")
end, {
    nargs = 0,
})

vim.api.nvim_create_user_command("T", function(opts)
    local cmd = string.format("split | wincmd j | resize 10 | terminal %s", opts["args"])
    vim.cmd(cmd)
end, {
    nargs = "*",
})

-- command! Tig :tabnew term://tig
vim.api.nvim_create_user_command("Tig", function(opts)
    local cmd = "tab sp | terminal tig"
    vim.cmd(cmd)
end, {
    nargs = 0,
})

vim.api.nvim_create_user_command("Task", function(opts)
    local cmd = string.format("vimgrep /<(TODO|FIXME|XXX)>/j ./**/*.%s", vim.fn.expand("%:e"))
    vim.cmd(cmd)
end, {
    nargs = 0,
})

vim.api.nvim_create_user_command("Upper", function(opts)
    print("> " .. string.upper(opts.fargs[1]))
end, {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
        return { "foo", "bar", "baz" }
    end,
})

-- command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
vim.api.nvim_create_user_command("W", function(opts)
    vim.cmd("'w !sudo tee % > /dev/null' <bar> edit!")
end, {
    nargs = 0,
})

------------------------------------------------------------
-- Toggle
------------------------------------------------------------

-- command! ToggleWrap setlocal wrap!
vim.api.nvim_create_user_command("ToggleWrap", function(opts)
    vim.opt.wrap = not vim.wo.wrap
end, { nargs = 0 })

-- command! ToggleSearchHighlight setlocal hlsearch!
vim.api.nvim_create_user_command("ToggleSearchHighlight", function(opts)
    vim.o.hlsearch = not vim.o.hlsearch
end, { nargs = 0 })

-- command! ToggleRelativeNumber setlocal relativenumber!
vim.api.nvim_create_user_command("ToggleRelativeNum", function(opts)
    vim.opt.relativenumber = not vim.o.relativenumber
end, { nargs = 0 })

-- function! s:toggleQuickfix() abort
--   let nr = winnr('$')
--   cwindow
--   let nr2 = winnr('$')
--   if nr == nr2
--     cclose
--   endif
-- endfunction
-- command! ToggleQuickfix :silent call s:toggleQuickfix()<CR>
vim.api.nvim_create_user_command("ToggleQuickfix", function(opts)
    local nr1 = vim.fn.winnr("$")
    vim.cmd("cwindow")

    local nr2 = vim.fn.winnr("$")
    if nr1 == nr2 then
        vim.cmd("cclose")
    end
end, { nargs = 0 })

--
-- キーマップを書き出す :WriteKeymaps [path]
--
vim.api.nvim_create_user_command("WriteKeymaps", function(opts)
    local modes = { "n", "v", "x", "s", "o", "i", "c", "t" }
    local labels = {
        n = "NORMAL",
        v = "VISUAL",
        x = "V-BLOCK",
        s = "SELECT",
        o = "OP-PEND",
        i = "INSERT",
        c = "CMDLINE",
        t = "TERMINAL",
    }
    local lines = {}
    table.insert(lines, ("# Neovim Keymaps dump (%s)"):format(os.date("%Y-%m-%d %H:%M:%S")))
    table.insert(lines, "")

    -- verbose 出力をそのまま取得（参照元つき）
    local function grab(cmd)
        local ok, res = pcall(vim.api.nvim_exec2, "silent verbose " .. cmd, { output = true })
        return ok and res.output or ""
    end

    for _, m in ipairs(modes) do
        table.insert(lines, ("## %s (%s)"):format(labels[m], m))
        table.insert(lines, "```")

        -- 具体モード / 全体両方を拾う（被りはそのまま出ます）
        table.insert(lines, grab(m .. "map"))
        table.insert(lines, "```")
        table.insert(lines, "")
    end

    local path = opts.args ~= "" and opts.args
        or (vim.fn.stdpath("state") .. "/keymaps-" .. os.date("%Y%m%d-%H%M%S") .. ".md")
    vim.fn.writefile(lines, path)
    print("Keymaps written to: " .. path)
end, { nargs = "?", complete = "file" })


-- vim: sw=4 sts=4 expandtab fenc=utf-8
