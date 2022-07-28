local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "tbttfox/arctic.nvim",
        requires = {"rktjmp/lush.nvim"},
    })
end
return ret
