--
--
--
--
--
--
--
--
--
--
--
--

local log = require("nvim_lua_logger")
log.setup()

local keymap = vim.keymap.set
local keydel = vim.keymap.del
M = {}

------------------------------------------------------------
-- named keymap
------------------------------------------------------------
local function named_key_before_action(submode)
    return string.format("<Plug>(submode-ba:%s)", submode)
end

local function named_key_before_entering(submode)
    return string.format("<Plug>(submode-be:%s)", submode)
end

local function named_key_before_entering_with(submode, lhs)
    return string.format("<Plug>(submode-bew:%s:%s)", submode, lhs)
end

local function named_key_enter(submode)
    return string.format("<Plug>(submode-e:%s)", submode)
end

local function named_key_leave(submode)
    return string.format("<Plug>(submode-l:%s)", submode)
end

local function named_key_prefix(submode)
    return string.format("<Plug>(submode-p:%s)", submode)
end

local function named_key_rhs(submode, lhs)
    return string.format("<Plug>(submode-rhs:%s:%s)", submode, lhs)
end

------------------------------------------------------------
-- Utils
------------------------------------------------------------
local function slice(tbl, first, last, step)
    local sliced = {}

    local for_last = last or #tbl
    if for_last < 0 then
        for_last = #tbl + for_last + 1
    end

    for i = first or 1, for_last, step or 1 do
        sliced[#sliced + 1] = tbl[i]
    end

    return sliced
end

local function join(tbl)
    local str = ""
    for _, value in ipairs(tbl) do
        str = str .. value
    end

    return str
end

local function filter_options(user_opts, filter_opts)
    local ret = {}
    for key, filter_opt in pairs(filter_opts) do
        local user_opt = user_opts[key] or false
        ret[key] = (filter_opt or user_opt)
    end

    return ret
end

local function mapping_exists(keyseq, mode)
    return vim.fn.maparg(keyseq, mode) ~= ""
end

local function set_up_options()
    -- TODO:

    M.original_showmode = vim.opt.showmode._value
    M.original_timeout = vim.opt.timeout._value
    M.original_timeoutlen = vim.opt.timeoutlen._value
    M.original_ttimeout = vim.opt.ttimeout._value
    M.original_ttimeoutlen = vim.opt.ttimeoutlen._value
end

local function restore_options()
    vim.opt.showmode = M.original_showmode
    vim.opt.timeout = M.original_timeoutlen
    vim.opt.timeoutlen = M.original_showmode
    vim.opt.ttimeout = M.original_showmode
    vim.opt.ttimeoutlen = M.original_showmode
end

local function is_insert_mode(mode)
    return string.gmatch(mode, "^[iR]") ~= nil
end

local function may_override_showmode(mode)
    local res = string.gmatch(mode, "^[nvVsS(<C-v>|<C-s>)]")
    return res ~= nil or is_insert_mode(mode)
end

local function split_keys(keyseq)
    return vim.fn.split(keyseq, "(<[^<>]+>|.)\zs")
end

local function define_key(mode, lhs, rhs, user_opts, filter_opts, remap)
    local opts = filter_options(user_opts, filter_opts)
    opts["remap"] = remap

    log.write(
        string.format("mode: %s, lhs: %s, rhs: %s, options: %s", mode, lhs, rhs, vim.inspect(opts)),
        "define_keys"
    )
    keymap(mode, lhs, rhs, opts)
end

------------------------------------------------------------
-- Event
------------------------------------------------------------
local function on_entering_submode(submode)
    set_up_options()
end

local function on_executing_action(submode)
    if M.original_showmode and may_override_showmode(vim.fn.mode()) then
        -- TODO: echohl
        print("-- Submode: " .. submode .. " --")
    end
end

local function on_leaving_submode(submode)
    local cursor_position = vim.fn.getcurpos(".")
    local mode = vim.fn.mode()

    -- TODO:

    if (not M.submode_keep_leaving_key) and (vim.fn.getchar(1) ~= 0) then
        vim.fn.getchar()
    end

    restore_options()
end

------------------------------------------------------------
-- Define
------------------------------------------------------------
local function define_entering_mapping(submode, mode, options, lhs, rhs)
    log.write(
        string.format(
            "submode: %s, mode: %s, options: %s, lhs: %s, rhs: %s",
            submode,
            mode,
            vim.inspect(options),
            lhs,
            rhs
        ),
        "define_entering_mapping"
    )

    -- entering keymap
    log.write("entering keymap start", "define_entering_mapping")
    local entering_keymap_rhs = named_key_before_entering_with(submode, lhs)
        .. named_key_before_entering(submode)
        .. named_key_enter(submode)
    local entering_keymap_options = { buffer = false, unique = false }
    define_key(mode, lhs, entering_keymap_rhs, options, entering_keymap_options, true)

    -- leave with
    log.write("leave_with start", "define_entering_mapping")
    if not mapping_exists(named_key_enter(submode), mode) then
        log.write(
            string.format("submode_keyseqs_to_leave: %s", vim.inspect(M.submode_keyseqs_to_leave)),
            "define_entering_mapping"
        )
        for _, keyseq in ipairs(M.submode_keyseqs_to_leave) do
            M.leave_with(submode, mode, options, keyseq)
        end
    end

    -- 1.1 before entering with keymap
    local before_entering_with_keymap_lhs = named_key_before_entering_with(submode, lhs)
    local before_entering_with_keymap_options = { buffer = false, expr = false, silent = false, unique = false }
    define_key(mode, before_entering_with_keymap_lhs, rhs, options, before_entering_with_keymap_options, true)

    -- 1.2 before entering keymap
    local before_entering_keymap_lhs = named_key_before_entering(submode)
    local before_entering_keymap_rhs = string.format("<cmd>lua on_entering_submode('%s')<CR>", submode)
    local before_entering_keymap_options = { expr = false }
    define_key(
        mode,
        before_entering_keymap_lhs,
        before_entering_keymap_rhs,
        options,
        before_entering_keymap_options,
        false
    )

    -- 1.3 enter keymap
    local enter_keymap_rhs = named_key_before_action(submode) .. named_key_prefix(submode)
    define_key(mode, named_key_enter(submode), enter_keymap_rhs, options, {}, true)

    -- 1.3.1 before action
    local before_action_lhs = named_key_before_action(submode)
    local before_action_rhs = string.format("<cmd>lua on_executing_action('%s')<CR>", submode)
    local before_action_keymap_options = { expr = false }
    define_key(mode, before_action_lhs, before_action_rhs, options, before_action_keymap_options, false)

    -- 1.3.2 prefix
    define_key(mode, named_key_prefix(submode), named_key_leave(submode), options, {}, true)

    -- 1.3.2.1 leave
    local expression_key = "@="
    if mode == "i" or mode == "c" then
        expression_key = "<C-r>="
    end
    local leaving_keymap_rhs = string.format("%s<cmd>lua on_leaving_submode('%s')<CR>", expression_key, submode)
    define_key(mode, named_key_leave(submode), leaving_keymap_rhs, options, {}, false)
end

local function define_submode_mapping(submode, mode, options, lhs, rhs)
    local leave_or_enter = named_key_enter(submode)
    if options["x"] ~= nil then
        leave_or_enter = named_key_leave(submode)
    end
    log.write(string.format("leave or enter is %s", leave_or_enter), "define_submode_mapping")

    -- 1. submode keymap
    local submode_mapping_keymap_lhs = named_key_prefix(submode) .. lhs
    local submode_mapping_keymap_rhs = named_key_rhs(submode, lhs) .. leave_or_enter
    local submode_mapping_keymap_options = { buffer = false, unique = false }
    define_key(mode, submode_mapping_keymap_lhs, submode_mapping_keymap_rhs, options, submode_mapping_keymap_options, true)

    -- 1.1 rhs
    local rhs_keymap_lhs = named_key_rhs(submode, lhs)
    local rhs_keymap_rhs = rhs
    local rhs_keymap_options = { buffer = false, expr = false, silent = false, unique = false }
    define_key(mode, rhs_keymap_lhs, rhs_keymap_rhs, options, rhs_keymap_options, false)


    local keys = split_keys(lhs)
    for i = 1, (#keys - 1), 1 do
        local first_n_keys = join(slice(keys, 1, -(i + 1), 1))
        local first_n_keys_keymap_lhs = named_key_prefix(submode) .. first_n_keys
        local first_n_keys_keymap_rhs = named_key_leave(submode)
        local first_n_keys_keymap_options = { buffer = false, unique = false }
        define_key(mode, first_n_keys_keymap_lhs, first_n_keys_keymap_rhs, options, first_n_keys_keymap_options, true)
    end
end

local function undefine_submode_mapping(submode, mode, options, lhs)
    keydel(named_key_rhs(submode, lhs))
    local keys = split_keys(lhs)

    for index, value in ipairs(keys) do
        local first_n_keys = ""

        -- TODO: ???
        local first_n_keys_keymap_lhs = named_key_rhs(submode, lhs)
        local first_n_keys_keymap_rhs = rhs
        local first_n_keys_keymap_options = { buffer = false, unique = false }
        rhs_keymap_options = filter_options(options, rhs_keymap_options)
        rhs_keymap_options["remap"] = true
        keymap(first_n_keys_keymap_lhs, first_n_keys_keymap_rhs, first_n_keys_keymap_options)
    end
end

------------------------------------------------------------
-- Interface
------------------------------------------------------------
M.setup = function()
    -- TODO: setup object
    -- for
    log.write("setup", "setup")

    M.submode_keep_leaving_key = 0
    M.submode_keyseqs_to_leave = { "<Esc>" }
    M.submode_timeout = vim.opt.timeout._value
    M.submode_timeoutlen = vim.opt.timeoutlen._value
end

-- lua require("dev.nvim-submode").enter_with("test", "niv", { buffer = true, silent = true }, "<c-w>+", "<c-w>+")
M.enter_with = function(submode, modes, options, lhs, ...)
    log.write(
        "lua require('dev.nvim-submode').enter_with('test', 'niv', { buffer = true, silent = true }, '<c-w>+', '<c-w>+')",
        "enter_with"
    )
    log.write("start", "enter_with")
    log.write(
        string.format("submode: %s, modes: %s, options: %s, lhs: %s", submode, modes, vim.inspect(options), lhs),
        "enter_with"
    )

    local rhs = "<Nop>"
    if 0 < select("#", ...) then
        rhs = select(1, ...)
    end

    modes:gsub(".", function(mode)
        define_entering_mapping(submode, mode, options, lhs, rhs)
    end)
end

M.leave_with = function(submode, modes, options, lhs)
    log.write("start", "leave_with")
    log.write(
        string.format("submode: %s, modes: %s, options: %s, lhs: %s", submode, modes, vim.inspect(options), lhs),
        "leave_with"
    )

    M.map(submode, modes, options, lhs, "<Nop>")
end

M.map = function(submode, modes, options, lhs, rhs)
    log.write("start", "map")
    log.write(
        string.format(
            "submode: %s, modes: %s, options: %s, lhs: %s, rhs: %s",
            submode,
            modes,
            vim.inspect(options),
            lhs,
            rhs
        ),
        "leave_with"
    )

    modes:gsub(".", function(mode)
        define_submode_mapping(submode, mode, options, lhs, rhs)
    end)
end

M.unmap = function(submode, modes, options, lhs)
    modes:gsub(".", function(mode)
        undefine_submode_mapping(submode, mode, options, lhs)
    end)
end

return M
-- vim: sw=4 sts=4 expandtab fenc=utf-8
