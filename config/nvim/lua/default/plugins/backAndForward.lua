-- 
-- https://github.com/Bakudankun/BackAndForward.vim

return {
  {
    "Bakudankun/BackAndForward.vim",
    cond = true,
    config = function()
      vim.g.backandforward_config = {
        always_last_pos = 1,
        auto_map = 0,
        command_prefix = "",
        define_commands = 1,
      }

      local keyset = vim.keymap.set
      local option = { remap = true, silent = true, nowait = true }
      keyset("n", "[h", "<Plug>(backandforward-back)", option)
      keyset("n", "]h", "<Plug>(backandforward-forward)", option)
    end,
  },
}
