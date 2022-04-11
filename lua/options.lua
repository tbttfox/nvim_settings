
vim.opt.mouse = 'a'                      -- In many terminal emulators the mouse works just fine, thus enable it.

vim.opt.title = true                     -- Make sure the window title gets the current filepath
vim.opt.history = 100                    -- keep 100 lines of command line history
vim.opt.ruler = true                     -- show the cursor position all the time
vim.opt.showcmd = true                   -- display incomplete commands
vim.opt.showmode = true
vim.opt.incsearch = true                 -- do incremental searching
vim.opt.inccommand = 'nosplit'           -- Awesome live update of substitutions
vim.opt.signcolumn = 'yes'               -- Always show the column to the left of the numbers

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4                   -- 4 characters for indenting
vim.opt.expandtab = true                 -- turn tabs into spaces
vim.opt.shiftround = true                -- when shifting, go to nearest tabstop
vim.opt.autoindent = true                -- automatically indent

vim.opt.number = true                    -- line numbers
vim.opt.winaltkeys = 'no'                -- don't use alt keys for the menus

vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest,full'

vim.opt.ignorecase = true                -- ignore case
vim.opt.smartcase = true                 -- but don't ignore it when search string contains uppercase letters
vim.opt.hlsearch = true                  -- highlight searches

vim.opt.hid = true                       -- allow switching buffers, which have unsaved changes
vim.opt.showmatch = true                 -- showmatch: Show the matching bracket for the last ')'?

vim.opt.clipboard = 'unnamed'            -- windows clipboard = vim * buffer... with this yy yanks to clipboard
vim.opt.backspace = 'indent,eol,start'   -- allow backspacing over everything in insert mode

-- vim.opt.foldmethod = 'indent'            -- Fold indentations ... may change this to syntax later
-- vim.opt.fml = 0                          -- allow folding of single lines

vim.g.foldmethod = 'expr'                      -- Fold using treesitter syntax
vim.g.foldexpr = 'nvim_treesitter#foldexpr()'
