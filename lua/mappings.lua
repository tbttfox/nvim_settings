require('mapx').setup({global = true})
vim.g.mapleader = " "

-- Line text objects
vnoremap("al", ":<c-u>norm!0v$h<cr>", {silent =  true})
vnoremap("il", ":<c-u>norm!^vg_<cr>", {silent =  true})
onoremap("al", ":norm val<cr>", {silent =  true})
onoremap("il", ":norm vil<cr>", {silent =  true})

-- Don't exit visual mode when shifting.
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Turn off Ex mode
map("Q", "<Nop>")

--return the cursor to the beginning of the repeated command
nmap(".", ".`[")

-- toggle whitespace highlighting
nnoremap("<F11>", ":<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>")
-- toggle tabs/spaces
nnoremap("<F10>", ":set expandtab!<CR>:%retab!<CR>")

-- Alt+left/right moves between tabs
noremap("<A-Left>", "gT")
noremap("<A-Right>", "gt")

-- ctrl+left/rigth moves between splits
nnoremap("<C-Up>", ":wincmd k<CR>", "silent")
nnoremap("<C-Down>", ":wincmd j<CR>", "silent")
nnoremap("<C-Left>", ":wincmd h<CR>", "silent")
nnoremap("<C-Right>", ":wincmd l<CR>", "silent")

-- space toggles folding
nnoremap("<leader><leader>", "za")

-- edit/source vimrc
nnoremap("<leader>ve", ":tabe $MYVIMRC<cr>")
nnoremap("<leader>vs", ":source $MYVIMRC<cr>")

-- turn off highlighting
nnoremap("<leader>n", ":noh<cr>")

-- add expected esc behavior to terminal
tnoremap("<Esc>", "<C-\\><C-n>")
