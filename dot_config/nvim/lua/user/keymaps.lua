local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("keymaps", { clear = true })

map("", "<Space>", "<Nop>", { expr = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

autocmd("BufEnter", {
	callback = function()
		vim.schedule(function()
			if vim.bo.filetype == "qf" then
				map("", "<CR>", "<CR>")
			else
				map("", "<CR>", "o<Esc>k")
			end
		end)
	end,
	group = group,
})
map("", "<M-CR>", "O<Esc>j")
map("", "<leader>O", "O<C-o>O")
map("", "<leader>o", "o<C-o>o")
map("", "<leader>$", "$h")
map("", "<leader>L", "$h")
map("", "<leader>i", "i <C-g>U<Left>")
map("", "<leader>I", "I <C-g>U<Left>")
map("", "ZX", "ZQ")
map("", "Q", "gqq")
map("", "H", "^")
map("", "L", "$")
map("", "M", "%")
map("", "gh", "H")
map("", "gl", "L")

-- keeping it centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "{", "{zz")
map("n", "}", "}zz")
map("n", "gi", "gi<Esc>zzi")

map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")
map("c", "<C-p>", "<Up>")
map("c", "<C-n>", "<Down>")

map("i", "<M-;>", "<Esc>A;<CR>")
map("i", "<M-,>", "<Esc>A,<CR>")
map("i", "<M-.>", "<Esc>A.<CR>")
map("i", "<M-CR>", "<Esc>o")
map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map("i", "<C-f>", "<Right>")
map("i", "<C-b>", "<Left>")

-- undo breakpoints
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", "!", "!<C-g>u")
map("i", "?", "?<C-g>u")
map("i", "=", "=<C-g>u")

-- add big relative jumps to jumplist
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . 'k']], { expr = true })
map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true })

-- moving text
map("v", "<M-n>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<M-e>", ":m '<-2<CR>gv=gv", { silent = true })
map("n", "<M-n>", ":m .+1<CR>==", { silent = true })
map("n", "<M-e>", ":m .-2<CR>==", { silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- easier split navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- calculate expression
map("i", "<M-=>", "<C-O>yiW<End>=<C-R>=<C-R>0<CR>")

map("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])
map("v", "<leader>rs", [["hy:%s/<C-r>h//g<Left><Left>]])

map("n", "<leader>/", "<CMD>lua require('Comment.api').toggle_current_linewise()<CR>")
map("x", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")

map("n", "<F5>", "<CMD>lua require'dap'.continue()<CR>")
map("n", "<F10>", "<CMD>lua require'dap'.step_over()<CR>")
map("n", "<F11>", "<CMD>lua require'dap'.step_into()<CR>")
map("n", "<F12>", "<CMD>lua require'dap'.step_out()<CR>")
map("n", "<leader>b", "<CMD>lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<leader>B", "<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>lp", "<CMD>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<leader>dr", "<CMD>lua require'dap'.repl.open()<CR>")
map("n", "<leader>dl", "<CMD>lua require'dap'.run_last()<CR>")
map({ "n", "v" }, "<leader>k", '<CMD>lua require("dapui").eval()<CR>')

-- gitsigns
map("n", "]g", '<CMD>lua require "gitsigns".next_hunk()<CR>')
map("n", "[g", '<CMD>lua require "gitsigns".prev_hunk()<CR>')

-- lsp
map("n", "[d", '<CMD>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
map("n", "]d", '<CMD>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
map("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>")
map("n", "<M-space>", "<CMD>lua vim.lsp.buf.signature_help()<CR>")
map("i", "<M-space>", "<CMD>lua vim.lsp.buf.signature_help()<CR>")
map("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>")
map("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>")
map("n", "gm", "<CMD>lua vim.lsp.buf.implementation()<CR>")
