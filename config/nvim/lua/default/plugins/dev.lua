local devpath = "~/src/vimscript/vim-todotxt/"
local todotxt = {}
if vim.fn.isdirectory(vim.fn.expand(devpath)) ~= 0 then
    todotxt = { dir = "~/src/vimscript/vim-todotxt/" }
else
    todotxt = { "marsh31/vim-todotxt" }
end

local colorselector_devpath = "~/src/vimscript/vim-colorselector/"
local colorselector = {}
if vim.fn.isdirectory(vim.fn.expand(colorselector_devpath)) ~= 0 then
    colorselector = { dir = "~/src/vimscript/vim-colorselector/" }
else
    colorselector = { "marsh31/vim-colorselector" }
end

local function path2abpath(data)
    local file = ""
    if data[0] ~= "/" then
        local cparent = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        file = vim.fs.normalize(vim.fs.joinpath(cparent, data))
    else
        file = data
    end

    return file
end

local function pick_one(items, prompt, format_item_fn)
    local choices = { prompt }

    if #items == 1 then
        return items[1]
    end

    for i, item in ipairs(items) do
        table.insert(choices, string.format("%d: %s", i, format_item_fn(item)))
    end

    local choice = vim.fn.inputlist(choices)
    if choice < 1 or choice > #items then
        return nil
    end

    return items[choice]
end

return {
    -- {
    --     "folke/neodev.nvim",
    --     opts = {},
    --     ft = { "lua" },
    -- },

    {
        "notomo/lreload.nvim",
        ft = { "lua" },
        config = function()
            require("lreload").enable("dev/qfapp")
        end,
    },
    { "marsh31/nvim-lua-logger" },
    todotxt,
    colorselector,

    {
        dir = "~/src/vimscript/lua-submode",
        config = function()
            require("lreload").enable("submode")
        end,
    },

    {
        dir = "~/src/vimscript/lua-gf",
        -- cond = false,
        config = function()
            require("lreload").enable("gf")
            require("gf").setup({
                event = {
                    ["gf"] = "",
                    ["gF"] = "",

                    ["<C-w>f"] = "split",
                    ["<C-w><C-f>"] = "vsplit",
                    ["<C-w>F"] = "tab split",

                    ["<C-w>gf"] = "tab split",
                    ["<C-w>gF"] = "tab split",
                },
                table = {
                    function()
                        local cline = vim.fn.getline(".")

                        --- { name = string, link = string, }
                        local input_data = {}

                        -- 1. <>
                        local _ = string.gsub(cline, "<(.*)>", function(h)
                            table.insert(input_data, { name = h, link = h })
                        end)

                        -- 2. []()
                        local _ = string.gsub(cline, "%[.*%]%((.*)%)", function(h)
                            table.insert(input_data, { name = h, link = path2abpath(h) })
                        end)

                        -- 3. [][]
                        local _ = string.gsub(cline, "%[.*%]%[(.*)%]", function(label)
                            -- table.insert(input_data, h)
                            local buffer = table.concat(vim.fn.getline(0, "$"), " ")
                            local link = ""
                            local _ = string.gsub(buffer, "%[" .. label .. "]:%s+(%S*)", function(h)
                                link = h
                            end)

                            if link ~= "" then
                                table.insert(input_data, { name = link, link = path2abpath(link) })
                            end
                        end)

                        if #input_data == 0 then
                            return nil
                        end

                        local output_data = {}
                        for _, data in ipairs(input_data) do
                            if vim.fn.filereadable(data.link) ~= 0 then
                                table.insert(output_data, data)
                            end
                        end

                        if #output_data == 0 then
                            return nil
                        end

                        local one = pick_one(output_data, "select one", function(item)
                            return item.name
                        end)
                        if one == nil then
                            return nil
                        else
                            return {
                                path = one.link,
                                line = 0,
                                col = 0,
                            }
                        end
                    end,
                },
            })
        end,
    },
    -- [label]: ./../../../test.mdx
    -- <https://google.com>  [this is test](./../../../init.lua)   [test][label]
    --  {
    --    dir = "~/src/project/nvim-qf-helper",
    --    config = function()
    --      require("nvim_qf_helper").setup()
    --      require("lreload").enable("nvim_qf_helper")
    --      require("lreload").enable("dev")
    --      require("lreload").enable("dev/rg")
    --      require("lreload").enable("dev/nvim-submode")
    --      require("lreload").enable("dev/sample")
    --    end,
    --  },
    --  {
    --    dir = "~/src/project/nvim-lua-logger",
    --    config = function()
    --      require("lreload").enable("nvim_lua_logger")
    --      require("nvim_lua_logger").setup()
    --    end,
    --  },
}

-- vim: sw=4 sts=4 expandtab fenc=utf-8
