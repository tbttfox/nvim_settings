local ret = {}
function ret.loadPlugin(packUse)
    packUse({"williamboman/nvim-lsp-installer"})
end
return ret
