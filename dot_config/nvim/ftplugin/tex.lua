vim.g.vimtex_imaps_enabled = 0
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_complete_enabled = 0

vim.keymap.set("", "M", "<Plug>(vimtex-%)")
vim.keymap.set("", "]]", "<Plug>(vimtex-]])")
vim.keymap.set("", "[[", "<Plug>(vimtex-[[)")

vim.keymap.set({ "o", "x" }, "am", "<Plug>(vimtex-a$)")
vim.keymap.set({ "o", "x" }, "im", "<Plug>(vimtex-i$)")
vim.keymap.set("", "tsm", "<Plug>(vimtex-env-toggle-math)")

vim.keymap.set({ "o", "x" }, "ai", "<Plug>(vimtex-am)")
vim.keymap.set({ "o", "x" }, "ii", "<Plug>(vimtex-im)")

vim.keymap.set("", "<leader>v", "<Plug>(vimtex-view)")
vim.keymap.set("n", "<leader><space>", "<Plug>(vimtex-compile)")
