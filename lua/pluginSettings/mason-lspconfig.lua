local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "williamboman/mason-lspconfig.nvim",
        requires = {"williamboman/mason.nvim"},
        config = function ()
            require("mason-lspconfig").setup()
        end,
    })
end
return ret
