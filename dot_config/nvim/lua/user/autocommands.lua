local general_settings = vim.api.nvim_create_augroup("_general_settings", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
	group = general_settings,
	pattern = { "qf", "help", "man", "lspinfo" },
	callback = function()
		vim.keymap.set("", "q", ":close<CR>", { silent = true })
		vim.opt.buflisted = false
	end,
})

autocmd({ "BufRead", "BufReadPost" }, {
	group = general_settings,
	pattern = "*",
	callback = function()
		local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
		local buf_line_count = vim.api.nvim_buf_line_count(0)

		if row >= 1 and row <= buf_line_count then
			vim.api.nvim_win_set_cursor(0, { row, column + 1 })
			vim.cmd("norm! zz")
		end
	end,
})

autocmd("TextYankPost", {
	group = general_settings,
	pattern = "*",
	callback = function()
		require("vim.highlight").on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

autocmd("CursorMoved", {
	group = general_settings,
	pattern = "*",
	callback = function()
		vim.cmd([[
            highlight IlluminatedWordRead gui=none guibg=#1f2233
            highlight IlluminatedWordText gui=none guibg=#1f2233
            highlight IlluminatedWordWrite gui=none guibg=#1f2233
        ]])
	end,
})

autocmd("BufWinEnter", {
	group = general_settings,
	pattern = "*",
	command = "set formatoptions-=cro",
})

autocmd("FileType", {
	group = general_settings,
	pattern = "qf",
	callback = function()
		vim.opt.buflisted = false
	end,
})

autocmd({ "VimEnter", "VimResume" }, {
	group = general_settings,
	pattern = "*",
	callback = function()
		vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,"
			.. "a:blinkwait700-blinkoff400-blinkon0-Cursor/lCursor,"
			.. "sm:block-blinkwait175-blinkoff150-blinkon175"
	end,
})

autocmd({ "VimLeave,VimSuspend" }, {
	group = general_settings,
	pattern = "*",
	callback = function()
		vim.opt.guicursor = "a:hor20-blinkon215"
	end,
})

autocmd("BufWritePost", {
	group = general_settings,
	pattern = vim.fn.resolve(os.getenv("XDG_DATA_HOME") .. "/chezmoi/*"),
	command = 'silent !chezmoi apply --source-path "%"',
})

local auto_resize = vim.api.nvim_create_augroup("_auto_resize", { clear = true })
autocmd("VimResized", {
	group = auto_resize,
	pattern = "*",
	command = "wincmd =",
})

local statusline = vim.api.nvim_create_augroup("_status_line", { clear = true })
autocmd("FileType", {
	group = statusline,
	pattern = "alpha",
	callback = function()
		vim.opt.laststatus = 0
		vim.opt.ruler = false
	end,
})

autocmd("BufUnload", {
	group = statusline,
	pattern = "<buffer>",
	callback = function()
		vim.opt.laststatus = 3
		vim.opt.ruler = true
	end,
})
