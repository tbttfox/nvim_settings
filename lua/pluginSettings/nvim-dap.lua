local ret = {}
function ret.loadPlugin()
    packUse({
        "mfussenegger/nvim-dap",
        config = function ()
            local dap = require('dap')
        end,
    })
end
return ret
