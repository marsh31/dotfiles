local utils = require("utils.abbreviation")

describe("utils.trim", function()
    it ("utils return items", function()
        local str = utils.get_cmdline_abbr("tig", "Tig")
        local expected = 'cabbrev <expr> %s (getcmdtype() ==# ":" && getcmdline() ==# "tig") ? "tig" : "Tig"'

        assert.equals(expected, str)
    end)
end)

