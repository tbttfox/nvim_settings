local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "romgrk/nvim-treesitter-context",
        config = function ()
            local tsc = require("treesitter-context")
            tsc.setup({
                enable = false,
                throttle = true,
                max_lines = 2,
            })
        end,
    })
end
return ret
