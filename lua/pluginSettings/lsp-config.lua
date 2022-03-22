local ret = {}
function ret.loadPlugin()
    packUse({
        "neovim/nvim-lspconfig",
        config = function ()
            local lspconfig = require('lspconfig')
            lspconfig.pyright.setup({})
        end,
    })
end
return ret
