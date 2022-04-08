local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "folke/which-key.nvim",
        config = function ()
            require('which-key').setup({})
        end,
    })
end
return ret
