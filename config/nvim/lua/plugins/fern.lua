--- NAME:   fern.lua
--- AUTHOR: marsh
--- NOTE:
---
--- fernは良いプラグインだけど、
--- いまはoil.nvimの使い勝手がいいと感じているから有効化はしない。
---

return {
  {
    "lambdalisue/fern.vim",
    cond = false, -- oilを使用するため、有効化しない。
    dependencies = {
      { "LumaKernel/fern-mapping-reload-all.vim" },
      { "lambdalisue/fern-git-status.vim" },
      { "lambdalisue/fern-hijack.vim" },

      { "nvim-tree/nvim-web-devicons" },
      { "yuki-yano/fern-preview.vim" },
      { "TheLeoP/fern-renderer-web-devicons.nvim" },

      { "lambdalisue/glyph-palette.vim" },
    },

    cmd = { "Fern" },
    keys = {
      { "<Leader>ed", "<Cmd>Fern . -drawer -reveal=%<CR><C-w>=", desc = "Open filer" },
      { "<Leader>eD", "<Cmd>Fern . -drawer<CR><C-w>=", desc = "Open filer" },

      -- current window
      {
        "<Leader>ew",
        "<Cmd>Fern . -reveal=%<CR><C-w>=",
        desc = "Open filer in current window",
      },
      {
        "<Leader>eW",
        "<Cmd>Fern . <CR><C-w>=",
        desc = "Open filer in current window",
      },

      -- split
      { "<Leader>ej", "<Cmd>rightbelow split | Fern .  -reveal=%<CR><C-w>=", desc = "Open filer" },
      { "<Leader>eJ", "<Cmd>rightbelow split | Fern . <CR><C-w>=", desc = "Open filer" },
      { "<Leader>ek", "<Cmd>leftabove  split | Fern .  -reveal=%<CR><C-w>=", desc = "Open filer" },
      { "<Leader>eK", "<Cmd>leftabove  split | Fern . <CR><C-w>=", desc = "Open filer" },

      -- vsplit
      { "<Leader>eh", "<Cmd>vertical leftabove  split | Fern . -reveal=%<CR><C-w>=", desc = "Open filer" },
      { "<Leader>eH", "<Cmd>vertical leftabove  split | Fern . <CR><C-w>=", desc = "Open filer" },
      { "<Leader>el", "<Cmd>vertical rightbelow split | Fern . -reveal=%<CR><C-w>=", desc = "Open filer" },
      { "<Leader>eL", "<Cmd>vertical rightbelow split | Fern . <CR><C-w>=", desc = "Open filer" },
    },

    init = function()
      vim.g["fern#renderer"] = "nvim-web-devicons"

      vim.g["fern#disable_default_mappings"] = true
      vim.g["fern#disable_drawer_hover_popup"] = true

      vim.g["fern#default_hidden"] = 1
      vim.g["fern#drawer_width"] = 40
      vim.g["fern#hide_cursor"] = 0
      vim.g["fern#hide_cursor"] = true
      vim.g["fern#window_selector_use_popup"] = true
      vim.g["fern#scheme#file#show_absolute_path_on_root_label"] = 1

      vim.g["fern_preview_window_highlight"] = "Normal:Normal,FloatBorder:Normal"

      vim.g["fern_git_status#disable_ignore"] = 1
      vim.g["fern_git_status#disable_untracked"] = 1
      vim.g["fern_git_status#disable_submodules"] = 1
      vim.g["fern_git_status#disable_directories"] = 1
    end,

    config = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "fern" },
        callback = function()
          vim.api.nvim_set_hl(0, "FernRootSymbol", { link = "FernRootText" })

          local opt_expr = { expr = true, silent = true, noremap = false, nowait = true }
          local opt_silent = { silent = true, noremap = false, nowait = true }

          local list = {
            { key = "<Plug>(fern-page-down-wrapper)", cmd = "<C-d>", opt = opt_silent },
            { key = "<Plug>(fern-page-up-wrapper)", cmd = "<C-u>", opt = opt_silent },
            {
              key = "<Plug>(fern-page-dow-or-scroll-down-preview)",
              cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:scroll:down:half)", "<Plug>(fern-page-down-wrapper)")',
              opt = opt_expr,
            },
            {
              key = "<Plug>(fern-page-down-or-scroll-up-preview)",
              cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:scroll:up:half)", "<Plug>(fern-page-up-wrapper)")',
              opt = opt_expr,
            },

            {
              key = "<Plug>(fern-action-expand-or-collapse)",
              cmd = 'fern#smart#leaf("<Plug>(fern-action-collapse)", "<Plug>(fern-action-expand)", "<Plug>(fern-action-collapse)")',
              opt = opt_expr,
            },
            {
              key = "<Plug>(fern-action-open-system-or-open-file)",
              cmd = 'fern#smart#leaf("<Plug>(fern-action-open:select)", "<Plug>(fern-action-open:system)")',
              opt = opt_expr,
            },
            {
              key = "<Plug>(fern-action-quit-or-close-preview)",
              cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:close)<Plug>(fern-action-preview:auto:disable)", ":q<CR>")',
              opt = opt_expr,
            },
            {
              key = "<Plug>(fern-action-wipe-or-close-preview)",
              cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:close)<Plug>(fern-action-preview:auto:disable)", ":bwipe!<CR>")',
              opt = opt_expr,
            },
            {
              key = "<Plug>(fern-action-page-down-or-scroll-down-preview)",
              cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:scroll:down:half)", "<Plug>(fern-page-down-wrapper)")',
              opt = opt_expr,
            },
            {
              key = "<Plug>(fern-action-page-down-or-scroll-up-preview)",
              cmd = 'fern_preview#smart_preview("<Plug>(fern-action-preview:scroll:up:half)", "<Plug>(fern-page-up-wrapper)")',
              opt = opt_expr,
            },

            -- keymap
            {
              key = "<CR>",
              cmd = "<Plug>(fern-action-open-or-expand)",
              opt = opt_silent,
            },
            {
              key = "o",
              cmd = "<Plug>(fern-action-open-or-expand)",
              opt = opt_silent,
            },
            -- {
            --     key = "<C-i>",
            --     cmd = "<Plug>(fern-action-mark:toggle)j",
            --     opt = opt_silent,
            -- },
            {
              key = "x",
              cmd = "<Plug>(fern-action-mark:toggle)j",
              opt = opt_silent,
            },
            {
              key = "t",
              cmd = "<Plug>(fern-action-expand-or-collapse)",
              opt = opt_silent,
            },
            {
              key = "l",
              cmd = "<Plug>(fern-action-expand)",
              opt = opt_silent,
            },
            {
              key = "h",
              cmd = "<Plug>(fern-action-collapse)",
              opt = opt_silent,
            },
            {
              key = "s",
              cmd = "<Plug>(fern-action-open:select)",
              opt = opt_silent,
            },
            {
              key = "a",
              cmd = "<Plug>(fern-action-choice)",
              opt = opt_silent,
            },
            {
              key = "n",
              cmd = "v:hlsearch ? 'n' : '<Plug>(fern-action-new-file)'",
              opt = opt_expr,
            },
            {
              key = "N",
              cmd = "v:hlsearch ? 'N' : '<Plug>(fern-action-new-dir)'",
              opt = opt_expr,
            },
            {
              key = "K",
              cmd = "<Plug>(fern-action-new-dir)",
              opt = opt_silent,
            },
            {
              key = "d",
              cmd = "<Plug>(fern-action-trash)",
              opt = opt_silent,
            },
            {
              key = "r",
              cmd = "<Plug>(fern-action-rename)",
              opt = opt_silent,
            },
            {
              key = "c",
              cmd = "<Plug>(fern-action-copy)",
              opt = opt_silent,
            },
            {
              key = "C",
              cmd = "<Plug>(fern-action-clipboard-copy)",
              opt = opt_silent,
            },
            {
              key = "m",
              cmd = "<Plug>(fern-action-move)",
              opt = opt_silent,
            },
            {
              key = "M",
              cmd = "<Plug>(fern-action-clipboard-move)",
              opt = opt_silent,
            },
            {
              key = "P",
              cmd = "<Plug>(fern-action-clipboard-paste)",
              opt = opt_silent,
            },
            {
              key = "!",
              cmd = "<Plug>(fern-action-hidden:toggle)",
              opt = opt_silent,
            },
            {
              key = "y",
              cmd = "<Plug>(fern-action-yank)",
              opt = opt_silent,
            },
            {
              key = "R",
              cmd = "<Plug>(fern-action-reload:all)",
              opt = opt_silent,
            },
            {
              key = "?",
              cmd = "<Plug>(fern-action-help)",
              opt = opt_silent,
            },
            {
              key = ".",
              cmd = "<Plug>(fern-repeat)",
              opt = opt_silent,
            },
            {
              key = "q",
              cmd = "<Plug>(fern-action-quit-or-close-preview)",
              opt = opt_silent,
            },
            {
              key = "Q",
              cmd = "<Plug>(fern-action-wipe-or-close-preview)",
              opt = opt_silent,
            },
            {
              key = "p",
              cmd = "<Plug>(fern-action-preview:toggle)",
              opt = opt_silent,
            },
            {
              key = "<C-c>",
              cmd = "<Plug>(fern-action-cancel)",
              opt = opt_silent,
            },
            {
              key = "<C-g>",
              cmd = "<Plug>(fern-action-debug)",
              opt = opt_silent,
            },
            {
              key = "<C-p>",
              cmd = "<Plug>(fern-action-preview:auto:toggle)",
              opt = opt_silent,
            },
            {
              key = "<C-x>",
              cmd = "<Plug>(fern-action-open:split)",
              opt = opt_silent,
            },
            {
              key = "<C-v>",
              cmd = "<Plug>(fern-action-open:vsplit)",
              opt = opt_silent,
            },
            {
              key = "<C-t>",
              cmd = "<Plug>(fern-action-open:tabedit)",
              opt = opt_silent,
            },

            {
              key = "<C-d>",
              cmd = "<Plug>(fern-action-page-down-or-scroll-down-preview)",
              opt = opt_silent,
            },
            {
              key = "<C-u>",
              cmd = "<Plug>(fern-action-page-down-or-scroll-up-preview)",
              opt = opt_silent,
            },
          }

          for _, items in ipairs(list) do
            vim.api.nvim_buf_set_keymap(0, "n", items.key, items.cmd, items.opt)
          end

          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })
    end,
  },
  {
    "lambdalisue/fern-hijack.vim",
    cond = false, -- oilを使用するため、有効化しない。
  },
}
