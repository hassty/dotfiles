vim.keymap.set("", "<leader>dd", ":DBUIToggle<CR>")
vim.keymap.set("", "<leader>df", ":DBUIFindBuffer<CR>")

vim.g.db_ui_show_help = 0
vim.g.db_ui_winwidth = 25
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_save_location = "~/development/sql/"
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_auto_execute_table_helpers = 1

local augroup = vim.api.nvim_create_augroup("DBConnected", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		vim.keymap.set("", "<leader><space>", "<Plug>(DBUI_ExecuteQuery)")
		require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
	end,
})
