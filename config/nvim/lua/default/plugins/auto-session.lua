-- NAME: auto-session.lua
-- NOTE:
--
--
--
--

local list = require("default.pluginlist").get_list()
return {
  {
    "rmagatti/auto-session",
    cond = list.auto_session,
    config = function()
      vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      require("auto-session").setup({
        -- :SaveSession, :RestoreSession, :DeleteSession

        log_level = "error",
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enable_last_session = false,

        auto_session_enabled = true,
        auto_restore_enalbled = true,

        auto_session_create_enabled = false,
        auto_save_enalbled = false, 

        session_lens = {
          buftypes_to_ignore = {},
          theme_conf = { border = true },
          previewer = false,
        },
      })

      vim.api.nvim_create_user_command("SessionSaveAndClose", function(opts)
        vim.cmd("SessionSave")
        vim.cmd("confirm qa")
      end, {
        nargs = 0,
      })
    end,
  },
}
