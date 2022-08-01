local ret = {}

function ret.loadPlugin(packUse)
    packUse({
        "nvim-telescope/telescope.nvim",
        requires = {'nvim-lua/plenary.nvim'},
        -- module = "telescope",
        after = {"mapx.nvim", },
        config = function ()
            require('telescope').setup{
                defaults = {
                    initial_mode = "normal",
                },
            }
            local mapx = require('mapx')
            mapx.nnoremap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', 'Telescope: Find Files')
            mapx.nnoremap('<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', 'Telescope: File Grep')
            mapx.nnoremap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', 'Telescope: Find Buffer')
            mapx.nnoremap('<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', 'Telescope: Find Help')
        end,
    })
end
return ret
