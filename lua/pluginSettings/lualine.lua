local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt=true },
        after = {"arctic.nvim"},
        config = function ()
            require('lualine').setup({
                options = {
                    theme = require('arctic.lualine_theme'),
                },
            })
        end,
    })
end
return ret
