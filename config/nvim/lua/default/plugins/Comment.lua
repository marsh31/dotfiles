-- NAME: Comment.lua
-- NOTE:
--
--

local list = require("default.pluginlist").get_list()
return {
    {
        "numToStr/Comment.nvim",
        cond = list.comment,
        config = function()
            require("Comment").setup()
        end,
    },
}
