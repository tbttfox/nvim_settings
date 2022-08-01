local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "mfussenegger/nvim-dap-python",
        requires = "mfussenegger/nvim-dap",
        config = function ()
            local sep = "\\"
            local masonRoot = table.concat({ vim.fn.stdpath("data"), "mason" }, sep)
            local winPyExe = table.concat({"packages", "debugpy", "venv", "Scripts", "python.exe"}, sep)
            local dapExe = table.concat({masonRoot, winPyExe}, sep)
            require('dap-python').setup(dapExe)
        end,
    })
end
return ret
