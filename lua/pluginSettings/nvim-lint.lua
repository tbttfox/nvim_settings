local ret = {}
function ret.loadPlugin(packUse)
    packUse({"mfussenegger/nvim-lint"})
end
return ret
