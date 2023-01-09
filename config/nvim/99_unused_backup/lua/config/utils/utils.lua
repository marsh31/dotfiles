local map_key = vim.api.nvim_set_keymap

local function map(modes, key, action, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    if type(modes) == 'string' then modes = {modes} end
    for _, mode in ipairs(modes) do map_key(mode, key, action, opts) end
end

return {map = map}
