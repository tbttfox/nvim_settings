local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "psf/black",
        config = function ()
            vim.g.black_skip_string_normalization = true
        end,
    })
end
return ret


