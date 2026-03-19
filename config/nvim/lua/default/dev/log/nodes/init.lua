-- NAME:   dev/log/nodes/init.lua
-- AUTHOR: marsh
-- NOTE:
--
-- output message to logfile
--

M = {}
M.levels = {
    INFO = 1,
    WARN = 2,
    ERROR = 3,
    DEBUG = 4,
    TRACE = 5,
    MAX = 6,
}

local levels = {
    " INFO",
    " WARN",
    "ERROR",
    "DEBUG",
    "TRACE",
}

M.day = function()
    return os.date("%Y-%m-%d")
end

M.time = function()
    return os.date("%H:%M:%S")
end

M.level = function(level)
    if level < M.levels.MAX then
        return levels[level]
    else
        return ""
    end
end

return M

-- vim: sw=4 sts=4 expandtab fenc=utf-8
