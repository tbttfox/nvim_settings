local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "nvim-telescope/telescope-dap.nvim",
        after = {"telescope.nvim", },
        config = function()
            require("telescope").load_extension("dap")
        end,
    })
end
return ret
