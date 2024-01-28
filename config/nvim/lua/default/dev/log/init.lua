-- NAME:   dev/log/init.lua
-- AUTHOR: marsh
-- NOTE:
--
-- output message to logfile
--
-- ex:
-- 2023-05-18 15:05:23  INFO /home/xxx/.config/nvim/test.log:20:0 msg
-- 2023-05-18 15:05:23  WARN /home/xxx/.config/nvim/test.log:20:0 msg
-- 2023-05-18 15:05:23 ERROR /home/xxx/.config/nvim/test.log:20:0 msg

M = {}
M.log_file_path = vim.fn.expand("~/neovim.log")
M.target = "No_Name"

local function format_msg(level, target, msg)
    return string.format(
        "%s %s %s %s %s\n",
        require("dev/log/nodes").day(),
        require("dev/log/nodes").time(),
        require("dev/log/nodes").level(level),
        target,
        msg
    )
end

local function append_to_logfile(logfile, target, message)
    local append_file = io.open(logfile, "a")
    if append_file ~= nil then
        io.output(append_file)
        io.write(format_msg(require("dev/log/nodes").levels.INFO, target, message))
        io.close(append_file)
    end
end


M.setup = function(filename, target)
    if filename == nil then
        return
    end

    M.log_file_path = filename
    M.target = target
end

M.write = function(msg)
    append_to_logfile(M.log_file_path, M.target, msg)
end

return M
