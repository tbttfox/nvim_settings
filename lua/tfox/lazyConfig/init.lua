-- Any plugins that just require loading with minimal setup (no more than a couple lines) go in here
return {
    {
        "tbttfox/vim-muzzl",
        config = function() vim.cmd.colorscheme("muzzl") end,
    },
    "nvim-treesitter/playground",
    {
        "nvim-treesitter/nvim-treesitter",
        build=":TSUpdate",
    },
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-sleuth",
    "numToStr/Comment.nvim",
    "folke/which-key.nvim",
    "michaeljsmith/vim-indent-object",
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("indent_blankline").setup({
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },
    "windwp/nvim-autopairs",
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons"},
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies="nvim-lua/plenary.nvim",
        branch = '0.1.x',
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            --{'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    },
}
