-- lua/utils/abbreviation.lua
-- require("utils.abbreviation").get_cmdline_abbr("tig", "Tig")
local M = {}

-- function! s:cmdlineAbbreviation(input, replace) abort
--   exec printf("cabbrev <expr> %s (getcmdtype() ==# \":\" && getcmdline() ==# \"%s\") ? \"%s\" : \"%s\"",
--     \ a:input, a:input, a:replace, a:input)
-- endfunction
function M.get_cmdline_abbr(base, repl)
  return string.format(
    'cabbrev <expr> %s (getcmdtype() ==# ":" && getcmdline() ==# "%s") ? "%s" : "%s"',
    base,
    base,
    repl
  )
end


return M
