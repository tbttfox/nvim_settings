local mapx = require('mapx')

-- Line text objects
mapx.vnoremap("al", ":<c-u>norm!0v$h<cr>", {silent =  true})
mapx.vnoremap("il", ":<c-u>norm!^vg_<cr>", {silent =  true})
mapx.onoremap("al", ":norm val<cr>", {silent =  true})
mapx.onoremap("il", ":norm vil<cr>", {silent =  true})

-- Don't exit visual mode when shifting.
mapx.vnoremap("<", "<gv")
mapx.vnoremap(">", ">gv")

-- Turn off Ex mode
mapx.nnoremap("Q", "<Nop>")

--return the cursor to the beginning of the repeated command
mapx.nnoremap(".", ".`[")

-- toggle whitespace highlighting
mapx.nnoremap("<F11>", ":<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>")
-- toggle tabs/spaces
mapx.nnoremap("<F10>", ":set expandtab!<CR>:%retab!<CR>")

-- Alt+left/right moves between tabs
mapx.noremap("<A-Left>", "gT")
mapx.noremap("<A-Right>", "gt")

-- ctrl+left/rigth moves between splits
mapx.nnoremap("<C-Up>", ":wincmd k<CR>", "silent")
mapx.nnoremap("<C-Down>", ":wincmd j<CR>", "silent")
mapx.nnoremap("<C-Left>", ":wincmd h<CR>", "silent")
mapx.nnoremap("<C-Right>", ":wincmd l<CR>", "silent")

-- space toggles folding
mapx.nnoremap("<leader><leader>", "za")

-- edit/source vimrc
mapx.nnoremap("<leader>ve", ":tabe $MYVIMRC<cr>")
mapx.nnoremap("<leader>vs", ":source $MYVIMRC<cr>")

-- turn off highlighting
mapx.nnoremap("<leader>n", ":noh<cr>")

-- add expected esc behavior to terminal
mapx.tnoremap("<Esc>", "<C-\\><C-n>")
