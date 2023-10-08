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

------------------------------------------------------------
-- Toggle
------------------------------------------------------------
vim.api.nvim_create_user_command("ToggleWrap", function(opts)
    vim.opt.wrap = not vim.wo.wrap
end, { nargs = 0 })

-- vim: sw=4 sts=4 expandtab fenc=utf-8
