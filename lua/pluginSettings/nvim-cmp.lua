local ret = {}
function ret.loadPlugin()
    packUse({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "kdheepak/cmp-latex-symbols",
            "ray-x/cmp-treesitter",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
        },
        config = function ()
            local cmp = require('cmp')
            cmp.setup({
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        -- This little snippet will confirm with tab
                        -- and if no entry is selected, will confirm the first item
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                cmp.confirm()
                            end
                        else
                            fallback()
                        end
                    end, {"i","s","c",}),
                },
                sources = cmp.config.sources({
                    {name = 'nvim_lsp'},
                    {name = 'luasnip'},
                },
                {
                    {name = 'buffer'},
                })
            })
        end,
    })
end
return ret
