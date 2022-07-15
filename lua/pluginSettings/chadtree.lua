local ret = {}
function ret.loadPlugin(packUse)
    packUse({
        "ms-jpq/chadtree",
        run=":CHADdeps",
        branch="chad",
        config = function ()
        end,
    })
end

local chadtree_settings = {
    ["theme.text_colour_set"] = "solarized_universal",
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

return ret
