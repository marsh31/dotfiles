local list = require('default/pluginlist').get_list()
if list.which_key_nvim == nil then list.which_key_nvim = false end

return {
    {
        "folke/which-key.nvim",
        cond = (list.all or list.which_key_nvim),
        lazy = true,
        cmd = "WhichKey",
        config = function()
            require("which-key").setup({
                plugins = {
                    registers = false,
                },
            })
        end,
    }
}
