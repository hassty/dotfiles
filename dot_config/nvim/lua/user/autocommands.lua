local general_settings = vim.api.nvim_create_augroup("_general_settings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = general_settings,
	pattern = { "qf", "help", "man", "lspinfo" },
	callback = function()
		vim.keymap.set("", "q", ":close<CR>", { silent = true })
		vim.opt.buflisted = false
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = general_settings,
	pattern = "*",
	callback = function()
		require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = general_settings,
	pattern = "*",
	command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("FileType", {
	group = general_settings,
	pattern = "qf",
	callback = function()
		vim.opt.buflisted = false
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
	group = general_settings,
	pattern = "*",
	callback = function()
		vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,"
			.. "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
			.. "sm:block-blinkwait175-blinkoff150-blinkon175"
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave,VimSuspend" }, {
	group = general_settings,
	pattern = "*",
	callback = function()
		vim.opt.guicursor = "a:hor20-blinkon215"
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = general_settings,
	pattern = vim.fn.resolve(os.getenv("XDG_DATA_HOME") .. "/chezmoi/*"),
	command = 'silent !chezmoi apply --source-path "%"',
})

local auto_resize = vim.api.nvim_create_augroup("_auto_resize", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
	group = auto_resize,
	pattern = "*",
	command = "wincmd =",
})

local statusline = vim.api.nvim_create_augroup("_status_line", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = statusline,
	pattern = "alpha",
	callback = function()
		vim.opt.laststatus = 0
		vim.opt.ruler = false
	end,
})

vim.api.nvim_create_autocmd("BufUnload", {
	group = statusline,
	pattern = "<buffer>",
	callback = function()
		vim.opt.laststatus = 3
		vim.opt.ruler = true
	end,
})
