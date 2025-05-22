vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Colorschemes
    use { 'rose-pine/neovim', as = 'rose-pine' }
    use 'folke/tokyonight.nvim'

    -- File Navigation
    use "nvim-lua/plenary.nvim"
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
    }
    use {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
    }

    ---- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    ---- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'onsails/lspkind.nvim'
    use 'folke/neodev.nvim'
    use 'ray-x/lsp_signature.nvim'

    ---- Code Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    --use 'hrsh7th/cmp-omni'
    --use 'hrsh7th/cmp-buffer'

    ---- LaTeX
    --use 'lervag/vimtex'
    --use 'micangl/cmp-vimtex'
    --use 'barreiroleo/ltex-extra.nvim'
    --use 'L3MON4D3/LuaSnip'
    --use 'saadparwaiz1/cmp_luasnip'
    --use 'evesdropper/luasnip-latex-snippets.nvim'
    --use 'rafamadriz/friendly-snippets'


    ---- Code folding
    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async'
    }

    ---- UI Stuff
    use 'nvim-tree/nvim-web-devicons'
    use 'petertriho/nvim-scrollbar'
    use 'akinsho/bufferline.nvim'
    use "lukas-reineke/indent-blankline.nvim"

    ---- Statusline
    use 'nvim-lualine/lualine.nvim'
    use 'arkav/lualine-lsp-progress'

    ---- Keybindings
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup()
        end
    }
    use "tpope/vim-surround"
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    use 'chentoast/marks.nvim'

    ---- Other
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'scrooloose/nerdcommenter'
    use 'mrcjkb/rustaceanvim'
end)
