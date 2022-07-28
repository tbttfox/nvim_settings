local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "rcarriga/nvim-dap-ui",
        requires = "mfussenegger/nvim-dap",
        config = function ()
            require("dapui").setup({
            })
        end,
    })
end
return ret
