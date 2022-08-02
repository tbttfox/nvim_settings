local ret = {}

vim.keymap.set("n", "<F2>", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<F3>", ":lua require('dap').step_out()<CR>")
vim.keymap.set("n", "<F4>", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<F5>", ":lua require('dap').continue()<CR>")

vim.keymap.set("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message:'))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require('dap').repl.open()<CR>")
function ret.loadPlugin(packUse)
    packUse({
        "mfussenegger/nvim-dap",
    })
end
return ret
