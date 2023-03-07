-- Any plugins that just require loading with minimal setup (no more than a couple lines) go in here

local Utils = require("tfox.utils")

return {
    -- Ensure that the lua LSP has access to neovim objects
    { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },

    -- Store sessions automagically
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

    -- Python code formatting
    {
        "psf/black",
        init = function()
            vim.g.black_skip_string_normalization = true
        end,
    },

    -- My own color
    {
        "tbttfox/arctic.nvim",
        dependencies = {"rktjmp/lush.nvim"},
        config = function() vim.cmd.colorscheme("arctic") end,
    },

    -- Treesitter code parsing
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

    -- Show the treesitter tree in an explorable buffer
    {
        "nvim-treesitter/playground",
        event = "VeryLazy",
    },

    -- Show an explorable undo tree so I don't lose any changes
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },

    -- Vim git integration
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end
    },

    -- Some cool icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- A UI component library
    { "MunifTanjim/nui.nvim", lazy = true },

    --[[
    -- Separate words into subword objects
    {
        "chaoren/vim-wordmotion",
        config = function ()
            vim.g.wordmotion_prefix = ','
        end
    },
    --]]

    -- List the open buffers along the top of the screen
    {
        "akinsho/bufferline.nvim",
        init = function()
            require("bufferline").setup({})
        end,
    },

    -- A very nice looking statusline
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


    -- LSP
    { "hrsh7th/nvim-cmp" },
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    { "williamboman/mason-lspconfig.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-nvim-lua'},
    {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        opts = function()
            local nls = require("null-ls")
            return {
                sources = {
                    -- nls.builtins.formatting.prettierd,
                    nls.builtins.formatting.stylua,
                    -- nls.builtins.diagnostics.flake8,
                },
            }
        end,
    },

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
                "flake8",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(plugin, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        --[[
        init = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            -- change a keymap
            keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
            -- disable a keymap
            keys[#keys + 1] = { "K", false }
            -- add a keymap
            keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
        end,
        --]]
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            },
            -- Automatically format on save
            autoformat = true,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },

            -- LSP Server Settings
            ---@type lspconfig.options
            servers = {
                jsonls = {},
                lua_ls = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            diagnostics = {
                                globals = { 'vim' }
                            },
                        },
                    },
                },
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                flake8 = {
                                    enabled = true,
                                    ignore = {
                                        'W391', -- blank line at end of file
                                        'W191', -- tab indents
                                        'W503', -- line break before operator
                                        'E203', -- Black likes to put shitespace around colons
                                        'E501', -- Line Too Long
                                        'N802', -- Function snake_case naming convention
                                        'N803', -- Argument snake_case naming convention
                                        'N806', -- Variable snake_case naming convention
                                    },
                                    maxLineLength = 100
                                },
                                pyflakes = { enabled = false },
                                pycodestyle = { enabled = false },
                                yapf = { enabled = false },
                                autopep8 = { enabled = false },
                            },
                        },
                    },
                },
            },

            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },

        ---@param opts PluginLspOpts
        config = function(plugin, opts)
            -- setup autoformat
            -- setup formatting and keymaps

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    --local buffer = args.buf
                    --local client = vim.lsp.get_client_by_id(args.data.client_id)


                    local format = function()
                        local buf = vim.api.nvim_get_current_buf()
                        if vim.b.autoformat == false then
                            return
                        end
                        local ft = vim.bo[buf].filetype
                        local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

                        vim.lsp.buf.format(vim.tbl_deep_extend("force", {
                            bufnr = buf,
                            filter = function(cli)
                                if have_nls then
                                    return cli.name == "null-ls"
                                end
                                return cli.name ~= "null-ls"
                            end,
                        }, {}))
                    end

                    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, {desc = "Line Diagnostics" })
                    vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", {desc = "Lsp Info" })
                    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", {desc = "Goto Definition" })
                    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {desc = "References" })
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {desc = "Goto Declaration" })
                    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", {desc = "Goto Implementation" })
                    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", {desc = "Goto Type Definition" })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Hover" })
                    vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {desc = "Code Action" })
                    vim.keymap.set("n", "<leader>cf", format, {desc = "Format Document"})
                    vim.keymap.set("v", "<leader>cf", format, {desc = "Format Range"})
                    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, {desc = "Signature Help"})
                    vim.keymap.set("i",  "<c-k>", vim.lsp.buf.signature_help, {desc = "Signature Help"})

                    --vim.keymap.set("n", "]d", M.diagnostic_goto(true), {desc = "Next Diagnostic" })
                    --vim.keymap.set("n", "[d", M.diagnostic_goto(false), {desc = "Prev Diagnostic" })
                    --vim.keymap.set("n", "]e", M.diagnostic_goto(true, "ERROR"), {desc = "Next Error" })
                    --vim.keymap.set("n", "[e", M.diagnostic_goto(false, "ERROR"), {desc = "Prev Error" })
                    --vim.keymap.set("n", "]w", M.diagnostic_goto(true, "WARN"), {desc = "Next Warning" })
                    --vim.keymap.set("n", "[w", M.diagnostic_goto(false, "WARN"), {desc = "Prev Warning" })
                end
            })

            -- diagnostics
            for name, icon in pairs(Utils.icons.diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end
            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- temp fix for lspconfig rename
            -- https://github.com/neovim/nvim-lspconfig/pull/2439
            local mappings = require("mason-lspconfig.mappings.server")
            if not mappings.lspconfig_to_package.lua_ls then
                mappings.lspconfig_to_package.lua_ls = "lua-language-server"
                mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
            end

            local mlsp = require("mason-lspconfig")
            local available = mlsp.get_available_servers()

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(available, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
            require("mason-lspconfig").setup_handlers({ setup })
        end,
    },

    -- Automatically CD to the root of the current project
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

    -- AWESOME fuzzy finder over ... well ... everything
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        branch = '0.1.x',
        dependencies="nvim-lua/plenary.nvim",
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

    -- Draw nice vertical alignment indicators
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

    -- add the surround objects
    -- TODO: Figure out how to stop these mappings in visual mode
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
                add = "ss", -- Add surrounding in Normal and Visual modes
                delete = "ds", -- Delete surrounding
                find = "sf", -- Find surrounding (to the right)
                find_left = "sF", -- Find surrounding (to the left)
                highlight = "sh", -- Highlight surrounding
                replace = "cs", -- Replace surrounding
            },
        },
        config = function(_, opts)
            -- use gz mappings instead of s to prevent conflict with leap
            require("mini.surround").setup(opts)
        end,
    },

    -- Find/Replace while keeping capitalization
    -- Also "coerce" words between Camel, snake, etc..
    "tpope/vim-abolish",

    -- match the indentation style of the current file
    "NMAC427/guess-indent.nvim",

    -- A file explorer
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

    -- Keep the current split layout with buffers
    {
        "echasnovski/mini.bufremove",
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
    },

    -- Automatically make paired parnes/quotes/etc
    {
        "echasnovski/mini.pairs",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },

    -- Set the commentstrinf for the file, and add some mappings to comment blocks
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

    -- Add some more objects based on treesitter (functions/blocks/etc)
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

    -- Navigate over todos
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

    -- Show the current code context at the top of the screen
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        dependencies = {"neovim/nvim-lspconfig"},
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

    -- Keep track of all my keys, and let me know what they are if I pause in the middle
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

    -- Use the quickfix list for errors
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

    -- Notifications go in the top-right
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
            level = 3, -- Only show errors/warnings as popups
        },
    },

    -- the command line goes into its own floating window
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

    -- Expermiental UI changes
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = {
                view = "cmdline",
            },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                -- bottom_search = true,
                -- command_palette = true,
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

    -- The Debug Adapter Protocol
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

    -- Add more information about the current state from DAP while debugging
    {
        "theHamsta/nvim-dap-virtual-text",
        event = "VeryLazy",
    },

    -- Easily set up python for the dap
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

    -- A very nice UI for the DAP
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
