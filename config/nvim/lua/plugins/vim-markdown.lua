-- ====================================================================
-- NAME:   vim-markdown.lua
-- AUTHOR: marsh
--
-- NOTE:
--
-- Csvを,区切りでいい感じにする。
-- :'<,'>Tabularize /,/l0r1
--
-- test, test2, test3
-- this, is   , test
--
--
--
-- s/|:\?\zs[ -]\+\ze:\?|/\=repeat("-", len(submatch(0)))/g
-- | test           | header       |
-- |----------------|--------------|
-- | OK? or not OK? | this is test |
--

return {
  {
    "preservim/vim-markdown",
    cond = false,
    dependencies = {
      "godlygeek/tabular",
    },
    ft = { "markdown", "mdx" },
    init = function() end,
  },
}
