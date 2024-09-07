local list = require("default.pluginlist").get_list()
return {
    {
        "kylechui/nvim-surround",
        cond = list.nvim_surround,
        event = "VeryLazy",
        config = function()
            local nvim_surround_config = require("nvim-surround.config")
            require("nvim-surround").setup({
                keymaps = {
                    -- normal add
                    normal = "sa", -- general operation
                    normal_cur = "sail", -- line
                    normal_line = "sA", -- general operation, insert new line.
                    normal_cur_line = "sAS", -- line, and insert new line.

                    delete = "ds",
                    change = "cs",

                    insert = "<C-g>s",
                    insert_line = "<C-g>S",

                    visual = "S",
                    visual_line = "gS",
                },

                surrounds = {
                  [","] = {
                    add = { ",", "," },
                    find = function ()
                      return nvim_surround_config.get_selection({ motion = "a," })
                    end,
                    delete = "^(.)().-(.)()$"
                  }
                }
            })
        end,
    },
}
