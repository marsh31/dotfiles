--- NAME:   winresizer.lua
--- AUTHOR: marsh
--- NOTE:
---
--- 入れるだけただ。

return {

    {
        "simeji/winresizer",
        -- cmd :WinResizerStartResize
        cond = true,
        config = function()
            vim.g.winresizer_start_key = "<C-w><C-e>"
            vim.g.winresizer_vert_resize = 10
            vim.g.winresizer_horiz_resize = 5
        end,
    },
}
