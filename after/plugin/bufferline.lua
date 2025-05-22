vim.opt.termguicolors = true
local bufferline = require('bufferline')
bufferline.setup {
    options = {
        mode = "buffers",
        style_preset = bufferline.style_preset.default,
        separator_style = "slant", --| "slope" | "thick" | "thin" | { 'any', 'any' },
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        diagnostics = "nvim_lsp",
    }
}
