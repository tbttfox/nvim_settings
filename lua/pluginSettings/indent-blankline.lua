local ret = {}
function ret.loadPlugin()
    packUse({
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("indent_blankline").setup({
                show_current_context = true,
                show_current_context_start = false,
            })
        end,
    })
end
return ret
