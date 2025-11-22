return {
	{
		"nvim-treesitter/nvim-treesitter",
		enable = false,
		version = false,
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = false,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ia"] = "@parameter.inner",
							["aa"] = "@parameter.outer",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						include_surrounding_whitespace = false,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							["]o"] = "@loop.*",
							["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						goto_next = {
							["]i"] = "@conditional.outer",
						},
						goto_previous = {
							["[i"] = "@conditional.outer",
						},
					},
				},
			})
		end,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				keys = {
					{ "<leader>lc", "<cmd>TSContext toggle<CR>", desc = "Toggle ts context" },
				},
			},
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
	},
}
