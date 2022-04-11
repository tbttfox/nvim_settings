local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "nvim-telescope/telescope-packer.nvim",
        after = {"telescope.nvim", },
        config = function()
            require("telescope").load_extension("packer")
        end,
    })
end
return ret
