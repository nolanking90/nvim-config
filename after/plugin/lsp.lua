require("neodev").setup()
require("mason").setup()
local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.set_log_level("OFF")

--- LUA ---
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file("", true)
                        --library = {
                        --vim.env.VIMRUNTIME,
                        --[vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        --[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        --}
                    },
                    hint = { enable = true },
                    hover = { enable = true },
                }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end,
}

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = {
        border = "rounded",
        format = function(diagnostic)
            return string.format(
                "%s (%s)",
                diagnostic.message,
                diagnostic.source
            )
        end,
        max_width = 60,
    },

})
