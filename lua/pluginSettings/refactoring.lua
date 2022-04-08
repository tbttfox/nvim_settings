local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        },
        config = function ()
            require('refactoring').setup({})
        end,
    })
end
return ret
