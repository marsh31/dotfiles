-- NAME: auto-session.lua
-- NOTE:
--
--
--
--

return {
  {
    "rmagatti/auto-session",
    cond = true,
    lazy = false,

    init = function ()
      vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,

    config = function()
      require("auto-session").setup({
        -- :SaveSession, :RestoreSession, :DeleteSession

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

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      enabled = true,
      root_dir = vim.fn.stdpath("data") .. "/sessions/",

      auto_save = true,
      auto_restore = true,
      auto_create =true,
      auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist

      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      allowed_dirs = nil,

      -- Gitのブランチ名称をセッションに含めないし、
      -- ブランチを切り替えたときにセッションを変更しない。
      git_use_branch_name = false,
      git_auto_restore_on_branch_change = false,

      lazy_support = true,

      -- 特定のファイルタイプでセッションを保存する・しないを指定しない。
      bypass_save_filetypes = nil,

      -- 特定のファイルタイプをセッション保存前に閉じる。
      -- これにより、指定したファイルタイプをセッションファイル煮含めない。
      close_filetypes_on_save = { 
        "checkhealth",
        "oil"
      },

      close_unsupported_windows = true,

      preserve_buffer_on_restore = nil,

      args_allow_single_directory = true,
      args_allow_files_auto_save = false,

      continue_restore_on_error = true,

      show_auto_restore_notif = false,

      cwd_change_handling = false,

      -- 一つのセッションですべてを管理するか、しないか。
      single_session_mode = false,

      lsp_stop_on_restore = false,

      restore_error_handler = nil,

      purge_after_minutes = nil,

      log_level = "error",

      session_lens = {
        load_on_setup = true,
        picker_opts = nil,
        mappings = {
          delete_session = { "i", "<C-D>" },
          alternate_session = { "i", "<C-S>" },
          copy_session = { "i", "<C-Y>" },
        },

        session_control = {
          control_dir = vim.fn.stdpath "data" .. "/auto_session/",
          control_filename = "session_control.json",
        },
      },
    },
  }
}

