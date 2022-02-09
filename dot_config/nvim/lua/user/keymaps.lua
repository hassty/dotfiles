local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<F5>", ":source $MYVIMRC<CR>", opts)
keymap("n", "<CR>", "o<Esc>k", opts)
keymap("n", "<M-CR>", "O<Esc>j", opts)
keymap("n", "ZX", "ZQ", opts)
keymap("n", "Q", "gqq", opts)
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("n", "M", "%", opts)
keymap("n", "gh", "H", opts)
keymap("n", "gl", "L", opts)
keymap("n", "gm", "M", opts)
keymap("n", "<M-n>", "j", opts)
keymap("n", "<M-e>", "k", opts)

keymap("n", "{", "{zz", opts)
keymap("n", "}", "}zz", opts)

vim.cmd([[
cnoremap <C-n> <Down>
cnoremap <C-e> <Up>
cnoremap <C-a> <Home>
cnoremap <C-k> <End>
]])

keymap("i", "<M-;>", "<Esc>A;<CR>", opts)
keymap("i", "<M-,>", "<Esc>A,<CR>", opts)
keymap("i", "<M-.>", "<Esc>A.<CR>", opts)
keymap("i", "<M-CR>", "<Esc>o", opts)
keymap("i", "<C-a>", "<C-o>I", opts)
keymap("i", "<C-k>", "<C-o>A", opts)

-- undo breakpoints
keymap("i", ",", ",<C-g>u", opts)
keymap("i", ".", ".<C-g>u", opts)
keymap("i", "!", "!<C-g>u", opts)
keymap("i", "?", "?<C-g>u", opts)
keymap("i", "=", "=<C-g>u", opts)

-- add big relative jumps to jumplist
vim.cmd([[nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k']])
vim.cmd([[nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j']])

-- moving text
keymap("v", "<M-j>", ":m '>+1<Cr>gv=gv", opts)
keymap("v", "<M-k>", ":m '<-2<Cr>gv=gv", opts)
keymap("i", "<M-j>", "<Esc>:m .+1<Cr>==a", opts)
keymap("i", "<M-k>", "<Esc>:m .-2<Cr>==a", opts)
keymap("n", "<M-j>", ":m .+1<Cr>==", opts)
keymap("n", "<M-k>", ":m .-2<Cr>==", opts)

-- better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- easier split navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- calculate expression
keymap("i", "<M-=>", "<C-O>yiW<End>=<C-R>=<C-R>0<CR>", opts)

vim.cmd([[nnoremap <Leader>rs :%s/\<<C-r><C-w>\>//g<Left><Left>]])
vim.cmd([[vnoremap <Leader>rs "hy:%s/<C-r>h//g<Left><Left>]])

keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)

-- keymap("n", "<leader>,", ":vertical resize -5<CR>", opts)
-- keymap("n", "<leader>.", ":vertical resize +5<CR>", opts)
-- keymap("n", "<leader>th", "<C-w>t<C-w>K", opts)
-- keymap("n", "<leader>tv", "<C-w>t<C-w>H", opts)
