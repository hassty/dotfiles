local map = vim.keymap.set

-- map("i", "<CR>", function()
--     TODO: vim.fn.pumvisible
--     local visible = vim.api.nvim_exec2("echo pumvisible()", { output = true })
--     if visible.output == "1" then
--         return "<C-e><CR>"
--     else
--         return "<CR>"
--     end
-- end, { expr = true })

-- map("", "<leader>O", "O<C-\\><C-o>O")
map("", "<leader>O", "[<space>kO", { remap = true })
map("", "<leader>o", function()
	return vim.api.nvim_get_current_line() == "" and "]<space>jO" or "]<space>jo"
end, { expr = true, remap = true })
map("", "<leader>$", "$h")
map("", "<leader>i", "i <C-g>U<Left>")
map("", "<leader>I", "I <C-g>U<Left>")
map("", "<leader>,", "i, <C-g>U<Left><C-g>U<Left>")
map("", "<leader>'", "i'', <C-g>U<Left><C-g>U<Left><C-g>U<Left>")
map("", '<leader>"', 'i"", <C-g>U<Left><C-g>U<Left><C-g>U<Left>')

map("", "<leader>w", "<cmd>silent write!<cr>", { desc = "Save" })
map("", "<leader>W", "<cmd>silent wall!<cr>", { desc = "Save All" })
-- map("", "<leader>e", "<cmd>Lexplore<cr>", { desc = "Explorer" })
map("", "<leader><Tab>", "<C-^>", { desc = "Alternate file" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
map({ "n", "v" }, "<leader>Y", '"+y$', { desc = "Copy to clipboard (until line end)" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("", "<leader>dy", "<cmd>let @+=expand('%:t').':'.line('.')<cr>", { desc = "Copy current position" })

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

map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map("i", "<C-f>", "<Right>")
map("i", "<C-b>", "<Left>")

map("i", "<C-l>", "<C-x><C-l>")

map("i", "<M-;>", "<Esc>A;<CR>")
map("i", "<M-,>", "<Esc>A,<CR>")
map("i", "<M-.>", "<Esc>A.<CR>")
map("i", "<M-CR>", "<Esc>o")

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

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- calculate expression
map("i", "<M-=>", "<C-O>yiW<End>=<C-R>=<C-R>0<CR>")
map("v", "<M-=>", 's<C-R>=<C-R>"<CR><ESC>')

map("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace selected text" })
map("v", "<leader>rs", [["hy:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace selected text" })
