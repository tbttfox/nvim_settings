local ret = {}
function ret.loadPlugin()
    packUse({
        "FotiadisM/tabset.nvim",
        config = function ()
            require('tabset').setup({})
        end,
    })
end
return ret
