require('lualine').setup {
  options = {
    icons_enabled = true,
    --theme = 'auto',
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
        'branch',
        'diff',
        {
            'diagnostics',
            sources = {
                'nvim_diagnostic',
                --'nvim_lsp',
            },
            sections = { 'error', 'warn', 'info', 'hint'},
            diagnostics_color = {
                -- Same values as the general color option can be used here.
                error = 'DiagnosticError', -- Changes diagnostics' error color.
                warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
                info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
                hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            },
            symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
            colored = true,
            always_visible = false,
        }
    },
    lualine_c = {{'filename',file_status=true,path=4},'lsp_progress',},
    lualine_x = {'searchcount', {'filetype',colored=true}},
    lualine_y = {'progress'},
    lualine_z = {'selectioncount','location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
