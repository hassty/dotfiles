require("material").setup({

	contrast = {
		sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = false, -- Enable contrast for floating windows
		line_numbers = false, -- Enable contrast background for line numbers
		sign_column = false, -- Enable contrast background for the sign column
		cursor_line = false, -- Enable darker background for the cursor line
		non_current_windows = false, -- Enable darker background for non-current windows
		popup_menu = false, -- Enable lighter background for the popup menu
	},

	italics = {
		comments = true, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false, -- Enable italic variables
	},

	contrast_filetypes = {},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = true, -- Enable higher contrast text for darker style
	},

	disable = {
		colored_cursor = false, -- Disable the colored cursor
		borders = false, -- Disable borders between verticaly split windows
		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false, -- Hide the end-of-buffer lines
	},

	lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

	custom_highlights = {}, -- Overwrite highlights with your own
})

-- Load the colorscheme
-- colorscheme.set()
vim.g.material_style = "deep ocean"
vim.cmd([[colorscheme material]])

vim.cmd([[
" highlight Normal ctermbg=None guibg=None
" highlight NormalFloat ctermbg=None guibg=None
" highlight Pmenu ctermbg=None guibg=None
" highlight FloatBorder ctermbg=None guibg=None
" highlight WhichKeyFloat ctermbg=None guibg=None
" highlight Conceal ctermbg=None guibg=None
]])

local colorizer_status_ok, colorizer = pcall(require, "colorizer")
if not colorizer_status_ok then
	return
end
colorizer.setup()

-- require("shade").setup({
-- 	overlay_opacity = 50,
-- 	opacity_step = 1,
-- 	keys = {
-- 		brightness_up = "<C-Up>",
-- 		brightness_down = "<C-Down>",
-- 		toggle = "<Leader>s",
-- 	},
-- })
