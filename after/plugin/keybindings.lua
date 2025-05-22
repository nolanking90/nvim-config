-----------------------------------------------
--- Native Vim Keybindings
-----------------------------------------------

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>h", ":noh<CR>")

-- Swap lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Jump by a half screen
vim.keymap.set("n", "<C-j>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "<C-u>zz")

-- paste from system buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- yank (copy) to system buffer
vim.keymap.set("n", "<leader>y", "\"*y")
vim.keymap.set("v", "<leader>y", "\"*y")
vim.keymap.set("n", "<leader>Y", "\"*Y")

--wk.register({ ["<leader>pv"] = { "View directory" } })
--wk.register({ ["<leader>h"] = { "Clear search highlights" } })

--wk.register({ ["J"] = { "Move selection down" } }, { mode = "v"})
--wk.register({ ["K"] = { "Move selection up" } }, { mode = "v"})

--wk.register({ ["<C-j>"] = { "Move half page down" } })
--wk.register({ ["<C-k>"] = { "Move half page up" } })

--wk.register({ ["<leader>p"] = { "Paste, preserve buffer" } }, { mode = "x"})

--wk.register({ ["<leader>y"] = { "Yank to clipboard" } })
--wk.register({ ["<leader>y"] = { "Yank to clipboard" } }, { mode = "v"})
--wk.register({ ["<leader>Y"] = { "Yank to clipboard" } })

-----------------------------------------------
--- Harpoon Keybindings
-----------------------------------------------

local hp = require("harpoon")

vim.keymap.set("n", "<leader>a", function() hp:list():add() end)
vim.keymap.set("n", "<C-e>", function() hp.ui:toggle_quick_menu(hp:list()) end)

vim.keymap.set("n", "<leader>1", function() hp:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() hp:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() hp:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() hp:list():select(4) end)

--wk.register({
--    ["<leader>a"] = { "Mark file (Harpoon)" },
--    ["<C-e>"] = { "Toggle Quick Menu (Harpoon)" },
--    ["<leader>1"] = { "Goto file 1 (Harpoon)" },
--    ["<leader>2"] = { "Goto file 2 (Harpoon)" },
--    ["<leader>3"] = { "Goto file 3 (Harpoon)" },
--    ["<leader>4"] = { "Goto file 4 (Harpoon)" },
--})

-----------------------------------------------
--- LSP Keybindings
-----------------------------------------------

local function move_float(winnr)
    if winnr == nil then
        do return end
    end

    local config = vim.api.nvim_win_get_config(winnr)
    config = vim.tbl_extend('force', config, {
        relative = 'win',
        win = vim.api.nvim_get_current_win(),
        anchor = "NE",
        bufpos = {0,0},
        row = 0,
        col = vim.api.nvim_win_get_width(0) - 9,
    })
    vim.api.nvim_win_set_config(winnr, config)
end

local function goto_pos(pos, opts)
    opts = opts or {}

    local float = vim.F.if_nil(opts.float, true)
    local win_id = opts.win_id or vim.api.nvim_get_current_win()

    if not pos then
        vim.api.nvim_echo({ { 'No more valid diagnostics to move to', 'WarningMsg' } }, true, {})
        return
    end

    vim.api.nvim_win_call(win_id, function()
        -- Save position in the window's jumplist
        vim.cmd("normal! m'")
        vim.api.nvim_win_set_cursor(win_id, { pos[1] + 1, pos[2] })
        -- Open folds under the cursor
        vim.cmd('normal! zv')
    end)

    if float then
        local float_opts = type(float) == 'table' and float or {}
        vim.schedule(function()
            local _, winnr = vim.diagnostic.open_float(vim.tbl_extend('keep', float_opts, {
                bufnr = vim.api.nvim_win_get_buf(win_id),
                scope = 'cursor',
                focus = false,
            }))
            move_float(winnr)
        end)
    end
end

local function next_diag(opts)
   goto_pos(vim.diagnostic.get_next_pos(), opts)
end

local function prev_diag(opts)
   goto_pos(vim.diagnostic.get_prev_pos(), opts)
end

local function view_diag(opts)
    local _, winnr = vim.diagnostic.open_float(opts)
    move_float(winnr)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.hover() end, opts)
    --vim.keymap.set({"n", "v"}, "<leader>vf", function() vim.lsp.buf.format({timeout_ms = 60000}) end, opts) -- For troubleshooting texlab formatter.
    vim.keymap.set({"n", "v"}, "<leader>vf", function() vim.lsp.buf.format() end)
    vim.keymap.set("n", "<leader>vk", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>d", function() view_diag() end, opts)
    vim.keymap.set("n", "[d", function() next_diag() end, opts)
    vim.keymap.set("n", "]d", function() prev_diag() end, opts)
    vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("v", "<leader>a", function() vim.lsp.buf.code_action(opts) end, opts)
    vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.hover() end, opts)

