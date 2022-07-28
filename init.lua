vim.g.python_host_prog = "C:\\Python27\\python.exe"
vim.g.python3_host_prog = "C:\\Users\\tyler\\AppData\\Local\\nvim\\venvs\\nvim\\Scripts\\python.exe"
vim.g.mapleader = " "

require("plugins")
require("options")
require("mappings")

-- The colorscheme must be set before the UI is
-- loaded for the tab lines plugin to work
vim.cmd("colorscheme arctic")

-- Guifont must be called after the UI is loaded
if vim.fn.has('ttyout') == 0 then
    vim.api.nvim_create_autocmd(
        "UIEnter", {
            once = true,
            callback = function()
                vim.cmd("Guifont! RobotoMono NF:h10")
                vim.opt.linespace=2
            end
        }
    )
end
