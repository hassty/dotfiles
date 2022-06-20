local augroup = vim.api.nvim_create_augroup("dbui", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup,
	pattern = "*.dbout",
	command = "set filetype=dbout",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	nested = true,
	pattern = "*.dbout",
	callback = function()
		vim.cmd("call db_ui#save_dbout(expand('<afile>'))")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "*.dbout",
	command = "",
})
