local map = vim.keymap.set

map("", "<Space>", "<Nop>", { expr = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function cr()
	return vim.bo.filetype == "qf" and "<CR>" or "o<Esc>k"
end

local function leader_o()
	return vim.api.nvim_get_current_line() == "" and "o<C-\\><C-o>O" or "o<C-\\><C-o>o"
end

map("", "<CR>", cr, { expr = true })
map("", "<M-CR>", "O<Esc>j")
map("", "<leader>O", "O<C-\\><C-o>O")
map("", "<leader>o", leader_o, { expr = true })
map("", "<leader>$", "$h")
map("", "<leader>L", "$h")
map("", "<leader>i", "i <C-g>U<Left>")
map("", "<leader>I", "I <C-g>U<Left>")
map("", "<leader>,", "i, <C-g>U<Left><C-g>U<Left>")
map("", "<leader>'", "i'', <C-g>U<Left><C-g>U<Left><C-g>U<Left>")
map("", '<leader>"', 'i"", <C-g>U<Left><C-g>U<Left><C-g>U<Left>')
map("", "zx", "ZQ")
map("", "zz", "ZZ")
map("", "ZZ", '<CMD>call smoothie#do("zz")<CR>')
map("", "Q", "gqq")
map("", "H", "^")
map("", "L", "$")
map("", "M", "%")
map("", "gh", "H")
map("", "gl", "L")
map("", "<C-s>", '<CMD>call smoothie#do("\\<C-D>")<CR>')

map({ "n", "v" }, "<leader>p", '"+p')
map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "<leader>Y", '"+y$')

map("", "<leader>x", "<CMD>!chmod +x %<CR>")

-- keeping it centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "{", "{zz")
map("n", "}", "}zz")

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

map("", "<C-j>", "<CMD>cnext<CR>")
map("", "<C-k>", "<CMD>cprev<CR>")

-- undo breakpoints
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", "!", "!<C-g>u")
map("i", "?", "?<C-g>u")
map("i", "=", "=<C-g>u")

-- add big relative jumps to jumplist
map("n", "k", [[(v:count > 5 ? "m'" . v:count : "") . 'k']], { expr = true })
map("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true })
map("n", "<C-p>", [[(v:count > 5 ? "m'" . v:count : "") . 'k']], { expr = true })
map("n", "<C-n>", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true })

-- moving text
map("v", "<M-n>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<M-e>", ":m '<-2<CR>gv=gv", { silent = true })
map("n", "<M-n>", ":m .+1<CR>==", { silent = true })
map("n", "<M-e>", ":m .-2<CR>==", { silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- easier split navigation
map("n", "<C-w><C-h>", "<C-w>h")
map("n", "<C-w><C-n>", "<C-w>j")
map("n", "<C-w><C-e>", "<C-w>k")
map("n", "<C-w><C-i>", "<C-w>l")

map("n", "<C-w>d", "<CMD>bwipeout<CR>")

-- calculate expression
map("i", "<M-=>", "<C-O>yiW<End>=<C-R>=<C-R>0<CR>")

map("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<leader>rs", [["hy:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map("n", "<leader>/", "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>")
map("x", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>")

map("n", "<F5>", "<CMD>lua require'dap'.continue()<CR>")
map("n", "<F10>", "<CMD>lua require'dap'.step_over()<CR>")
map("n", "<F11>", "<CMD>lua require'dap'.step_into()<CR>")
map("n", "<F12>", "<CMD>lua require'dap'.step_out()<CR>")
map("n", "<leader>b", "<CMD>lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<leader>B", "<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>up", "<CMD>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<leader>dr", "<CMD>lua require'dap'.repl.open()<CR>")
map("n", "<leader>dl", "<CMD>lua require'dap'.run_last()<CR>")
map({ "n", "v" }, "<leader>k", '<CMD>lua require("dapui").eval()<CR>')

-- gitsigns
map("n", "]g", '<CMD>lua require "gitsigns".next_hunk()<CR>')
map("n", "[g", '<CMD>lua require "gitsigns".prev_hunk()<CR>')

-- lsp
local function next_diag(severity)
	vim.diagnostic.goto_next({ border = "rounded", severity = severity })
end

local function prev_diag(severity)
	vim.diagnostic.goto_prev({ border = "rounded", severity = severity })
end

local severity = vim.diagnostic.severity

map("n", "[t", function()
	prev_diag(severity.ERROR)
end)
map("n", "]t", function()
	next_diag(severity.ERROR)
end)
map("n", "[s", function()
	prev_diag(severity.WARN)
end)
map("n", "]s", function()
	next_diag(severity.WARN)
end)
map("n", "[a", '<CMD>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
map("n", "]a", '<CMD>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
map("n", "<leader>n", vim.lsp.buf.hover)
map("n", "<M-space>", vim.lsp.buf.signature_help)
map("i", "<M-space>", vim.lsp.buf.signature_help)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gr", require("telescope.builtin").lsp_references)
map("n", "gm", vim.lsp.buf.implementation)

map("n", "[c", function()
	require("treesitter-context").go_to_context()
end, { silent = true })
