-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/marsh/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/marsh/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/marsh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/marsh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/marsh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  QFGrep = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/QFGrep",
    url = "https://github.com/sk1418/QFGrep"
  },
  ["aerial.nvim"] = {
    config = { "\27LJ\2\ne\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\1\0B\0\2\1K\0\1\0\19load_extension\14telescope\nsetup\vaerial\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim",
    wants = { "telescope.nvim" }
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\na\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0009\4\4\1B\2\2\1K\0\1\0\vconfig\nsetup\27alpha.themes.dashboard\nalpha\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    after_files = { "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-document-symbol/after/plugin/cmp_nvim_lsp_document_symbol.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    after_files = { "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help/after/plugin/cmp_nvim_lsp_signature_help.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  everforest = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nP\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\15signcolumn\1\nnumhl\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hex.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/hex.nvim",
    url = "https://github.com/RaafatTurki/hex.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nJ\0\0\4\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\1K\0\1\0\1\0\1\tkeys\17asdfqwerzxcv\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["legendary.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/legendary.nvim",
    url = "https://github.com/mrjones2014/legendary.nvim",
    wants = { "telescope", "dressing" }
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16hint_enable\1\nsetup\18lsp_signature\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/tami5/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nƒ\6\0\0\6\0&\0?6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\15\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0004\5\0\0=\5\t\0044\5\0\0=\5\n\4=\4\v\0034\4\0\0=\4\f\0035\4\r\0=\4\14\3=\3\16\0025\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0034\4\3\0005\5\22\0>\5\1\4=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\28\0=\4\29\3=\3\30\0025\3\31\0004\4\0\0=\4\19\0034\4\3\0005\5 \0>\5\1\4=\4\21\0034\4\0\0=\4\23\0034\4\0\0=\4\25\0034\4\3\0005\5!\0>\5\1\4=\4\27\0034\4\0\0=\4\29\3=\3\"\0024\3\0\0=\3\n\0024\3\0\0=\3#\0025\3$\0=\3%\2B\0\2\1K\0\1\0\15extensions\1\3\0\0\14nvim-tree\rquickfix\20inactive_winbar\ftabline\1\2\1\0\fwindows\tmode\3\2\1\2\1\0\ttabs\tmode\3\2\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\5\0\0\16searchcount\rencoding\15fileformat\rfiletype\14lualine_c\1\2\1\0\rfilename\tpath\3\1\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\frefresh\1\0\3\ftabline\3¨\2\vwinbar\3¨\2\15statusline\3¨\2\17ignore_focus\23disabled_filetypes\vwinbar\15statusline\1\0\0\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\1\0\4\ntheme\tauto\18icons_enabled\2\17globalstatus\2\25always_divide_middle\2\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-null-ls.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/mason-null-ls.nvim",
    url = "https://github.com/jayp0521/mason-null-ls.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvcode-color-schemes.vim",
    url = "https://github.com/christianchiarulli/nvcode-color-schemes.vim"
  },
  nvim = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nœ\2\0\0\5\0\v\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\2B\0\2\0016\0\0\0'\2\n\0B\0\2\0026\1\0\0'\3\1\0B\1\2\2K\0\1\0\24nvim-autopairs.rule\14fast_wrap\nchars\1\6\0\0\6{\6[\6(\6\"\6'\1\0\a\18highligh_grey\fComment\fend_key\6$\14highlight\vSearch\fpattern\23[%'%\"%)%>%]%)%}%,]\16check_comma\2\bmap\n<M-e>\tkeys\30qwertyuiiopzxcvnmasdfghkl\21disable_filetype\1\0\0\1\2\0\0\20TelescopePrompt\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n–\1\0\0\b\0\b\2!6\0\0\0006\2\1\0009\2\2\0029\2\3\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20Ä6\2\1\0009\2\2\0029\2\4\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\5\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\6\2'\5\a\0B\2\3\2\n\2\0\0X\2\2Ä+\2\1\0X\3\1Ä+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2C\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequireÒ\1\0\2\b\0\14\0 6\2\0\0'\4\1\0B\2\2\0029\2\2\0025\4\3\0B\2\2\2\18\4\0\0\18\5\1\0B\2\3\0026\3\4\0009\3\5\0039\5\6\2'\6\a\0005\a\b\0B\3\4\2'\4\t\0:\5\1\3\14\0\5\0X\6\1Ä'\5\n\0'\6\t\0&\4\6\4=\4\6\2'\4\f\0:\5\2\3\14\0\5\0X\6\1Ä'\5\n\0'\6\r\0&\4\6\4=\4\v\2L\2\2\0\6)\n    (\tmenu\5\6 \1\0\1\14trimempty\2\a%s\tkind\nsplit\bvim\1\0\2\tmode\16symbol_text\rmaxwidth\0032\15cmp_format\flspkind\frequire_\0\1\3\1\3\0\r-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\3Ä-\1\0\0009\1\2\1B\1\1\1K\0\1\0\2¿\rcomplete\21select_next_item\fvisibleY\0\1\4\1\2\0\r-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\3\1\0B\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\18change_choice\18choice_active_\0\1\3\1\3\0\r-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\3Ä-\1\0\0009\1\2\1B\1\1\1K\0\1\0\2¿\rcomplete\21select_prev_item\fvisiblec\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\19expand_or_jump\31expand_or_locally_jumpableO\0\1\4\1\2\0\14-\1\0\0009\1\0\1)\3ˇˇB\1\2\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\3ˇˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\tjump\rjumpableâ\1\0\1\5\1\6\0\17-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\tÄ-\1\0\0009\1\1\0015\3\4\0-\4\0\0009\4\2\0049\4\3\4=\4\5\3B\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\fconfirm\fvisible¢\t\1\0\16\0L\0~6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0009\2\4\0025\4\15\0004\5\0\b9\6\5\0015\a\t\0005\b\a\0004\t\3\0005\n\6\0>\n\1\t=\t\b\b=\b\n\a<\a\6\0059\6\v\0015\a\14\0005\b\r\0004\t\3\0005\n\f\0>\n\1\t=\t\b\b=\b\n\a<\a\6\5=\5\16\4B\2\2\0016\2\0\0'\4\17\0B\2\2\0026\3\0\0'\5\18\0B\3\2\0029\4\19\2\18\6\4\0009\4\20\4'\a\21\0009\b\22\3B\b\1\0A\4\2\0013\4\23\0009\5\4\0025\a\27\0005\b\25\0003\t\24\0=\t\26\b=\b\28\a5\b\30\0005\t\29\0=\t\31\b=\b \a5\b\"\0005\t!\0=\t#\b3\t$\0=\t%\b=\b&\a5\b*\0009\t'\0029\v'\0029\v(\vB\v\1\0025\f)\0B\t\3\2=\t+\b9\t'\0023\v,\0005\f-\0B\t\3\2=\t.\b9\t'\0023\v/\0005\f0\0B\t\3\2=\t1\b9\t'\0023\v2\0005\f3\0B\t\3\2=\t4\b9\t'\0023\v5\0005\f6\0B\t\3\2=\t7\b9\t'\0023\v8\0005\f9\0B\t\3\2=\t:\b9\t'\0025\v@\0009\f'\0029\f;\f5\14>\0009\15<\0029\15=\15=\15?\14B\f\2\2=\fA\v3\fB\0=\fC\vB\t\2\2=\tD\b=\b'\a4\b\6\0005\tE\0>\t\1\b5\tF\0>\t\2\b5\tG\0>\t\3\b5\tH\0>\t\4\b5\tI\0>\t\5\b=\bJ\aB\5\2\0016\5\0\0'\aK\0B\5\2\0012\0\0ÄK\0\1\0\rsnippets\fsources\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lua\1\0\1\tname\rnvim_lsp\t<CR>\6c\0\6i\1\0\0\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\fconfirm\f<S-Tab>\1\3\0\0\6i\6s\0\n<Tab>\1\3\0\0\6i\6s\0\n<C-p>\1\3\0\0\6i\6s\0\n<C-e>\1\3\0\0\6i\6s\0\n<C-n>\1\3\0\0\6i\6s\0\15<C-x><C-o>\1\0\0\1\3\0\0\6i\6s\rcomplete\fmapping\15formatting\vformat\0\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\vwindow\15completion\1\0\0\1\0\3\17side_padding\3\0\15col_offset\3˝ˇˇˇ\15\17winhighlight/Normal:Pmenu,FloatBorder:Pmenu,Search:None\fsnippet\1\0\0\vexpand\1\0\0\0\0\20on_confirm_done\17confirm_done\aon\nevent\"nvim-autopairs.completion.cmp\bcmp\rext_opts\1\0\0\1\0\0\1\0\0\1\3\0\0\t ‚ÆÑ\fKeyword\15insertNode\vactive\1\0\0\14virt_text\1\0\0\1\3\0\0\t ‚ÆÉ\vRepeat\15choiceNode\nsetup\vconfig\23luasnip.util.types\fluasnip\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp",
    wants = { "lspkind-nvim", "LuaSnip" }
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n†\2\0\1\a\1\15\0\0255\1\3\0006\2\0\0'\4\1\0B\2\2\0029\2\2\2B\2\1\2=\2\4\0015\2\v\0006\3\5\0009\3\6\0039\3\a\0036\5\5\0009\5\6\0059\5\b\0059\5\t\0055\6\n\0B\3\3\2=\3\f\2=\2\r\1-\2\0\0008\2\0\0029\2\14\2\18\4\1\0B\2\2\1K\0\1\0\0¿\nsetup\rhandlers$textDocument/publishDiagnostics\1\0\0\1\0\2\17virtual_text\1\nsigns\1\27on_publish_diagnostics\15diagnostic\twith\blsp\bvim\17capabilities\1\0\0\25default_capabilities\17cmp_nvim_lsp\frequire™\4\1\0\n\0\25\0=6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\0\0'\a\6\0B\5\2\0029\5\a\0055\a\t\0005\b\b\0=\b\n\aB\5\2\0016\5\0\0'\a\v\0B\5\2\0029\5\a\5B\5\1\0016\5\0\0'\a\f\0B\5\2\0029\5\a\5B\5\1\0019\5\a\1B\5\1\0019\5\a\0025\a\14\0005\b\r\0=\b\15\aB\5\2\0019\5\16\0024\a\3\0003\b\17\0>\b\1\aB\5\2\0019\5\a\0035\a\19\0005\b\18\0=\b\15\aB\5\2\0019\5\a\0045\a\23\0004\b\3\0009\t\20\0049\t\21\t9\t\22\t>\t\1\b=\b\24\aB\5\2\0012\0\0ÄK\0\1\0\fsources\1\0\0\vstylua\15formatting\rbuiltins\1\0\2\20automatic_setup\2\27automatic_installation\2\1\3\0\0\vstylua\ajq\0\19setup_handlers\21ensure_installed\1\0\1\27automatic_installation\2\1\2\0\0\16sumneko_lua\vfidget\rdressing\23code_action_prompt\1\0\0\1\0\1\17virtual_text\1\nsetup\flspsaga\fnull-ls\18mason-null-ls\20mason-lspconfig\nmason\14lspconfig\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig",
    wants = { "mason.nvim", "mason-lspconfig.nvim", "cmp-nvim-lsp" }
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\nﬁ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\1\0\n\16normal_line\asA\16insert_line\v<C-g>S\15normal_cur\bsas\16visual_line\agS\vnormal\asa\vvisual\6S\vinsert\v<C-g>s\vchange\asc\vdelete\asd\20normal_cur_line\bsAS\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nX\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\afn2nvim-tree.actions.tree-modifiers.collapse-all\frequire§\2\0\0\6\2\n\0('\0\0\0-\1\0\0009\1\1\1B\1\1\0029\2\2\1\15\0\2\0X\3\14Ä9\2\3\1\15\0\2\0X\3\vÄ6\2\4\0'\4\5\0B\2\2\0029\2\6\2\18\4\0\0009\5\2\1B\2\3\1-\2\1\0009\2\a\2B\2\1\1X\2\18Ä9\2\3\1\n\2\0\0X\2\5Ä-\2\0\0009\2\b\2\18\4\1\0B\2\2\1X\2\nÄ6\2\4\0'\4\5\0B\2\2\0029\2\6\2\18\4\0\0009\5\t\1B\2\3\1-\2\1\0009\2\a\2B\2\1\1K\0\1\0\0¿\1¿\18absolute_path\23expand_or_collapse\nclose\afn%nvim-tree.actions.node.open-file\frequire\nnodes\flink_to\23get_node_at_cursor\tedit∫\2\0\0\6\2\v\0%'\0\0\0-\1\0\0009\1\1\1B\1\1\0029\2\2\1\15\0\2\0X\3\vÄ9\2\3\1\14\0\2\0X\2\bÄ6\2\4\0'\4\5\0B\2\2\0029\2\6\2\18\4\0\0009\5\2\1B\2\3\1X\2\15Ä9\2\3\1\n\2\0\0X\2\5Ä-\2\0\0009\2\a\2\18\4\1\0B\2\2\1X\2\aÄ6\2\4\0'\4\b\0B\2\2\0029\2\6\2\18\4\0\0009\5\t\1B\2\3\1-\2\1\0009\2\n\2B\2\1\1K\0\1\0\0¿\1¿\nfocus\18absolute_path%nvim-tree.actions.node.open-file\23expand_or_collapse\afn$nvim-tree.action.node.open-file\frequire\nnodes\flink_to\23get_node_at_cursor\vvsplit‘\17\1\0\r\0N\0é\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0003\3\4\0003\4\5\0006\5\0\0'\a\6\0B\5\2\0029\5\a\0055\aD\0005\b\b\0005\t\t\0004\n6\0005\v\v\0005\f\n\0=\f\f\v>\v\1\n5\v\r\0>\v\2\n5\v\14\0>\v\3\n5\v\15\0>\v\4\n5\v\16\0=\3\17\v>\v\5\n5\v\18\0>\v\6\n5\v\19\0=\4\17\v>\v\a\n5\v\20\0=\2\17\v>\v\b\n5\v\21\0>\v\t\n5\v\22\0>\v\n\n5\v\23\0>\v\v\n5\v\24\0>\v\f\n5\v\25\0>\v\r\n5\v\26\0>\v\14\n5\v\27\0>\v\15\n5\v\28\0>\v\16\n5\v\29\0>\v\17\n5\v\30\0>\v\18\n5\v\31\0>\v\19\n5\v \0>\v\20\n5\v!\0>\v\21\n5\v\"\0>\v\22\n5\v#\0>\v\23\n5\v$\0>\v\24\n5\v%\0>\v\25\n5\v&\0>\v\26\n5\v'\0>\v\27\n5\v(\0>\v\28\n5\v)\0>\v\29\n5\v*\0>\v\30\n5\v+\0>\v\31\n5\v,\0>\v \n5\v-\0>\v!\n5\v.\0>\v\"\n5\v/\0>\v#\n5\v0\0>\v$\n5\v1\0>\v%\n5\v2\0>\v&\n5\v3\0>\v'\n5\v4\0>\v(\n5\v5\0>\v)\n5\v6\0>\v*\n5\v7\0>\v+\n5\v8\0>\v,\n5\v9\0>\v-\n5\v:\0>\v.\n5\v;\0>\v/\n5\v<\0>\v0\n5\v=\0>\v1\n5\v>\0>\v2\n5\v?\0>\v3\n5\v@\0>\v4\n5\vA\0>\v5\n=\nB\t=\tC\b=\bE\a5\bG\0005\tF\0=\tH\b=\bI\a5\bK\0005\tJ\0=\tL\b=\bM\aB\5\2\0012\0\0ÄK\0\1\0\rrenderer\19indent_markers\1\0\0\1\0\1\venable\2\ffilters\vcustom\1\0\0\1\2\0\0\v^.git$\tview\1\0\0\rmappings\tlist\1\0\2\vaction\14bulk_move\bkey\bbmv\1\0\2\vaction\16toggle_mark\bkey\6m\1\0\2\vaction\16toggle_help\bkey\ag?\1\0\2\vaction\21toggle_file_info\bkey\n<C-k>\1\0\2\vaction\21run_file_command\bkey\6.\1\0\2\vaction\16search_node\bkey\6S\1\0\2\vaction\15expand_all\bkey\6E\1\0\2\vaction\17collapse_all\bkey\6W\1\0\2\vaction\nclose\bkey\6q\1\0\2\vaction\22clear_live_filter\bkey\6F\1\0\2\vaction\16live_filter\bkey\6f\1\0\2\vaction\16system_open\bkey\6s\1\0\2\vaction\vdir_up\bkey\6-\1\0\2\vaction\18next_git_item\bkey\a]c\1\0\2\vaction\19next_diag_item\bkey\a]e\1\0\2\vaction\18prev_git_item\bkey\a[c\1\0\2\vaction\19prev_diag_item\bkey\a[e\1\0\2\vaction\23copy_absolute_path\bkey\agy\1\0\2\vaction\14copy_path\bkey\6Y\1\0\2\vaction\14copy_name\bkey\6y\1\0\2\vaction\npaste\bkey\6p\1\0\2\vaction\tcopy\bkey\6c\1\0\2\vaction\bcut\bkey\6x\1\0\2\vaction\20rename_basename\bkey\6e\1\0\2\vaction\16full_rename\bkey\n<C-r>\1\0\2\vaction\vrename\bkey\6r\1\0\2\vaction\ntrash\bkey\6D\1\0\2\vaction\vremove\bkey\6d\1\0\2\vaction\vcreate\bkey\6a\1\0\2\vaction\frefresh\bkey\6R\1\0\2\vaction\18toggle_custom\bkey\6U\1\0\2\vaction\21toggle_no_buffer\bkey\6B\1\0\2\vaction\20toggle_dotfiles\bkey\6H\1\0\2\vaction\23toggle_git_ignored\bkey\6I\1\0\2\vaction\21toggle_git_clean\bkey\6C\1\0\2\vaction\17last_sibling\bkey\6J\1\0\2\vaction\18first_sibling\bkey\6K\1\0\2\vaction\fpreview\bkey\n<Tab>\1\0\2\vaction\15close_node\bkey\t<BS>\1\0\2\vaction\16parent_node\bkey\6P\1\0\2\vaction\17next_sibling\bkey\6>\1\0\2\vaction\17prev_sibling\bkey\6<\1\0\2\vaction\vtabnew\bkey\n<C-t>\1\0\2\vaction\nsplit\bkey\n<C-x>\1\0\2\vaction\vvsplit\bkey\n<C-v>\1\0\2\vaction\17collapse_all\bkey\6H\1\0\2\vaction\19vsplit_preview\bkey\6L\1\0\2\vaction\15close_node\bkey\6h\14action_cb\1\0\2\vaction\tedit\bkey\6l\1\0\2\vaction\acd\bkey\n<C-]>\1\0\2\vaction\19edit_no_picker\bkey\6O\1\0\2\vaction\18edit_in_place\bkey\n<C-e>\bkey\1\0\1\vaction\tedit\1\3\0\0\t<CR>\6o\1\0\1\16custom_only\2\1\0\1\nwidth\3\20\nsetup\14nvim-tree\0\0\0\19nvim-tree.view\18nvim-tree.lib\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treeclimber"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-treeclimber",
    url = "https://github.com/Dkendal/nvim-treeclimber"
  },
  ["nvim-treehopper"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-treehopper",
    url = "https://github.com/mfussenegger/nvim-treehopper"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n”\a\0\0\a\0,\00086\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0005\5\5\0=\5\6\4=\4\a\0035\4\b\0005\5\t\0=\5\n\4=\4\v\0035\4\f\0=\4\r\0035\4\15\0005\5\14\0=\5\16\0045\5\17\0=\5\18\0045\5\19\0005\6\20\0=\6\n\5=\5\21\0045\5\22\0005\6\23\0=\6\n\5=\5\24\4=\4\25\0035\4\28\0005\5\26\0005\6\27\0=\6\n\5=\5\29\4=\4\30\0035\4\31\0=\4 \0035\4!\0004\5\0\0=\5\6\4=\4\"\3B\1\2\0016\1#\0009\1$\1'\2&\0=\2%\0016\1#\0009\1$\1'\2(\0=\2'\0016\1#\0009\1)\0019\1*\1'\3+\0B\1\2\1K\0\1\0\fgruvbox\16colorscheme\bcmd\31nvim_treesitter#foldexpr()\rfoldexpr\texpr\15foldmethod\bopt\bvim\npairs\1\0\1\venable\2\frainbow\1\0\2\venable\2\18extended_mode\2\16textobjects\vselect\1\0\0\1\0\4\aac\17@class.outer\aic\17@class.inner\aaf\20@function.outer\aif\20@function.inner\1\0\1\venable\2\rrefactor\15navigation\1\0\5\24goto_previous_usage\bgpu\20goto_definition\bgnd\20goto_next_usage\bgnu\25list_definitions_toc\agO\21list_definitions\bgnD\1\0\1\venable\2\17smart_rename\1\0\1\17smart_rename\bgrr\1\0\1\venable\2\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\1\vindent\1\0\1\venable\1\26incremental_selection\fkeymaps\1\0\4\19init_selection\bgnn\21node_decremental\bgrm\21node_incremental\bgrn\22scope_incremental\bgrc\1\0\1\venable\2\14highlight\fdisable\1\2\0\0\rmarkdown\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-pairs"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-treesitter-pairs",
    url = "https://github.com/theHamsta/nvim-treesitter-pairs"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["nvim-yati"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-yati",
    url = "https://github.com/yioneko/nvim-yati"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/navarasu/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["pretty-fold.nvim"] = {
    config = { "\27LJ\2\n)\0\1\5\0\2\0\0059\1\0\0\18\3\1\0009\1\1\1)\4\3\0D\1\3\0\brep\14fill_char¥\3\1\0\6\0\20\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0003\5\a\0>\5\6\4=\4\b\3=\3\n\0024\3\0\0=\3\v\0025\3\f\0=\3\r\0024\3\4\0005\4\14\0>\4\1\0035\4\15\0>\4\2\0035\4\16\0>\4\3\3=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\14ft_ignore\1\2\0\0\nneorg\21matchup_patterns\1\3\0\0\a%[\6]\1\3\0\0\a%(\6)\1\3\0\0\6{\6}\15stop_words\1\2\0\0\14@brief%s*\18comment_signs\rsections\1\0\5\22add_close_pattern\2\26process_comment_signs\vspaces\21keep_indentation\2\24remove_fold_markers\1\14fill_char\b‚Ä¢\nright\0\1\6\0\0\6 \27number_of_folded_lines\a: \15percentage\6 \tleft\1\0\0\1\2\0\0\fcontent\nsetup\16pretty-fold\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/pretty-fold.nvim",
    url = "https://github.com/anuvyklack/pretty-fold.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope-ghq.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/telescope-ghq.nvim",
    url = "https://github.com/nvim-telescope/telescope-ghq.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nb\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\4\0B\0\2\1K\0\1\0\bghq\19load_extension\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["treesitter-unit"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/treesitter-unit",
    url = "https://github.com/David-Kunz/treesitter-unit"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-nightfly-guicolors"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/vim-nightfly-guicolors",
    url = "https://github.com/bluz71/vim-nightfly-guicolors"
  },
  ["vim-partedit"] = {
    config = { "\27LJ\2\n8\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\vvsplit\20partedit#opener\6g\bvim\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/vim-partedit",
    url = "https://github.com/thinca/vim-partedit"
  },
  ["vim-qfreplace"] = {
    commands = { "Qfreplace" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/vim-qfreplace",
    url = "https://github.com/thinca/vim-qfreplace"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n\\\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fplugins\1\0\0\1\0\1\14registers\1\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  winresizer = {
    config = { "\27LJ\2\nê\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\n\0=\1\4\0006\0\0\0009\0\1\0)\1\5\0=\1\5\0K\0\1\0\28winresizer_horiz_resize\27winresizer_vert_resize\15<C-w><C-e>\25winresizer_start_key\6g\bvim\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/winresizer",
    url = "https://github.com/simeji/winresizer"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^cmp"] = "nvim-cmp"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: vim-partedit
time([[Config for vim-partedit]], true)
try_loadstring("\27LJ\2\n8\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\vvsplit\20partedit#opener\6g\bvim\0", "config", "vim-partedit")
time([[Config for vim-partedit]], false)
-- Config for: pretty-fold.nvim
time([[Config for pretty-fold.nvim]], true)
try_loadstring("\27LJ\2\n)\0\1\5\0\2\0\0059\1\0\0\18\3\1\0009\1\1\1)\4\3\0D\1\3\0\brep\14fill_char¥\3\1\0\6\0\20\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0003\5\a\0>\5\6\4=\4\b\3=\3\n\0024\3\0\0=\3\v\0025\3\f\0=\3\r\0024\3\4\0005\4\14\0>\4\1\0035\4\15\0>\4\2\0035\4\16\0>\4\3\3=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\14ft_ignore\1\2\0\0\nneorg\21matchup_patterns\1\3\0\0\a%[\6]\1\3\0\0\a%(\6)\1\3\0\0\6{\6}\15stop_words\1\2\0\0\14@brief%s*\18comment_signs\rsections\1\0\5\22add_close_pattern\2\26process_comment_signs\vspaces\21keep_indentation\2\24remove_fold_markers\1\14fill_char\b‚Ä¢\nright\0\1\6\0\0\6 \27number_of_folded_lines\a: \15percentage\6 \tleft\1\0\0\1\2\0\0\fcontent\nsetup\16pretty-fold\frequire\0", "config", "pretty-fold.nvim")
time([[Config for pretty-fold.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nƒ\6\0\0\6\0&\0?6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\15\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0004\5\0\0=\5\t\0044\5\0\0=\5\n\4=\4\v\0034\4\0\0=\4\f\0035\4\r\0=\4\14\3=\3\16\0025\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0034\4\3\0005\5\22\0>\5\1\4=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\28\0=\4\29\3=\3\30\0025\3\31\0004\4\0\0=\4\19\0034\4\3\0005\5 \0>\5\1\4=\4\21\0034\4\0\0=\4\23\0034\4\0\0=\4\25\0034\4\3\0005\5!\0>\5\1\4=\4\27\0034\4\0\0=\4\29\3=\3\"\0024\3\0\0=\3\n\0024\3\0\0=\3#\0025\3$\0=\3%\2B\0\2\1K\0\1\0\15extensions\1\3\0\0\14nvim-tree\rquickfix\20inactive_winbar\ftabline\1\2\1\0\fwindows\tmode\3\2\1\2\1\0\ttabs\tmode\3\2\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\5\0\0\16searchcount\rencoding\15fileformat\rfiletype\14lualine_c\1\2\1\0\rfilename\tpath\3\1\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\frefresh\1\0\3\ftabline\3¨\2\vwinbar\3¨\2\15statusline\3¨\2\17ignore_focus\23disabled_filetypes\vwinbar\15statusline\1\0\0\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\1\0\4\ntheme\tauto\18icons_enabled\2\17globalstatus\2\25always_divide_middle\2\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n\\\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fplugins\1\0\0\1\0\1\14registers\1\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nb\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\1\0B\0\2\0029\0\3\0'\2\4\0B\0\2\1K\0\1\0\bghq\19load_extension\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\na\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0009\4\4\1B\2\2\1K\0\1\0\vconfig\nsetup\27alpha.themes.dashboard\nalpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n†\2\0\1\a\1\15\0\0255\1\3\0006\2\0\0'\4\1\0B\2\2\0029\2\2\2B\2\1\2=\2\4\0015\2\v\0006\3\5\0009\3\6\0039\3\a\0036\5\5\0009\5\6\0059\5\b\0059\5\t\0055\6\n\0B\3\3\2=\3\f\2=\2\r\1-\2\0\0008\2\0\0029\2\14\2\18\4\1\0B\2\2\1K\0\1\0\0¿\nsetup\rhandlers$textDocument/publishDiagnostics\1\0\0\1\0\2\17virtual_text\1\nsigns\1\27on_publish_diagnostics\15diagnostic\twith\blsp\bvim\17capabilities\1\0\0\25default_capabilities\17cmp_nvim_lsp\frequire™\4\1\0\n\0\25\0=6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\0\0'\a\6\0B\5\2\0029\5\a\0055\a\t\0005\b\b\0=\b\n\aB\5\2\0016\5\0\0'\a\v\0B\5\2\0029\5\a\5B\5\1\0016\5\0\0'\a\f\0B\5\2\0029\5\a\5B\5\1\0019\5\a\1B\5\1\0019\5\a\0025\a\14\0005\b\r\0=\b\15\aB\5\2\0019\5\16\0024\a\3\0003\b\17\0>\b\1\aB\5\2\0019\5\a\0035\a\19\0005\b\18\0=\b\15\aB\5\2\0019\5\a\0045\a\23\0004\b\3\0009\t\20\0049\t\21\t9\t\22\t>\t\1\b=\b\24\aB\5\2\0012\0\0ÄK\0\1\0\fsources\1\0\0\vstylua\15formatting\rbuiltins\1\0\2\20automatic_setup\2\27automatic_installation\2\1\3\0\0\vstylua\ajq\0\19setup_handlers\21ensure_installed\1\0\1\27automatic_installation\2\1\2\0\0\16sumneko_lua\vfidget\rdressing\23code_action_prompt\1\0\0\1\0\1\17virtual_text\1\nsetup\flspsaga\fnull-ls\18mason-null-ls\20mason-lspconfig\nmason\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nœ\2\0\0\5\0\v\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\2B\0\2\0016\0\0\0'\2\n\0B\0\2\0026\1\0\0'\3\1\0B\1\2\2K\0\1\0\24nvim-autopairs.rule\14fast_wrap\nchars\1\6\0\0\6{\6[\6(\6\"\6'\1\0\a\18highligh_grey\fComment\fend_key\6$\14highlight\vSearch\fpattern\23[%'%\"%)%>%]%)%}%,]\16check_comma\2\bmap\n<M-e>\tkeys\30qwertyuiiopzxcvnmasdfghkl\21disable_filetype\1\0\0\1\2\0\0\20TelescopePrompt\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nJ\0\0\4\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\1K\0\1\0\1\0\1\tkeys\17asdfqwerzxcv\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0", "config", "neoscroll.nvim")
time([[Config for neoscroll.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nX\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\afn2nvim-tree.actions.tree-modifiers.collapse-all\frequire§\2\0\0\6\2\n\0('\0\0\0-\1\0\0009\1\1\1B\1\1\0029\2\2\1\15\0\2\0X\3\14Ä9\2\3\1\15\0\2\0X\3\vÄ6\2\4\0'\4\5\0B\2\2\0029\2\6\2\18\4\0\0009\5\2\1B\2\3\1-\2\1\0009\2\a\2B\2\1\1X\2\18Ä9\2\3\1\n\2\0\0X\2\5Ä-\2\0\0009\2\b\2\18\4\1\0B\2\2\1X\2\nÄ6\2\4\0'\4\5\0B\2\2\0029\2\6\2\18\4\0\0009\5\t\1B\2\3\1-\2\1\0009\2\a\2B\2\1\1K\0\1\0\0¿\1¿\18absolute_path\23expand_or_collapse\nclose\afn%nvim-tree.actions.node.open-file\frequire\nnodes\flink_to\23get_node_at_cursor\tedit∫\2\0\0\6\2\v\0%'\0\0\0-\1\0\0009\1\1\1B\1\1\0029\2\2\1\15\0\2\0X\3\vÄ9\2\3\1\14\0\2\0X\2\bÄ6\2\4\0'\4\5\0B\2\2\0029\2\6\2\18\4\0\0009\5\2\1B\2\3\1X\2\15Ä9\2\3\1\n\2\0\0X\2\5Ä-\2\0\0009\2\a\2\18\4\1\0B\2\2\1X\2\aÄ6\2\4\0'\4\b\0B\2\2\0029\2\6\2\18\4\0\0009\5\t\1B\2\3\1-\2\1\0009\2\n\2B\2\1\1K\0\1\0\0¿\1¿\nfocus\18absolute_path%nvim-tree.actions.node.open-file\23expand_or_collapse\afn$nvim-tree.action.node.open-file\frequire\nnodes\flink_to\23get_node_at_cursor\vvsplit‘\17\1\0\r\0N\0é\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0003\3\4\0003\4\5\0006\5\0\0'\a\6\0B\5\2\0029\5\a\0055\aD\0005\b\b\0005\t\t\0004\n6\0005\v\v\0005\f\n\0=\f\f\v>\v\1\n5\v\r\0>\v\2\n5\v\14\0>\v\3\n5\v\15\0>\v\4\n5\v\16\0=\3\17\v>\v\5\n5\v\18\0>\v\6\n5\v\19\0=\4\17\v>\v\a\n5\v\20\0=\2\17\v>\v\b\n5\v\21\0>\v\t\n5\v\22\0>\v\n\n5\v\23\0>\v\v\n5\v\24\0>\v\f\n5\v\25\0>\v\r\n5\v\26\0>\v\14\n5\v\27\0>\v\15\n5\v\28\0>\v\16\n5\v\29\0>\v\17\n5\v\30\0>\v\18\n5\v\31\0>\v\19\n5\v \0>\v\20\n5\v!\0>\v\21\n5\v\"\0>\v\22\n5\v#\0>\v\23\n5\v$\0>\v\24\n5\v%\0>\v\25\n5\v&\0>\v\26\n5\v'\0>\v\27\n5\v(\0>\v\28\n5\v)\0>\v\29\n5\v*\0>\v\30\n5\v+\0>\v\31\n5\v,\0>\v \n5\v-\0>\v!\n5\v.\0>\v\"\n5\v/\0>\v#\n5\v0\0>\v$\n5\v1\0>\v%\n5\v2\0>\v&\n5\v3\0>\v'\n5\v4\0>\v(\n5\v5\0>\v)\n5\v6\0>\v*\n5\v7\0>\v+\n5\v8\0>\v,\n5\v9\0>\v-\n5\v:\0>\v.\n5\v;\0>\v/\n5\v<\0>\v0\n5\v=\0>\v1\n5\v>\0>\v2\n5\v?\0>\v3\n5\v@\0>\v4\n5\vA\0>\v5\n=\nB\t=\tC\b=\bE\a5\bG\0005\tF\0=\tH\b=\bI\a5\bK\0005\tJ\0=\tL\b=\bM\aB\5\2\0012\0\0ÄK\0\1\0\rrenderer\19indent_markers\1\0\0\1\0\1\venable\2\ffilters\vcustom\1\0\0\1\2\0\0\v^.git$\tview\1\0\0\rmappings\tlist\1\0\2\vaction\14bulk_move\bkey\bbmv\1\0\2\vaction\16toggle_mark\bkey\6m\1\0\2\vaction\16toggle_help\bkey\ag?\1\0\2\vaction\21toggle_file_info\bkey\n<C-k>\1\0\2\vaction\21run_file_command\bkey\6.\1\0\2\vaction\16search_node\bkey\6S\1\0\2\vaction\15expand_all\bkey\6E\1\0\2\vaction\17collapse_all\bkey\6W\1\0\2\vaction\nclose\bkey\6q\1\0\2\vaction\22clear_live_filter\bkey\6F\1\0\2\vaction\16live_filter\bkey\6f\1\0\2\vaction\16system_open\bkey\6s\1\0\2\vaction\vdir_up\bkey\6-\1\0\2\vaction\18next_git_item\bkey\a]c\1\0\2\vaction\19next_diag_item\bkey\a]e\1\0\2\vaction\18prev_git_item\bkey\a[c\1\0\2\vaction\19prev_diag_item\bkey\a[e\1\0\2\vaction\23copy_absolute_path\bkey\agy\1\0\2\vaction\14copy_path\bkey\6Y\1\0\2\vaction\14copy_name\bkey\6y\1\0\2\vaction\npaste\bkey\6p\1\0\2\vaction\tcopy\bkey\6c\1\0\2\vaction\bcut\bkey\6x\1\0\2\vaction\20rename_basename\bkey\6e\1\0\2\vaction\16full_rename\bkey\n<C-r>\1\0\2\vaction\vrename\bkey\6r\1\0\2\vaction\ntrash\bkey\6D\1\0\2\vaction\vremove\bkey\6d\1\0\2\vaction\vcreate\bkey\6a\1\0\2\vaction\frefresh\bkey\6R\1\0\2\vaction\18toggle_custom\bkey\6U\1\0\2\vaction\21toggle_no_buffer\bkey\6B\1\0\2\vaction\20toggle_dotfiles\bkey\6H\1\0\2\vaction\23toggle_git_ignored\bkey\6I\1\0\2\vaction\21toggle_git_clean\bkey\6C\1\0\2\vaction\17last_sibling\bkey\6J\1\0\2\vaction\18first_sibling\bkey\6K\1\0\2\vaction\fpreview\bkey\n<Tab>\1\0\2\vaction\15close_node\bkey\t<BS>\1\0\2\vaction\16parent_node\bkey\6P\1\0\2\vaction\17next_sibling\bkey\6>\1\0\2\vaction\17prev_sibling\bkey\6<\1\0\2\vaction\vtabnew\bkey\n<C-t>\1\0\2\vaction\nsplit\bkey\n<C-x>\1\0\2\vaction\vvsplit\bkey\n<C-v>\1\0\2\vaction\17collapse_all\bkey\6H\1\0\2\vaction\19vsplit_preview\bkey\6L\1\0\2\vaction\15close_node\bkey\6h\14action_cb\1\0\2\vaction\tedit\bkey\6l\1\0\2\vaction\acd\bkey\n<C-]>\1\0\2\vaction\19edit_no_picker\bkey\6O\1\0\2\vaction\18edit_in_place\bkey\n<C-e>\bkey\1\0\1\vaction\tedit\1\3\0\0\t<CR>\6o\1\0\1\16custom_only\2\1\0\1\nwidth\3\20\nsetup\14nvim-tree\0\0\0\19nvim-tree.view\18nvim-tree.lib\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: aerial.nvim
time([[Config for aerial.nvim]], true)
try_loadstring("\27LJ\2\ne\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\1\0B\0\2\1K\0\1\0\19load_extension\14telescope\nsetup\vaerial\frequire\0", "config", "aerial.nvim")
time([[Config for aerial.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\nﬁ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\1\0\n\16normal_line\asA\16insert_line\v<C-g>S\15normal_cur\bsas\16visual_line\agS\vnormal\asa\vvisual\6S\vinsert\v<C-g>s\vchange\asc\vdelete\asd\20normal_cur_line\bsAS\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n”\a\0\0\a\0,\00086\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0005\5\5\0=\5\6\4=\4\a\0035\4\b\0005\5\t\0=\5\n\4=\4\v\0035\4\f\0=\4\r\0035\4\15\0005\5\14\0=\5\16\0045\5\17\0=\5\18\0045\5\19\0005\6\20\0=\6\n\5=\5\21\0045\5\22\0005\6\23\0=\6\n\5=\5\24\4=\4\25\0035\4\28\0005\5\26\0005\6\27\0=\6\n\5=\5\29\4=\4\30\0035\4\31\0=\4 \0035\4!\0004\5\0\0=\5\6\4=\4\"\3B\1\2\0016\1#\0009\1$\1'\2&\0=\2%\0016\1#\0009\1$\1'\2(\0=\2'\0016\1#\0009\1)\0019\1*\1'\3+\0B\1\2\1K\0\1\0\fgruvbox\16colorscheme\bcmd\31nvim_treesitter#foldexpr()\rfoldexpr\texpr\15foldmethod\bopt\bvim\npairs\1\0\1\venable\2\frainbow\1\0\2\venable\2\18extended_mode\2\16textobjects\vselect\1\0\0\1\0\4\aac\17@class.outer\aic\17@class.inner\aaf\20@function.outer\aif\20@function.inner\1\0\1\venable\2\rrefactor\15navigation\1\0\5\24goto_previous_usage\bgpu\20goto_definition\bgnd\20goto_next_usage\bgnu\25list_definitions_toc\agO\21list_definitions\bgnD\1\0\1\venable\2\17smart_rename\1\0\1\17smart_rename\bgrr\1\0\1\venable\2\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\1\vindent\1\0\1\venable\1\26incremental_selection\fkeymaps\1\0\4\19init_selection\bgnn\21node_decremental\bgrm\21node_incremental\bgrn\22scope_incremental\bgrc\1\0\1\venable\2\14highlight\fdisable\1\2\0\0\rmarkdown\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16hint_enable\1\nsetup\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time([[Config for lsp_signature.nvim]], false)
-- Config for: winresizer
time([[Config for winresizer]], true)
try_loadstring("\27LJ\2\nê\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\n\0=\1\4\0006\0\0\0009\0\1\0)\1\5\0=\1\5\0K\0\1\0\28winresizer_horiz_resize\27winresizer_vert_resize\15<C-w><C-e>\25winresizer_start_key\6g\bvim\0", "config", "winresizer")
time([[Config for winresizer]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nP\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\15signcolumn\1\nnumhl\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'Qfreplace', function(cmdargs)
          require('packer.load')({'vim-qfreplace'}, { cmd = 'Qfreplace', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-qfreplace'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Qfreplace ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Neogit', function(cmdargs)
          require('packer.load')({'neogit'}, { cmd = 'Neogit', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'neogit'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Neogit ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType qf ++once lua require("packer.load")({'QFGrep'}, { ft = "qf" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'cmp-nvim-lsp-signature-help', 'cmp-nvim-lua', 'cmp-path', 'cmp_luasnip', 'cmp-buffer', 'cmp-cmdline', 'cmp-nvim-lsp-document-symbol'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
