local packer = require('packer')
local use = packer.use
return packer.startup({
    function()
        use("wbthomason/packer.nvim")  -- packer controls itself

        -- Language Server Protocol (LSP) setup
        -- require("pluginSettings.nvim-lsp-installer").loadPlugin(use)

        --  MASON handles DAP and LSP installs
        require("pluginSettings.mason").loadPlugin(use)
        require("pluginSettings.mason-lspconfig").loadPlugin(use)

        -- LSP extensions
        require("pluginSettings.lsp-config").loadPlugin(use)
        require("pluginSettings.nvim-lightbulb").loadPlugin(use)
        require("pluginSettings.lsp_signature").loadPlugin(use)
        require("pluginSettings.lspkind-nvim").loadPlugin(use)
        require("pluginSettings.trouble").loadPlugin(use)

        -- Debug Adapter Protocol (DAP) extensions
        -- require("pluginSettings.nvim-dap-python").loadPlugin(use)
        require("pluginSettings.nvim-dap-ui").loadPlugin(use)
        require("pluginSettings.nvim-dap").loadPlugin(use)
        require("pluginSettings.nvim-dap-python").loadPlugin(use)
        require("pluginSettings.nvim-dap-virtual-text").loadPlugin(use)

        -- Treesitter Stuff
        require("pluginSettings.nvim-treesitter").loadPlugin(use)
        require("pluginSettings.nvim-treesitter-context").loadPlugin(use)
        require("pluginSettings.nvim-ts-context-commentstring").loadPlugin(use)
        require("pluginSettings.refactoring").loadPlugin(use)

        -- Python stuff
        require("pluginSettings.black").loadPlugin(use)

        -- Telescope Stuff
        require("pluginSettings.telescope").loadPlugin(use)
        require("pluginSettings.telescope-packer").loadPlugin(use)
        require("pluginSettings.telescope-dap").loadPlugin(use)

        -- Generic Stuff
        require("pluginSettings.lualine").loadPlugin(use)
        require("pluginSettings.vim-surround").loadPlugin(use)
        require("pluginSettings.vim-repeat").loadPlugin(use)
        require("pluginSettings.chadtree").loadPlugin(use)
        require("pluginSettings.nvim-cmp").loadPlugin(use)
        require("pluginSettings.comment").loadPlugin(use)
        require("pluginSettings.indent-blankline").loadPlugin(use)
        require("pluginSettings.nvim-autopairs").loadPlugin(use)
        require("pluginSettings.symbols-outline").loadPlugin(use)
        require("pluginSettings.nvim-lint").loadPlugin(use)
        require("pluginSettings.which-key").loadPlugin(use)
        require("pluginSettings.mapx").loadPlugin(use)
        require("pluginSettings.vim-indent-object").loadPlugin(use)
        require("pluginSettings.abolish").loadPlugin(use)
        require("pluginSettings.wordmotion").loadPlugin(use)
        require("pluginSettings.rooter").loadPlugin(use)
        require("pluginSettings.vim-sleuth").loadPlugin(use)
        require("pluginSettings.bufdelete").loadPlugin(use)
        require("pluginSettings.nvim-winraise").loadPlugin(use)

        -- Colorschemes
        -- require("pluginSettings.material").loadPlugin(use)
        require("pluginSettings.lush").loadPlugin(use)
        require("pluginSettings.arctic").loadPlugin(use)

    end
})

