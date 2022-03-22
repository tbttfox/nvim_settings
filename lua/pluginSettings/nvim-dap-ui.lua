local ret = {}
function ret.loadPlugin()
    packUse({
        "rcarriga/nvim-dap-ui",
        requires = "mfussenegger/nvim-dap",
        config = function ()
            local dapui = require("dapui")
        end,
    })
end
return ret
