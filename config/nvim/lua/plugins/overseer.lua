local list = require("default.pluginlist").get_list()
return {
    {
        "stevearc/overseer.nvim",
        cond = false,
        opts = {},
        config = function()
            local overseer = require("overseer")

            overseer.setup({
              -- templates = { "builtin", "user.cpp_build" },
              templates = { "builtin", "user.run_script" },
            })

            vim.api.nvim_create_user_command("WatchRun", function ()
              overseer.run_template({ name = "run script" }, function (task)
                if task then
                  task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })

                  local main_win = vim.api.nvim_get_current_win()
                  overseer.run_action(task, "open vsplit")
                  vim.api.nvim_set_current_win(main_win)
                else
                  vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
                end
              end)
            end, {})

            vim.api.nvim_create_user_command("Grep", function(params)
                -- Insert args at the '$*' in the grepprg
                local cmd, num_subs = vim.o.grepprg:gsub("%$%*", params.args)
                if num_subs == 0 then
                    cmd = cmd .. " " .. params.args
                end
                local task = overseer.new_task({
                    cmd = vim.fn.expandcmd(cmd),
                    components = {
                        {
                            "on_output_quickfix",
                            errorformat = vim.o.grepformat,
                            open = not params.bang,
                            open_height = 8,
                            items_only = true,
                        },
                        -- We don't care to keep this around as long as most tasks
                        { "on_output_quickfix", timeout = 30 },
                        "default",
                    },
                })
                task:start()
            end, { nargs = "*", bang = true, complete = "file" })
        end,
    },
}
