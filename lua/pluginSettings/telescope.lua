local ret = {}

function ret.loadPlugin(packUse)
    packUse({
        "nvim-telescope/telescope.nvim",
        requires = {'nvim-lua/plenary.nvim'},
        -- module = "telescope",
        after = {"telescope-packer.nvim", },
        config = function ()
            require('telescope').setup{
                defaults = {
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key"
                        }
                    }
                }
            }

            local opts = { noremap=true, silent=true }
            vim.api.nvim_set_keymap('n', '<space>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts)
            vim.api.nvim_set_keymap('n', '<space>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
            vim.api.nvim_set_keymap('n', '<space>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
            vim.api.nvim_set_keymap('n', '<space>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)
        end,
    })
end
return ret
