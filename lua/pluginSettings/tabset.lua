local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "FotiadisM/tabset.nvim",
        config = function ()
            require('tabset').setup({})
        end,
    })
end
return ret
