-- NAME: Comment.lua
-- NOTE:
--
--

return {
    {
        "numToStr/Comment.nvim",
        cond = true,
        keys = {
            { "gc", mode = { "n", "x" } },
            { "gb", mode = { "n", "x" } },
            { "gcc", mode = "n" },
        },
        config = function()
            require("Comment").setup()
        end,
    },
}
