local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("keymaps", { clear = true })

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

autocmd("BufEnter", {
	callback = function()
		vim.schedule(function()
			if vim.bo.filetype == "qf" then
				keymap("", "<CR>", "<CR>", opts)
			else
				keymap("", "<CR>", "o<Esc>k", opts)
			end
		end)
	end,
	group = group,
})
keymap("", "<M-CR>", "O<Esc>j", opts)
keymap("", "ZX", "ZQ", opts)
keymap("", "Q", "gqq", opts)
keymap("", "H", "^", opts)
keymap("", "L", "$", opts)
keymap("", "M", "%", opts)
keymap("", "gh", "H", opts)
keymap("", "gl", "L", opts)

keymap("n", "{", "{zz", opts)
keymap("n", "}", "}zz", opts)

vim.cmd([[
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
]])

keymap("i", "<M-;>", "<Esc>A;<CR>", opts)
keymap("i", "<M-,>", "<Esc>A,<CR>", opts)
keymap("i", "<M-.>", "<Esc>A.<CR>", opts)
keymap("i", "<M-CR>", "<Esc>o", opts)
keymap("i", "<C-a>", "<Home>", opts)
keymap("i", "<C-e>", "<End>", opts)
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "<C-b>", "<Left>", opts)

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
keymap("v", "<M-n>", ":m '>+1<Cr>gv=gv", opts)
keymap("v", "<M-e>", ":m '<-2<Cr>gv=gv", opts)
keymap("i", "<M-n>", "<Esc>:m .+1<Cr>==a", opts)
keymap("i", "<M-e>", "<Esc>:m .-2<Cr>==a", opts)
keymap("n", "<M-n>", ":m .+1<Cr>==", opts)
keymap("n", "<M-e>", ":m .-2<Cr>==", opts)

-- better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- easier split navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

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

-- gitsigns
keymap("n", "]g", '<cmd>lua require "gitsigns".next_hunk()<cr>', opts)
keymap("n", "[g", '<cmd>lua require "gitsigns".prev_hunk()<cr>', opts)

-- lsp
keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<M-space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("i", "<M-space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

-- keeping it centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)
