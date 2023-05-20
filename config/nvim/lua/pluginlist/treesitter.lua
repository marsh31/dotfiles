-- NAME:   treesitter.lua
-- AUTHOR: marsh
-- NOTE:
--
--

return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- build = ':TSUpdate',
    dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "RRethy/nvim-treesitter-textsubjects" },
            { "mfussenegger/nvim-treehopper" },
            { "David-Kunz/treesitter-unit" },

            { "yioneko/nvim-yati" },
            { "nvim-treesitter/nvim-treesitter-refactor" },
            { "theHamsta/nvim-treesitter-pairs" },
            { "p00f/nvim-ts-rainbow" },
            { "Dkendal/nvim-treeclimber" },

    },
    event = { 'BufRead', 'BufNewFile', 'InsertEnter' },
    cmd = { 'TSHighlightCapturesUnderCursor' },
    config = function()

    end,
  }
}









