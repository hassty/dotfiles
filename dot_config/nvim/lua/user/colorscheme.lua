local material_status_ok, material = pcall(require, "material")
if not material_status_ok then
	return
end

material.setup({
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
		comments = false, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false, -- Enable italic variables
	},

	contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
		"terminal", -- Darker terminal background
		"packer", -- Darker packer background
		"qf", -- Darker qf list background
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false, -- Enable higher contrast text for darker style
	},

	disable = {
		borders = true, -- Disable borders between verticaly split windows
		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = true, -- Prevent the theme from setting terminal colors
		eob_lines = false, -- Hide the end-of-buffer lines
	},

	custom_highlights = {}, -- Overwrite highlights with your own
})

vim.g.material_style = "deep ocean"
local colorbuddy_status_ok, colorbuddy = pcall(require, "colorbuddy")
if not colorbuddy_status_ok then
	vim.cmd([[colorscheme material]])
	return
end

colorbuddy.colorscheme("material")

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
