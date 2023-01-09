-- 
--

local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")

-- LuaSnip config
ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})

ls.snippets = {
    -- all         = require('plugrc.luasnippets.all'),
    all = {
        s({trig = "fullpath"}, {
            f(function(args, snip, user_arg_1)
                local fullpath = vim.api.nvim_buf_get_name('$')
                return fullpath
            end,
            {1},
            {}),
            i(1),
        }),
    },
    -- c           = require('plugrc.luasnip.c'),
    -- html        = require('plugrc.luasnip.html'),
    -- http        = require('plugrc.luasnip.http'),
    -- javascript  = require('plugrc.luasnip.javascript'),
    lua         = require('plugrc.luasnippets.lua'),
    -- python      = require('plugrc.luasnip.python3'),
    -- rust        = require('plugrc.luasnip.rust'),
    -- sh          = require('plugrc.luasnip.sh'),
    -- vim         = require('plugrc.luasnip.vim'),
}

ls.add_snippets("all", {
  s({trig = "fullpath"}, {
    f(function(args, snip, user_arg_1)
      local fullpath = "test"
      local fullpath = vim.api.nvim_buf_get_name('$')
      return fullpath
    end,
    {1},
    {}),
    i(1),
  }),
})


-- nvim-cmp
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local lspkind = require'lspkind'
local cmp = require'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      -- vim.fn['vsnip#anonymous'](args.body)
      require('luasnip').lsp_expand(args.body)
    end
  },
  window = {
    completion = {
      -- border = 'single',
    },
    documentation = {
      -- border = 'single',
    },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu', },
    format = require("lspkind").cmp_format({
      with_text = false,
    })
  },
  mapping = {
    ["<Tab>"] = cmp.mapping({
      i = function(fallback)
        -- if vim.fn["vsnip#available"](1) == 1 then
        --   feedkey("<Plug>(vsnip-expand-or-jump)", "")
        --
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()

        elseif cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })

        else
          fallback()
        end
      end,

      s = function(fallback)
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()

        else
          fallback()
        end
      end,

      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
    }),

    ["<S-Tab>"] = cmp.mapping({
      i = function(fallback)
        if vim.fn["vsnip#available"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        else
          fallback()
        end
      end,

      s = function(fallback)
        if vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")

        else
          fallback()
        end
      end,

      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    }),

    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {"i", "s"}),

    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {"i", "s"}),

    ['<C-k>'] = cmp.mapping(cmp.mapping.complete({
      config = {
        sources = {
          { name = 'luasnip' },
          { name = 'buffer' },
        }
      }
    }), { 'i' }),

    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    ['<CR>'] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'path' },
    { name = 'luasnip' },
  }, {
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
}
cmp.setup.filetype('gitcommit', {
  sources = require('cmp').config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})
require('cmp_git').setup({})
cmp.setup.cmdline('/', {
  sources = {
    { name = 'nvim_lsp_document_symbol' },
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})



