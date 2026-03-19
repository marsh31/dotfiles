--- NAME:   vim-partedit.lua
--- AUTHOR: marsh
--- NOTE:
---
---
---
---


return {
    {
        "thinca/vim-partedit",
        cond = true,
        config = function()
            vim.g["partedit#opener"] = "vsplit"

            -- prefix
            -- filetype
        end,
    },
}
