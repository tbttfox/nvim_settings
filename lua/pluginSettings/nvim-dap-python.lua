local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "mfussenegger/nvim-dap-python",
        requires = "mfussenegger/nvim-dap",
    })
end
return ret
