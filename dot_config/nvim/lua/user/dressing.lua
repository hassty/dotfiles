local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
	return
end

dressing.setup({
	input = {
		-- Set to false to disable the vim.ui.input implementation
		enabled = true,

		-- Default prompt string
		default_prompt = "➤ ",

		-- When true, <Esc> will close the modal
		insert_only = false,

		-- These are passed to nvim_open_win
		anchor = "SW",
		relative = "cursor",
		border = "rounded",

		-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		prefer_width = 40,
		width = nil,
		max_width = nil,
		min_width = 20,

		win_options = {
			-- Window transparency (0-100)
			winblend = 0,
			-- Disable line wrapping
			wrap = false,
		},

		-- Set to `false` to disable
		mappings = {
			n = {
				["<Esc>"] = "Close",
				["<CR>"] = "Confirm",
			},
			i = {
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
				["<C-p>"] = "HistoryPrev",
				["<C-n>"] = "HistoryNext",
			},
		},

		-- see :help dressing_get_config
		get_config = nil,
	},
	select = {
		-- Set to false to disable the vim.ui.select implementation
		enabled = true,

		-- Priority list of preferred vim.select implementations
		backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

		-- Trim trailing `:` from prompt
		trim_prompt = true,

		-- Options for telescope selector
		-- These are passed into the telescope picker directly. Can be used like:
		-- telescope = require('telescope.themes').get_ivy({...})
		telescope = require("telescope.themes").get_dropdown({}),

		-- Options for fzf selector
		fzf = {
			window = {
				width = 0.5,
				height = 0.4,
			},
		},

		-- Options for fzf_lua selector
		fzf_lua = {
			winopts = {
				width = 0.5,
				height = 0.4,
			},
		},

		-- Options for nui Menu
		nui = {
			position = "50%",
			size = nil,
			relative = "editor",
			border = {
				style = "rounded",
			},
			max_width = 80,
			max_height = 40,
		},

		-- Options for built-in selector
		builtin = {
			-- These are passed to nvim_open_win
			anchor = "NW",
			relative = "cursor",
			border = "rounded",

			win_options = {
				-- Window transparency (0-100)
				winblend = 0,
			},

			-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			width = nil,
			max_width = 0.8,
			min_width = 40,
			height = nil,
			max_height = 0.9,
			min_height = 10,
		},

		-- Used to override format_item. See :help dressing-format
		format_item_override = {},

		-- see :help dressing_get_config
		get_config = nil,
	},
})
