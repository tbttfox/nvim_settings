local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "tpope/vim-sleuth",
        config = function ()
        end,
    })
end
return ret
