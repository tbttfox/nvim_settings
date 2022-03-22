local ret = {}
function ret.loadPlugin()
    packUse({
        "numToStr/Comment.nvim",
        config = function ()
            require('Comment').setup({})
        end,
    })
end
return ret
