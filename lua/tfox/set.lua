vim.opt.mouse = 'a'
vim.opt.title = true
vim.opt.history = 10000

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.winaltkeys = 'no'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.inccommand = 'nosplit'

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true

vim.opt.updatetime = 50

vim.opt.clipboard = "unnamed"
vim.opt.backspace = "indent,eol,start"

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.fml = 0

vim.opt.breakindent = true
vim.opt.breakindentopt="shift:2,min:40,sbr"
vim.opt.showbreak=">>"

vim.opt.grepprg = "rg --vimgrep"
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.showmode = false -- Dont show mode since we have a statusline

vim.g.mapleader = " "
vim.g.maplocalleader = " "
