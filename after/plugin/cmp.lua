local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local luasnip = require("luasnip")
local lspkind = require('lspkind')
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("rust", { "rustdoc" })

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    sources = cmp.config.sources({
        {name = 'luasnip'},
        {name = 'nvim_lsp'},
        --{name = 'vimtex'},
        --{name = 'omni'},
    },{
        --{ name = 'buffer'},
    }),

    window = {
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },

    experimental = {
        ghost_text = false,
        native_menu = false,
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
            menu = ({
                --buffer = "[Buffer]",
                luasnip = "[LuaSnip]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
                vimtex = "[Vimtex]",
            })
        }),
    },

    view = {
      entries = {
        name = 'custom',
        selection_order = 'top_down',
        vertical_positioning = 'below',
      },
      docs = {
        auto_open = false,
      },
    },

})

lspkind.init({
    symbol_map = { Snippet = "i"}
})

-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
      { name = 'path' }
  }, {
      { name = 'cmdline' }
  })
})
