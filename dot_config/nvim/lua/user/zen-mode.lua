local zen_status_ok, zen_mode = pcall(require, "zen-mode")
if not zen_status_ok then
	return
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

zen_mode.setup({
	window = {
		backdrop = 0.85, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
		-- height and width can be:
		-- * an absolute number of cells when > 1
		-- * a percentage of the width / height of the editor when <= 1
		-- * a function that returns the width or the height
		width = 80, -- width of the Zen window
		height = 1, -- height of the Zen window
		-- by default, no options are changed for the Zen window
		-- uncomment any of the options below, or add other vim.wo options you want to apply
		options = {
			signcolumn = "no", -- disable signcolumn
			number = false, -- disable number column
			relativenumber = false, -- disable relative numbers
			cursorline = false, -- disable cursorline
			cursorcolumn = false, -- disable cursor column
			foldcolumn = "0", -- disable fold column
			list = false, -- disable whitespace characters
		},
	},
	plugins = {
		-- disable some global vim options (vim.o...)
		-- comment the lines to not apply the options
		options = {
			enabled = true,
			ruler = false, -- disables the ruler text in the cmd line area
			showcmd = false, -- disables the command in the last line of the screen
		},
		twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
		gitsigns = { enabled = false }, -- disables git signs
		tmux = { enabled = true }, -- disables the tmux statusline
	},
	-- callback where you can add custom code when the Zen window opens
	on_open = function(win)
		vim.opt.scrolloff = 999
		vim.cmd("ScrollViewDisable")
		vim.cmd("set guicursor+=a:blinkon0")
		keymap("n", "n", "j", opts)
		keymap("n", "e", "k", opts)
		keymap("n", "i", "l", opts)
		keymap("x", "n", "j", opts)
		keymap("x", "e", "k", opts)
		keymap("x", "i", "l", opts)
		keymap("n", "N", "<C-d>", { noremap = false, silent = true })
		keymap("n", "E", "<C-u>", { noremap = false, silent = true })
		keymap("n", "d", "<C-d>", { noremap = false, silent = true })
		keymap("n", "u", "<C-u>", { noremap = false, silent = true })
	end,
	-- callback where you can add custom code when the Zen window closes
	on_close = function()
		vim.opt.scrolloff = 1
		vim.cmd("ScrollViewEnable")
		vim.cmd("set guicursor-=a:blinkon0")
		keymap("n", "n", "n", opts)
		keymap("n", "e", "e", opts)
		keymap("n", "i", "i", opts)
		keymap("x", "n", "n", opts)
		keymap("x", "e", "e", opts)
		keymap("x", "i", "i", opts)
		keymap("n", "N", "N", opts)
		keymap("n", "E", "E", opts)
		keymap("n", "u", "u", opts)
		keymap("n", "d", "d", opts)
	end,
})

local twilight_status_ok, twilight = pcall(require, "twilight")
if not twilight_status_ok then
	return
end

twilight.setup({
	dimming = {
		alpha = 0.3, -- amount of dimming
		-- we try to get the foreground from the highlight groups or fallback color
		color = { "Normal", "#ffffff" },
		inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
	},
	context = 10, -- amount of lines we will try to show around the current line
	treesitter = true, -- use treesitter when available for the filetype
	-- treesitter is used to automatically expand the visible text,
	-- but you can further control the types of nodes that should always be fully expanded
	expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
		"function",
		"method",
		"table",
		"if_statement",
	},
	exclude = {}, -- exclude these filetypes
})
