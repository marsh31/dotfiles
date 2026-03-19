-- NAME:   hotreload.lua
-- AUTHOR: marsh
--
-- NOTE: 
--
--
--


local M = {}


function M:unload(module)
  local ok, reload_module = pcall(require, "plenary.reload")
  if ok then
    local reload = reload_module.reload_module
    reload(module)
    print("reload using plenary!!")

  else
    package.loaded[module] = nil
    print("reload without plenary!!")
  end
end


function M:load(module)
  local ok, mod = pcall(require, module)
  if ok and type(mod.setup) == "function" then
    local success, err = pcall(mod.setup, {})
    if not success then
      vim.notify("setup() failed: " .. err, vim.log.levels.ERROR)
    end
  end
end


function M:reload(module)
  self:unload(module)
  self:load(module)
end


return M

