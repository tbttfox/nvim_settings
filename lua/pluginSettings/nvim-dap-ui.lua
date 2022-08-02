local ret = {}

vim.keymap.set("n", "<leader>du", ":lua require('dapUi').toggle()<CR>")

function ret.loadPlugin(packUse)
    packUse({
        "rcarriga/nvim-dap-ui",
        requires = "mfussenegger/nvim-dap",
        config = function ()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup({})
            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.after.event_terminated["dapui_config"] = dapui.close
            dap.listeners.after.event_exited["dapui_config"] = dapui.close
        end,
    })
end
return ret
