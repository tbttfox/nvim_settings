local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "theHamsta/nvim-dap-virtual-text",
        requires = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
        config = function ()
            local dvt = require('nvim-dap-virtual-text')
        end,
    })
end
return ret
