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
  ["dressing.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  everforest = {
    loaded = false,
    needs_bufread = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["github-nvim-theme"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nP\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\nnumhl\2\15signcolumn\1\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["lsp_signature.nvim"] = {
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
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\17globalstatus\2\nsetup\flualine\frequire\0" },
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
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/nvcode-color-schemes.vim",
    url = "https://github.com/christianchiarulli/nvcode-color-schemes.vim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nô\2\0\1\a\1\15\0\0255\1\3\0006\2\0\0'\4\1\0B\2\2\0029\2\2\2B\2\1\2=\2\4\0015\2\v\0006\3\5\0009\3\6\0039\3\a\0036\5\5\0009\5\6\0059\5\b\0059\5\t\0055\6\n\0B\3\3\2=\3\f\2=\2\r\1-\2\0\0008\2\0\0029\2\14\2\18\4\1\0B\2\2\1K\0\1\0\0¿\nsetup\rhandlers$textDocument/publishDiagnostics\1\0\0\1\0\1\17virtual_text\1\27on_publish_diagnostics\15diagnostic\twith\blsp\bvim\17capabilities\1\0\0\25default_capabilities\17cmp_nvim_lsp\frequire–\1\0\0\b\0\b\2!6\0\0\0006\2\1\0009\2\2\0029\2\3\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20Ä6\2\1\0009\2\2\0029\2\4\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\5\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\6\2'\5\a\0B\2\3\2\n\2\0\0X\2\2Ä+\2\1\0X\3\1Ä+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2_\0\1\3\1\3\0\r-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\3Ä-\1\0\0009\1\2\1B\1\1\1K\0\1\0\2¿\rcomplete\21select_next_item\fvisible_\0\1\3\1\3\0\r-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\3Ä-\1\0\0009\1\2\1B\1\1\1K\0\1\0\2¿\rcomplete\21select_prev_item\fvisibleâ\1\0\1\5\1\6\0\17-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\tÄ-\1\0\0009\1\1\0015\3\4\0-\4\0\0009\4\2\0049\4\3\4=\4\5\3B\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\fconfirm\fvisible¬\5\1\0\15\0+\0M6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\3\5\0034\5\3\0003\6\6\0>\6\1\5B\3\2\0013\3\a\0009\4\b\0025\6\r\0005\a\v\0009\b\t\0015\n\n\0B\b\2\2=\b\f\a=\a\14\0065\a\18\0009\b\15\0029\n\15\0029\n\16\nB\n\1\0025\v\17\0B\b\3\2=\b\19\a9\b\15\0023\n\20\0005\v\21\0B\b\3\2=\b\22\a9\b\15\0023\n\23\0005\v\24\0B\b\3\2=\b\25\a9\b\15\0025\n\31\0009\v\15\0029\v\26\v5\r\29\0009\14\27\0029\14\28\14=\14\30\rB\v\2\2=\v \n3\v!\0=\v\"\nB\b\2\2=\b#\a=\a\15\0064\a\6\0005\b$\0>\b\1\a5\b%\0>\b\2\a5\b&\0>\b\3\a5\b'\0>\b\4\a5\b(\0>\b\5\a=\a)\6B\4\2\0016\4\0\0'\6*\0B\4\2\0012\0\0ÄK\0\1\0\16modules/lsp\fsources\1\0\1\tname\vbuffer\1\0\1\tname\tpath\1\0\1\tname\rnvim_lua\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\rnvim_lsp\t<CR>\6c\0\6i\1\0\0\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\fconfirm\n<C-p>\1\3\0\0\6i\6s\0\n<C-n>\1\3\0\0\6i\6s\0\n<C-k>\1\0\0\1\3\0\0\6i\6s\rcomplete\fmapping\15formatting\1\0\0\vformat\1\0\0\1\0\3\tmode\vsymbol\rmaxwidth\0032\18ellipsis_char\b...\15cmp_format\nsetup\0\0\19setup_handlers\20mason-lspconfig\bcmp\flspkind\14lspconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treehopper"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-treehopper",
    url = "https://github.com/mfussenegger/nvim-treehopper"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n”\a\0\0\a\0,\00086\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0005\5\5\0=\5\6\4=\4\a\0035\4\b\0005\5\t\0=\5\n\4=\4\v\0035\4\f\0=\4\r\0035\4\15\0005\5\14\0=\5\16\0045\5\17\0=\5\18\0045\5\19\0005\6\20\0=\6\n\5=\5\21\0045\5\22\0005\6\23\0=\6\n\5=\5\24\4=\4\25\0035\4\28\0005\5\26\0005\6\27\0=\6\n\5=\5\29\4=\4\30\0035\4\31\0=\4 \0035\4!\0004\5\0\0=\5\6\4=\4\"\3B\1\2\0016\1#\0009\1$\1'\2&\0=\2%\0016\1#\0009\1$\1'\2(\0=\2'\0016\1#\0009\1)\0019\1*\1'\3+\0B\1\2\1K\0\1\0\fgruvbox\16colorscheme\bcmd\31nvim_treesitter#foldexpr()\rfoldexpr\texpr\15foldmethod\bopt\bvim\npairs\1\0\1\venable\2\frainbow\1\0\2\venable\2\18extended_mode\2\16textobjects\vselect\1\0\0\1\0\4\aac\17@class.outer\aic\17@class.inner\aif\20@function.inner\aaf\20@function.outer\1\0\1\venable\2\rrefactor\15navigation\1\0\5\21list_definitions\bgnD\24goto_previous_usage\bgpu\20goto_definition\bgnd\20goto_next_usage\bgnu\25list_definitions_toc\agO\1\0\1\venable\2\17smart_rename\1\0\1\17smart_rename\bgrr\1\0\1\venable\2\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\1\vindent\1\0\1\venable\1\26incremental_selection\fkeymaps\1\0\4\21node_decremental\bgrm\19init_selection\bgnn\22scope_incremental\bgrc\21node_incremental\bgrn\1\0\1\venable\2\14highlight\fdisable\1\2\0\0\rmarkdown\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0" },
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
  ["nvim-yati"] = {
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/nvim-yati",
    url = "https://github.com/yioneko/nvim-yati"
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
  ["pretty-fold.nvim"] = {
    config = { "\27LJ\2\n)\0\1\5\0\2\0\0059\1\0\0\18\3\1\0009\1\1\1)\4\3\0D\1\3\0\brep\14fill_char¥\3\1\0\6\0\20\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0003\5\a\0>\5\6\4=\4\b\3=\3\n\0024\3\0\0=\3\v\0025\3\f\0=\3\r\0024\3\4\0005\4\14\0>\4\1\0035\4\15\0>\4\2\0035\4\16\0>\4\3\3=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\14ft_ignore\1\2\0\0\nneorg\21matchup_patterns\1\3\0\0\a%[\6]\1\3\0\0\a%(\6)\1\3\0\0\6{\6}\15stop_words\1\2\0\0\14@brief%s*\18comment_signs\rsections\1\0\5\24remove_fold_markers\1\14fill_char\b‚Ä¢\22add_close_pattern\2\26process_comment_signs\vspaces\21keep_indentation\2\nright\0\1\6\0\0\6 \27number_of_folded_lines\a: \15percentage\6 \tleft\1\0\0\1\2\0\0\fcontent\nsetup\16pretty-fold\frequire\0" },
    loaded = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/start/pretty-fold.nvim",
    url = "https://github.com/anuvyklack/pretty-fold.nvim"
  },
  ["telescope-ghq.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/telescope-ghq.nvim",
    url = "https://github.com/nvim-telescope/telescope-ghq.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14telescope\frequire\0" },
    loaded = true,
    needs_bufread = true,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim",
    wants = { "telescope-ghq.nvim" }
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
    loaded = false,
    needs_bufread = false,
    path = "/home/marsh/.local/share/nvim/site/pack/packer/opt/vim-nightfly-guicolors",
    url = "https://github.com/bluz71/vim-nightfly-guicolors"
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

-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\2\2\0\n6\0\0\0'\2\1\0B\0\2\2-\1\0\0008\0\1\0-\2\1\0\14\0\2\0X\3\1Ä4\2\0\0D\0\2\0\0\0\0¿\22telescope.builtin\frequire\22\1\1\2\1\1\0\0033\1\0\0002\0\0ÄL\1\2\0\0¿\0\20\1\1\2\0\1\0\0033\1\0\0002\0\0ÄL\1\2\0\0y\0\0\4\3\4\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0-\3\0\0B\1\2\0019\1\3\0-\2\0\0008\1\2\1-\2\1\0008\1\2\1-\3\2\0\14\0\3\0X\4\1Ä4\3\0\0D\1\2\0\0\0\1\0\0¿\15extensions\19load_extension\14telescope\frequire\24\1\1\2\2\1\0\0033\1\0\0002\0\0ÄL\1\2\0\0¿\1¿\0\20\1\2\3\0\1\0\0033\2\0\0002\0\0ÄL\2\2\0\0Ë\1\1\0\n\0\r\0\"3\0\0\0003\1\1\0006\2\2\0009\2\3\0029\2\4\2'\4\5\0'\5\6\0\18\6\0\0'\b\a\0B\6\2\0024\a\0\0B\2\5\0016\2\2\0009\2\3\0029\2\4\2'\4\5\0'\5\b\0\18\6\0\0'\b\t\0B\6\2\0024\a\0\0B\2\5\0016\2\2\0009\2\3\0029\2\4\2'\4\5\0'\5\n\0\18\6\1\0'\b\v\0'\t\f\0B\6\3\0024\a\0\0B\2\5\1K\0\1\0\tlist\bghq\15<Leader>fq\16grep_string\15<Leader>fg\20command_history\15<Leader>f:\6n\bset\vkeymap\bvim\0\0\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
time([[packadd for telescope.nvim]], true)
vim.cmd [[packadd telescope.nvim]]
time([[packadd for telescope.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\1\17globalstatus\2\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: pretty-fold.nvim
time([[Config for pretty-fold.nvim]], true)
try_loadstring("\27LJ\2\n)\0\1\5\0\2\0\0059\1\0\0\18\3\1\0009\1\1\1)\4\3\0D\1\3\0\brep\14fill_char¥\3\1\0\6\0\20\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0003\5\a\0>\5\6\4=\4\b\3=\3\n\0024\3\0\0=\3\v\0025\3\f\0=\3\r\0024\3\4\0005\4\14\0>\4\1\0035\4\15\0>\4\2\0035\4\16\0>\4\3\3=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\14ft_ignore\1\2\0\0\nneorg\21matchup_patterns\1\3\0\0\a%[\6]\1\3\0\0\a%(\6)\1\3\0\0\6{\6}\15stop_words\1\2\0\0\14@brief%s*\18comment_signs\rsections\1\0\5\24remove_fold_markers\1\14fill_char\b‚Ä¢\22add_close_pattern\2\26process_comment_signs\vspaces\21keep_indentation\2\nright\0\1\6\0\0\6 \27number_of_folded_lines\a: \15percentage\6 \tleft\1\0\0\1\2\0\0\fcontent\nsetup\16pretty-fold\frequire\0", "config", "pretty-fold.nvim")
time([[Config for pretty-fold.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nP\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\nnumhl\2\15signcolumn\1\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n”\a\0\0\a\0,\00086\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0005\5\5\0=\5\6\4=\4\a\0035\4\b\0005\5\t\0=\5\n\4=\4\v\0035\4\f\0=\4\r\0035\4\15\0005\5\14\0=\5\16\0045\5\17\0=\5\18\0045\5\19\0005\6\20\0=\6\n\5=\5\21\0045\5\22\0005\6\23\0=\6\n\5=\5\24\4=\4\25\0035\4\28\0005\5\26\0005\6\27\0=\6\n\5=\5\29\4=\4\30\0035\4\31\0=\4 \0035\4!\0004\5\0\0=\5\6\4=\4\"\3B\1\2\0016\1#\0009\1$\1'\2&\0=\2%\0016\1#\0009\1$\1'\2(\0=\2'\0016\1#\0009\1)\0019\1*\1'\3+\0B\1\2\1K\0\1\0\fgruvbox\16colorscheme\bcmd\31nvim_treesitter#foldexpr()\rfoldexpr\texpr\15foldmethod\bopt\bvim\npairs\1\0\1\venable\2\frainbow\1\0\2\venable\2\18extended_mode\2\16textobjects\vselect\1\0\0\1\0\4\aac\17@class.outer\aic\17@class.inner\aif\20@function.inner\aaf\20@function.outer\1\0\1\venable\2\rrefactor\15navigation\1\0\5\21list_definitions\bgnD\24goto_previous_usage\bgpu\20goto_definition\bgnd\20goto_next_usage\bgnu\25list_definitions_toc\agO\1\0\1\venable\2\17smart_rename\1\0\1\17smart_rename\bgrr\1\0\1\venable\2\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\1\vindent\1\0\1\venable\1\26incremental_selection\fkeymaps\1\0\4\21node_decremental\bgrm\19init_selection\bgnn\22scope_incremental\bgrc\21node_incremental\bgrn\1\0\1\venable\2\14highlight\fdisable\1\2\0\0\rmarkdown\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'cmp-buffer', 'cmp-cmdline', 'cmp-nvim-lua', 'cmp-path', 'cmp-nvim-lsp-document-symbol', 'cmp-nvim-lsp-signature-help'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
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
