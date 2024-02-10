
M = {}

M.get_list = function ()
  return require("default/plug_cond/" .. vim.g.my_plugin_list)
end

return M
