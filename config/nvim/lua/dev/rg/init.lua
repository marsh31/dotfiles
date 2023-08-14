local M = {}

local function exec_rg(search_word, fn)
    local uv = vim.loop

    local cmd = "rg"
    local cmd_args = { "--vimgrep", "--hidden", search_word }

    local return_value = {}

    local stdio_pipe = uv.new_pipe()
    local options = {
        args = cmd_args,
        stdio = { nil, stdio_pipe, nil },
    }

    local handle = nil
    local on_exit = function(status)
        uv.close(handle)
        fn(return_value)
    end

    handle = uv.spawn(cmd, options, on_exit)

    uv.read_start(stdio_pipe, function(_, data)
        if data then
            for _, value in ipairs(vim.split(data, "\n", nil)) do
                local search_results = vim.split(value, ":")

                local search_result = {
                    filename = search_results[1],
                    lnum = search_results[2],
                    col = search_results[3],
                    text = search_results[4],
                }

                table.insert(return_value, search_result)
            end
        end
    end)
end

M.search = function()
    local log = require("dev.log")
    log.setup()

    exec_rg(
        "return",
        vim.schedule_wrap(function(data)
            local qfdata = {}

            for _, value in ipairs(data) do
                vim.cmd(string.format("badd ./%s", value.filename))
                local bufnr = vim.fn.bufnr(value.filename)

                local item = {
                    bufnr = bufnr,
                    lnum = value.lnum,
                    col = value.col,
                    text = value.text,
                }

                -- log.write(string.format("badd %s", value.filename))
                -- log.write(string.format("bufnr = %s", bufnr))

                table.insert(qfdata, item)
            end

            vim.fn.setqflist(qfdata, "r")
            vim.cmd("copen")
            log.write(string.format("inspect %s", vim.inspect(qfdata)))
        end)
    )
end

return M
