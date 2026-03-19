-- NAME:    lua/zettnote/init.lua
-- AUTHOR:  marsh
-- NOTE:
--
-- lua require("utils.hotreload"):reload("zettnote")
--

local M = {}

-- デフォルト設定
M.defaults = {
  note_dir = "~/til/learn/memo/",
  note_ext = ".md",
}

-- 設定保持用
M.config = vim.deepcopy(M.defaults)

-- setup
function M.setup(opts)
    opts = opts or {}
    M.config = vim.tbl_deep_extend("force", {}, M.defaults, opts)
end


-- プラグイン本体の機能（例）
function M.create_note()
  local dir = M.config.note_dir
  vim.fn.mkdir(dir, "p")

  local ext = M.config.note_ext
  local filename = os.date("%Y%m%d%H%M%S") .. ext
  local fullpath = dir .. "/" .. filename

  vim.cmd("edit " .. fullpath)
end


return M
