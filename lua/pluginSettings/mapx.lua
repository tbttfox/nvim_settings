local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "b0o/mapx.nvim",
        config = function ()
            require('mapx').setup({
                global = true
            })
        end,
    })
end
return ret
