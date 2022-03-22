local ret = {}
function ret.loadPlugin()
    packUse({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
end
return ret
