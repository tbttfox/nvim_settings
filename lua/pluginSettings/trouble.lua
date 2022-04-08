local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function ()
            require('trouble').setup({})
        end,
    })
end
return ret
