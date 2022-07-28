local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "williamboman/mason.nvim",
        config = function ()
            require("mason").setup()
        end
    })
end
return ret
