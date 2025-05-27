-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local unmap = vim.keymap.del

-- change LazyVim defaults
unmap("", "<leader><tab>l")
unmap("", "<leader><tab>o")
unmap("", "<leader><tab>f")
unmap("", "<leader><tab><tab>")
unmap("", "<leader><tab>]")
unmap("", "<leader><tab>d")
unmap("", "<leader><tab>[")
unmap("", "<leader>`")
map("", "<leader><Tab>", "<C-^>", { desc = "Alternate file" })

unmap("", "<leader>fn")
unmap("", "<leader>ft")
unmap("", "<leader>fT")

unmap("", "<C-s>")
map("", "<C-s>", '<CMD>call smoothie#do("\\<C-D>")<CR>')
map("", "ZZ", '<CMD>call smoothie#do("zz")<CR>', { desc = "Center screen" })

map("", "<leader>w", "<cmd>silent write!<CR>", { desc = "Save" })
map("", "<leader>W", "<cmd>silent wall!<CR>", { desc = "Save All" })

map("", "<leader>c", "<cmd>bdelete!<CR>", { desc = "Close Buffer" })

local function cr()
  return vim.bo.filetype == "qf" and "<CR>" or "o<Esc>k"
end

local function leader_o()
  return vim.api.nvim_get_current_line() == "" and "o<C-\\><C-o>O" or "o<C-\\><C-o>o"
end

map("", "<CR>", cr, { expr = true })
map("", "<M-CR>", "O<Esc>j")
map("", "<leader>O", "O<C-\\><C-o>O", { desc = "which_key_ignore" })
map("", "<leader>o", leader_o, { expr = true, desc = "which_key_ignore" })
map("", "<leader>$", "$h", { desc = "which_key_ignore" })
map("", "<leader>L", "$h", { desc = "which_key_ignore" })
map("", "<leader>i", "i <C-g>U<Left>", { desc = "which_key_ignore" })
map("", "<leader>I", "I <C-g>U<Left>", { desc = "which_key_ignore" })
map("", "<leader>,", "i, <C-g>U<Left><C-g>U<Left>", { desc = "which_key_ignore" })
map("", "<leader>'", "i'', <C-g>U<Left><C-g>U<Left><C-g>U<Left>", { desc = "which_key_ignore" })
map("", '<leader>"', 'i"", <C-g>U<Left><C-g>U<Left><C-g>U<Left>', { desc = "which_key_ignore" })
map("", "<C-l>", "<cmd>nohlsearch<cr>")
map("", "zx", "ZQ", { desc = "which_key_ignore" })
map("", "zz", "ZZ", { desc = "which_key_ignore" })
map("", "Q", "gqq")
map("", "H", "^")
map("", "L", "$")
map("", "M", "%")
map("", "gh", "H", { desc = "which_key_ignore" })
map("", "gl", "L", { desc = "which_key_ignore" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Pase from system clipboard" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "v" }, "<leader>Y", '"+y$', { desc = "Copy until EOL to system clipboard" })

map("", "<leader>x", "<CMD>!chmod +x %<CR>", { desc = "Make executable" })

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

-- map("n", "<C-w>d", "<CMD>bwipeout<CR>")

-- calculate expression
map("i", "<M-=>", "<C-O>yiW<End>=<C-R>=<C-R>0<CR>")

map("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "which_key_ignore" })
map("v", "<leader>rs", [["hy:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "which_key_ignore" })

-- GIT
local gs = require("gitsigns")
map("n", "[g", function()
  gs.nav_hunk("prev")
end, { desc = "Prev Hunk" })
map("n", "]g", function()
  gs.nav_hunk("next")
end, { desc = "Next Hunk" })
map("n", "[G", function()
  gs.nav_hunk("first")
end, { desc = "First Hunk" })
map("n", "]G", function()
  gs.nav_hunk("last")
end, { desc = "Last Hunk" })

map("", "<leader>gl", function()
  gs.blame_line()
end, { desc = "Blame" })
map("", "<leader>gp", function()
  gs.preview_hunk()
end, { desc = "Preview Hunk" })
map("", "<leader>gr", function()
  gs.reset_hunk()
end, { desc = "Reset Hunk" })
map("", "<leader>gR", function()
  gs.reset_buffer()
end, { desc = "Reset Buffer" })
map("", "<leader>gs", function()
  gs.stage_hunk()
end, { desc = "Stage Hunk" })
map("", "<leader>gS", function()
  gs.stage_buffer()
end, { desc = "Stage Buffer" })
-- TODO: map("", "<leader>go", "<cmd>Telescope git_status<cr>", { desc = "Open changed file" })
map("", "<leader>gb", function()
  Snacks.picker.git_branches()
end, { desc = "Checkout branch" })
-- TODO: map("", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Checkout commit" })
map("", "<leader>gd", function()
  gs.diffthis()
end, { desc = "Diff" })

-- lsp

unmap("", "<leader>l")
map("", "<leader>la", function()
  vim.lsp.buf.code_action()
end, { desc = "Code Action" })
map("", "<leader>ld", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Document Diagnostics" })
map("", "<leader>lw", function()
  Snacks.picker.diagnostics()
end, { desc = "Workspace Diagnostics" })
map("", "<leader>li", "<cmd>LspInfo<cr>", { desc = "Info" })
map("", "<leader>lI", "<cmd>Mason<cr>", { desc = "Installer Info" })
map("", "<leader>ll", function()
  vim.lsp.codelens.run()
end, { desc = "CodeLens Action" })
map("", "<leader>lq", function()
  vim.diagnostic.setloclist()
end, { desc = "Quickfix" })
map("", "<leader>lr", function()
  vim.lsp.buf.rename()
end, { desc = "Rename" })
map("", "<leader>ls", function()
  Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter })
end, { desc = "Document Symbols" })

-- TODO: https://www.lazyvim.org/configuration/keymaps#lsp-server-keymaps
map("", "m", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch source/header" })

local function next_diag(severity, desc)
  vim.diagnostic.jump({ count = 1, float = true, border = "rounded", severity = severity, desc = desc })
end

local function prev_diag(severity, desc)
  vim.diagnostic.jump({ count = -1, float = true, border = "rounded", severity = severity, desc = desc })
end

local severity = vim.diagnostic.severity

map("n", "[t", function()
  prev_diag(severity.ERROR, "Prev Error")
end)
map("n", "]t", function()
  next_diag(severity.ERROR, "Next Error")
end)
map("n", "[s", function()
  prev_diag(severity.WARN, "Prev Warn")
end)
map("n", "]s", function()
  next_diag(severity.WARN, "Next Warn")
end)
map("n", "[r", function()
  vim.diagnostic.jump({ count = -1, float = true, border = "rounded" })
end, { desc = "Prev Diagnostic" })
map("n", "]r", function()
  vim.diagnostic.jump({ count = 1, float = true, border = "rounded" })
end, { desc = "Next Diagnostic" })
map("n", "<leader>n", vim.lsp.buf.hover, { desc = "Lsp Hover" })
map("n", "<M-space>", vim.lsp.buf.signature_help)
map("i", "<M-space>", vim.lsp.buf.signature_help)

map("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true, desc = "Treesitter Context" })
