local colorscheme_status_ok, colorscheme = pcall(require, "nord")
if not colorscheme_status_ok then
	return
end

-- Example config in lua
vim.g.nord_contrast = false
vim.g.nord_borders = false
vim.g.nord_disable_background = true
vim.g.nord_italic = false

-- Load the colorscheme
require("nord").set()

local colorbuddy_status_ok, colorbuddy = pcall(require, "colorbuddy")
if not colorbuddy_status_ok then
	vim.cmd([[colorscheme nord]])
	return
end

colorbuddy.colorscheme("nord")

vim.cmd([[
highlight Normal ctermbg=None guibg=None
highlight NormalFloat ctermbg=None guibg=None
highlight FloatBorder ctermbg=None guibg=None
highlight WhichKeyFloat ctermbg=None guibg=None
highlight Conceal ctermbg=None guibg=None
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
