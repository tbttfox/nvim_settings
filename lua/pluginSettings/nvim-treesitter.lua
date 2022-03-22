local ret = {}
function ret.loadPlugin()
    packUse({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function ()
            require('nvim-treesitter').setup({})
        end,
    })
end
return ret
