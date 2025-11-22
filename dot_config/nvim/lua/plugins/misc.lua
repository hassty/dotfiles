return {
	{ "psliwka/vim-smoothie" },
	{
		"dstein64/nvim-scrollview",
		opts = {
			excluded_filetypes = { "netrw" },
			current_only = true,
			base = "right",
			column = 1,
		},
	},
	{ "jeffkreeftmeijer/vim-numbertoggle" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-abolish" },
	{
		"unblevable/quick-scope",
		keys = { "f", "F", "t", "T" },
		init = function()
			vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
			vim.g.qs_max_chars = 150
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		enabled = true,
		opts = {
			progress = {
				display = {
					done_icon = "",
				},
			},
			notification = {
				window = { winblend = 0 },
			},
		},
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = false,
		},
		keys = {
			{ "-", "<cmd>Oil<cr>" },
			{ "<leader>e", "<cmd>topleft 30 vsplit | Oil<cr>", desc = "Browse files" },
		},
		-- Optional dependencies
		dependencies = { "echasnovski/mini.icons" },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
		},
	},
	{ "RRethy/vim-illuminate", event = "LspAttach" },
	{ "powerman/ruscmd.nvim", opts = {} },
	{ "jannis-baum/vivify.vim", cmd = "Vivify" },
}
