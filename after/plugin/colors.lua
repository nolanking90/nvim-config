function ColorMyPencils(color)
    color = color or "rose-pine"
	vim.cmd.colorscheme(color)
    vim.cmd([[highlight Comment guifg=White]])
    vim.cmd([[highlight WhiteSpace guifg=White]])
    vim.cmd([[highlight LineNr guifg=#F5F5F5]])

    --vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None" })
end

ColorMyPencils("tokyonight-night")
