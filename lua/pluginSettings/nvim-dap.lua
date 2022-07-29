local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "mfussenegger/nvim-dap",
        config = function ()
            require('dap').setup({

            })
        end,
    })
end
return ret
