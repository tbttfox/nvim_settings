local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = function ()
            require('nvim-autopairs').setup({})
        end,
    })
end
return ret
