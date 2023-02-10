vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move visual selection with capital J/K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Joining stays at the left
vim.keymap.set("n", "J", "mzJ`z")

-- searching stays in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- leader+paste/delete goes to the black hole
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- here be dragons
vim.keymap.set("n", "Q", "<nop>")

-- format the file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- snips
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- substitute the current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Line text objects
vim.keymap.set("v", "al", ":<c-u>norm!0v$h<cr>", { silent = true })
vim.keymap.set("v", "il", ":<c-u>norm!^vg_<cr>", { silent = true })
vim.keymap.set("o", "al", ":norm val<cr>", { silent = true })
vim.keymap.set("o", "il", ":norm vil<cr>", { silent = true })

-- Don't exit visual mode when shifting.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- toggle whitespace highlighting
vim.keymap.set("n", "<F11>", ":<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>")
-- toggle tabs/spaces
vim.keymap.set("n", "<F10>", ":set expandtab!<CR>:%retab!<CR>")

-- ctrl+left/rigth moves between splits
vim.keymap.set("n", "<C-Up>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":wincmd l<CR>", { silent = true })

-- space toggles folding
vim.keymap.set("n", "<leader><leader>", "za")

-- edit/source vimrc
vim.keymap.set("n", "<leader>ve", ":tabe $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>vs", ":source $MYVIMRC<cr>")

-- turn off highlighting
vim.keymap.set("n", "<leader>n", ":noh<cr>")

-- add expected esc behavior to terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
