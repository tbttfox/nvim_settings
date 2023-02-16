-- Any plugins that just require loading with minimal setup (no more than a couple lines) go in here

local Utils = require("tfox.utils")

return {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },

    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
        },
    },

    {
        "psf/black",
        init = function()
            vim.g.black_skip_string_normalization = true
        end,
    },

    {
        "tbttfox/arctic.nvim",
        dependencies = {"rktjmp/lush.nvim"},
        config = function() vim.cmd.colorscheme("arctic") end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build=":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Shrink selection", mode = "x" },
        },
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            auto_install = true,
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "help",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "nvim-treesitter/playground",
        event = "VeryLazy",
    },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },

    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end
    },

    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },

    --[[
    {
        "chaoren/vim-wordmotion",
        config = function ()
            vim.g.wordmotion_prefix = ','
        end
    },
    --]]

    "akinsho/bufferline.nvim",

    {
        "nvim-lualine/lualine.nvim",
        opts = function(plugin)
            local icons = Utils.icons

            local function fg(name)
                return function()
                    ---@type {foreground?:number}?
                    local hl = vim.api.nvim_get_hl_by_name(name, true)
                    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
                end
            end

            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        -- stylua: ignore
                        {
                            function() return require("nvim-navic").get_location() end,
                            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
                        },
                    },
                    lualine_x = {
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                            color = fg("Statement")
                        },
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                            color = fg("Constant") ,
                        },
                        { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                    },
                    lualine_y = {
                        { "progress", separator = "", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
                extensions = { "neo-tree" },
            }
        end,
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        --event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            --{'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional

            -- Neoconf has to come first
            {"folke/neoconf.nvim"}
        },
        init = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.nvim_workspace()
            lsp.setup()
        end
    },

    {
        "airblade/vim-rooter",
        config = function()
            vim.g.rooter_silent_chdir = 1
            vim.g.rooter_patterns = {
                '.git',
                '.svn',
                'Makefile',
                '*.sln',
                '>GitHub',
                '>GitLab',
                '!^source.blur.com',
                '!^c$',
            }
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies="nvim-lua/plenary.nvim",
        branch = '0.1.x',
        configure=function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({search= vim.fn.input("Grep > ")})
            end)
        end
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        keys = {
            { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
            { "<leader>/", Utils.telescope("live_grep"), desc = "Find in Files (Grep)" },
            { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            -- find
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>ff", Utils.telescope("files"), desc = "Find Files (root dir)" },
            { "<leader>FF", Utils.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
            -- git
            { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
            -- search
            { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
            { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
            { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
            { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
            { "<leader>sg", Utils.telescope("live_grep"), desc = "Grep (root dir)" },
            { "<leader>sG", Utils.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
            { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
            { "<leader>sw", Utils.telescope("grep_string"), desc = "Word (root dir)" },
            { "<leader>sW", Utils.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
            { "<leader>uC", Utils.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
            {
                "<leader>ss",
                Utils.telescope("lsp_document_symbols", {
                    symbols = {
                        "Class",
                        "Function",
                        "Method",
                        "Constructor",
                        "Interface",
                        "Module",
                        "Struct",
                        "Trait",
                        "Field",
                        "Property",
                    },
                }),
                desc = "Goto Symbol",
            },
        },
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                mappings = {
                    i = {
                        ["<c-t>"] = function(...)
                            return require("trouble.providers.telescope").open_with_trouble(...)
                        end,
                        ["<a-i>"] = function()
                            Utils.telescope("find_files", { no_ignore = true })()
                        end,
                        ["<a-h>"] = function()
                            Utils.telescope("find_files", { hidden = true })()
                        end,
                        ["<C-Down>"] = function(...)
                            return require("telescope.actions").cycle_history_next(...)
                        end,
                        ["<C-Up>"] = function(...)
                            return require("telescope.actions").cycle_history_prev(...)
                        end,
                    },
                },
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- char = "▏",
            char = "│",
            filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },

    {
        "echasnovski/mini.surround",
        keys = function(_, keys)
            -- Populate the keys based on the user's options
            --
            local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)

            local mappings = {
                { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
                { opts.mappings.delete, desc = "Delete surrounding" },
                { opts.mappings.find, desc = "Find right surrounding" },
                { opts.mappings.find_left, desc = "Find left surrounding" },
                { opts.mappings.highlight, desc = "Highlight surrounding" },
                { opts.mappings.replace, desc = "Replace surrounding" },
            }
            return vim.list_extend(mappings, keys)
        end,
        opts = {
            mappings = {
                add = "ys", -- Add surrounding in Normal and Visual modes
                delete = "ds", -- Delete surrounding
                find = "yf", -- Find surrounding (to the right)
                find_left = "yF", -- Find surrounding (to the left)
                highlight = "yh", -- Highlight surrounding
                replace = "cs", -- Replace surrounding
            },
        },
        config = function(_, opts)
            -- use gz mappings instead of s to prevent conflict with leap
            require("mini.surround").setup(opts)
        end,
    },
    "tpope/vim-abolish",
    "NMAC427/guess-indent.nvim",

    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree",
            },

            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree", remap = true },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
        },
    },

    {
        "echasnovski/mini.bufremove",
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
    },

    {
        "echasnovski/mini.pairs",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },

    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            hooks = {
                pre = function()
                    require("ts_context_commentstring.internal").update_commentstring({})
                end,
            },
        },
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },

    {
        "echasnovski/mini.ai",
        -- keys = {
        --   { "a", mode = { "x", "o" } },
        --   { "i", mode = { "x", "o" } },
        -- },
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- no need to load the plugin, since we only need its queries
                    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                end,
            },
        },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                },

                mappings = {
                    -- Main textobject prefixes
                    around = 'a',
                    inside = 'i',

                    -- Next/last variants
                    around_next = 'an',
                    inside_next = 'in',
                    around_last = '', --'al', I prefer "Line" objects
                    inside_last = '', --'il', I prefer "Line" objects

                    -- Move cursor to corresponding edge of `a` textobject
                    goto_left = 'g[',
                    goto_right = 'g]',
                },
            }
        end,
        config = function(_, opts)
            local ai = require("mini.ai")
            ai.setup(opts)
        end,
    },

    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
        },
    },

    {
        "SmiteshP/nvim-navic",
        lazy = true,
        init = function()
            vim.g.navic_silence = true
            Utils.on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        opts = function()
            return {
                separator = " ",
                highlight = true,
                depth_limit = 5,
                icons = Utils.icons.kinds,
            }
        end,
    },

    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Delete all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register({
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                --["gz"] = { name = "+surround" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file/find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>sn"] = { name = "+noice" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>w"] = { name = "+windows" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
            })
        end,
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
        },
    },

    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
        },
        -- stylua: ignore
        keys = {
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
        },
    },

    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        init = function()
            -- Init always gets loaded

            vim.keymap.set("n", "<F2>", require('dap').step_into)
            vim.keymap.set("n", "<F3>", require('dap').step_out)
            vim.keymap.set("n", "<F4>", require('dap').step_over)
            vim.keymap.set("n", "<F5>", require('dap').continue)
            vim.keymap.set("n", "<leader><F5>", require('dap').run_last)

            vim.keymap.set("n", "<leader>b", require('dap').toggle_breakpoint)
            vim.keymap.set("n", "<leader>B", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint Condition: ')) end)
            vim.keymap.set("n", "<leader>lp", function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message:')) end)
            vim.keymap.set("n", "<leader>dr", require('dap').repl.open)
            vim.keymap.set("n", "<leader>dt", require('dap').terminate)
        end
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        event = "VeryLazy",
    },

    {
        "mfussenegger/nvim-dap-python",
        event = "VeryLazy",
        config = function ()
            local sep = "\\"
            local masonRoot = table.concat({ vim.fn.stdpath("data"), "mason" }, sep)
            local winPyExe = table.concat({"packages", "debugpy", "venv", "Scripts", "pythonw.exe"}, sep)
            local dapExe = table.concat({masonRoot, winPyExe}, sep)
            require('dap-python').setup(dapExe)

            table.insert(
                require('dap').configurations.python,
                1,
                {
                    console = "integratedTerminal",
                    name = 'FaceFit Py3 Launch',
                    program = '${file}',
                    request = 'launch',
                    type = 'python',
                    python = '\\\\source\\source\\dev\\tyler\\FaceFit\\FaceFitPy3\\Scripts\\python.exe',
                }
            )

            table.insert(
                require('dap').configurations.python,
                1,
                {
                    console = "integratedTerminal",
                    name = 'Global Py3',
                    program = '${file}',
                    request = 'launch',
                    type = 'python',
                    python = 'C:\\Program Files\\Python39\\python.exe',
                }
            )
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        init = function()
            local dapNoFoldGrp = vim.api.nvim_create_augroup("DapNoFold", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"dap*", },
                command = "silent! lua vim.wo.foldenable = false",
                group = dapNoFoldGrp,
            })
        end,
        config = function ()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup({})
            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.after.event_terminated["dapui_config"] = dapui.close
            dap.listeners.after.event_exited["dapui_config"] = dapui.close
        end,
    },

}
