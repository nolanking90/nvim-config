require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "vim", "vimdoc", "query" , "latex", "python"},
  sync_install = false,
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
}
