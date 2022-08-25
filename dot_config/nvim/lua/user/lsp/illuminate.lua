vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }
vim.keymap.set("", "<leader>*", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
vim.keymap.set("", "<leader>#", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')
