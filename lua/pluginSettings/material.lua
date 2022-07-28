local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "marko-cerovac/material.nvim",
        config = function ()

            require('material').setup({
                lualine_style = 'stealth',
            })
            require('material.functions').change_style("darker")

        end,
    })
end
return ret
