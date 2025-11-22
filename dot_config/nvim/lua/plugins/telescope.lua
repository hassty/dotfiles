return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local lga_actions = require("telescope-live-grep-args.actions")

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.95,
						height = 0.95,
						horizontal = {
							preview_cutoff = 100,
							preview_width = 50,
						},
					},
					preview = {
						treesitter = true,
					},
				},
				pickers = {
					find_files = {
						-- theme = "ivy",
					},
				},
				extensions = {
					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
					live_grep_args = {
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								-- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								-- freeze the current list and start a fuzzy search in the frozen list
								["<C-space>"] = lga_actions.to_fuzzy_refine,
							},
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
			telescope.load_extension("live_grep_args")
		end,
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{
				"<leader>F",
				function()
					require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
				end,
				desc = "Find files (cwd)",
			},
			{
				"<leader>st",
				function()
					require("telescope").extensions.live_grep_args.live_grep_args()
				end,
				desc = "Search text",
			},
			{
				"<leader>sw",
				function()
					require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
				end,
				desc = "Search word",
			},
			{
				"<leader>sw",
				function()
					require("telescope-live-grep-args.shortcuts").grep_visual_selection()
				end,
				mode = "v",
				desc = "Search selection",
			},
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
			{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Search recent files" },
			{ "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Search projects" },
			{ "<leader>so", "<cmd>Telescope buffers<cr>", desc = "Search open buffers" },
			{
				"<leader>s/",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Search current buffer",
			},
			{ "<leader>sv", "<cmd>Telescope vim_options<cr>", desc = "Search vim options" },
			{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Lsp diagnostics" },
			{ "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Git modified files" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
			{ "grr", "<cmd>Telescope lsp_references<cr>", desc = "Lsp references" },
			{ "gO", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Lsp document symbols" },
			{ "<leader>li", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Lsp incoming calls" },
			{ "<leader>lo", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Lsp outgoing calls" },
		},
	},
}
