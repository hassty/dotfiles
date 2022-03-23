local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("", "<CR>", "o<Esc>k", opts)
keymap("", "<M-CR>", "O<Esc>j", opts)
keymap("", "ZX", "ZQ", opts)
keymap("", "Q", "gqq", opts)
keymap("", "H", "^", opts)
keymap("", "L", "$", opts)
keymap("", "M", "%", opts)
keymap("", "gh", "H", opts)
keymap("", "gl", "L", opts)
keymap("", "gm", "M", opts)

keymap("n", "{", "{zz", opts)
keymap("n", "}", "}zz", opts)

keymap("c", "<C-n>", "<Down>", opts)
keymap("c", "<C-e>", "<Up>", opts)
keymap("c", "<C-a>", "<Home>", opts)
keymap("c", "<C-k>", "<End>", opts)

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
vim.cmd([[
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
]])

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

keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap(
	"n",
	"<leader>lp",
	"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	opts
)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)

keymap("n", "<leader>X", "<cmd> lua require'twilight'.setup({context=10})<CR>", opts)
keymap("n", "<leader>x", "<cmd> lua require'twilight'.setup({context=0})<CR>", opts)
