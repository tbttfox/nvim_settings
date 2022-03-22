local ret = {}
function ret.loadPlugin()
    packUse({
        "nvim-telescope/telescope.nvim",
        requires = 'nvim-lua/plenary.nvim',
        module = "telescope",
        after = {
            "telescope-packer.nvim",
        },
        config = function ()
            require('telescope').setup({})
        end,
    })
end
return ret
