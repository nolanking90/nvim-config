vim.opt.syntax = enable

vim.g.vimtex_compiler_latexmk_engines = { pdflatex ="pdflatex-dev"}
vim.g.vimtex_compiler_latexmk = {
    options = {
    '-pdf',
    '-shell-escape',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
    },
}

vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_view_skim_sync = 1
vim.g.vimtex_view_automatic = 1

vim.g.vimtex_syntax_conceal_disable = 1

vim.g.vimtex_complete_recursive_bib = 1
vim.g.vimtex_compelete_enable = 1
vim.g.vimtex_compelete_close_brace = 1

--vim.g.vimtex_quickfix_mode=2
-- 0 never opens quickfix
vim.g.vimtex_quickfix_mode=0

vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_fold_manual = 1

vim.g.vimtex_toc_config = {
       name = "toc",
       layers = {"content", "todo", "include"},
       resize = 1,
       split_width = 50,
       todo_sorted = 0,
       show_help = 1,
       show_numbers = 1,
       mode = 2
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function(args)
        vim.cmd("VimtexCompile")
        --vim.cmd("VimtexTocOpen")
    end
})

