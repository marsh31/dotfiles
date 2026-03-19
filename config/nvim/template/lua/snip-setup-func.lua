local M = {}

-- デフォルト設定
M.defaults = {}

-- 設定保持用
M.config = vim.deepcopy(M.defaults)

-- setup
function M.setup(opts)
  opts = opts or {}
  M.config = vim.tbl_deep_extend("force", {}, M.defaults, opts)
end

-- プラグイン本体の機能（例）

return M