--    wk.register({ ["<leader>r"] = { "Rename (LSP)" } })
--    wk.register({ ["<leader>v"] = { name = "+View info (LSP)" } })
--    wk.register({ ["<leader>vD"] = { "Goto defintion (LSP)" } })
--    wk.register({ ["<leader>vd"] = { "View diagnostic in float (LSP)" } })
--    wk.register({ ["<leader>va"] = { "View code actions (LSP)" } })
--    wk.register({ ["<leader>vr"] = { "View references (LSP)" } })
--    wk.register({ ["<leader>vh"] = { "View documentation (LSP)" } })
--    wk.register({ ["<leader>vf"] = { "Fromat Buffer (LSP)" } })
--    wk.register({ ["<leader>vk"] = { "View lsp_sig help (LSP)" } })
--    wk.register({ ["<C-h>"] = { "View documentation (LSP)" } }, { mode = 'i'})
--    wk.register({ ["[d"] = { "Goto next diagnositc (LSP)" } })
--    wk.register({ ["]d"] = { "Goto prev diagnositc (LSP)" } })

   end,
})


-----------------------------------------------
--- cmp Keybindings
-----------------------------------------------

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-e>'] = cmp.mapping.abort(),
	['<C-Space>'] = cmp.mapping.complete(),
    },
})

-----------------------------------------------
--- Telescope Keybindings
-----------------------------------------------

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
--vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end);

-----------------------------------------------
--- UFO Keybindings
-----------------------------------------------

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-----------------------------------------------
--- undoTree Keybindings
-----------------------------------------------

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

---- Function to find crate name by locating Cargo.toml
--local function find_crate_name(path)
    --while path and path ~= "/" do
        --local cargo_toml = path .. "/Cargo.toml"
        --if vim.fn.filereadable(cargo_toml) == 1 then
            --local cargo = vim.fn.readfile(cargo_toml)
            --for _, line in ipairs(cargo) do
                --local name = line:match('^name%s*=%s*"(.-)"')
                --if name then return name end
            --end
            --return vim.fn.fnamemodify(path, ':t') -- Fallback to directory name
        --end
        --path = vim.fn.fnamemodify(path, ':h') -- Move up one directory
    --end
    --return nil
--end

---- Function to extract function name using lspsaga
--local function get_function_name()
    --local bar = require('lspsaga.symbol.winbar').get_bar()
    --if not bar then
        --vim.notify("Winbar not available.", vim.log.levels.ERROR)
        --return nil
    --end
    ---- Extract the trailing function name after the last '›'
    --local func = bar:match("%s*([%w_]+)$")
    --if not func then
        --vim.notify("Function name not found in winbar.", vim.log.levels.ERROR)
    --end
    --return func
--end

---- Function to run the current Rust test asynchronously
--local function run_current_rust_test()
    --local filepath = vim.fn.expand('%:p')
    --local crate_dir = vim.fn.fnamemodify(filepath, ':h')
    --local crate_name = find_crate_name(crate_dir)

    --if not crate_name then
        --vim.notify("Crate name not found.", vim.log.levels.ERROR)
        --return
    --end

    --local func_name = get_function_name()
    --if not func_name then return end

    --local relative_path = filepath:match(".+/src/(.+)%.rs$")
    --if not relative_path then
        --vim.notify("File not in src directory.", vim.log.levels.ERROR)
        --return
    --end
    --local module_path = relative_path:gsub('/', '::')

    --local test_target = module_path .. '::' .. func_name
    --local cmd = string.format(
        --'env UPDATE_EXPECT=1 cargo test --package %s --lib -- %s --exact --show-output',
        --crate_name,
        --test_target
    --)
    --vim.cmd('silent ! ' .. cmd)
--end

---- Keybinding: <leader>rt to run the current Rust test
--vim.keymap.set('n', '<leader>ve', run_current_rust_test, { noremap = true, silent = true })
