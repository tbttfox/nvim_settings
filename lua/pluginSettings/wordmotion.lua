local ret = {}
function ret.loadPlugin()
    packUse({
        "chaoren/vim-wordmotion",
        config = function ()
            vim.g.wordmotion_prefix = ','
        end
    })
end
return ret
