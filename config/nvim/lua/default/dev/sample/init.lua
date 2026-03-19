-- NAME:   dev/sample/init.lua
-- AUTHOR: marsh
--
-- NOTE:
--
--
--
--
--


M = {}

M.filter_opts = function (filter_opts, user_opts)
    local ret = {}
    for key, filter_opt in pairs(filter_opts) do
        local user_opt = user_opts[key] or false
        ret[key] = (filter_opt or user_opt)
    end

    return ret
end


return M
