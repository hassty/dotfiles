local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		if str == "NORMAL" then
			return ""
		end
		return str
	end,
}

local encoding = {
	"encoding",
	fmt = function(str)
		if str == "utf-8" then
			return ""
		end
		return str
	end,
}

local filename = {
	"filename",
	file_status = true, -- Displays file status (readonly status, modified status)
	path = 1, -- 0: Just the filename
	-- 1: Relative path
	-- 2: Absolute path

	shorting_target = 40, -- Shortens path to leave 40 spaces in the window
	symbols = {
		modified = "", -- Text to show when the file is modified.
		readonly = " -", -- Text to show when the file is non-modifiable or readonly.
		unnamed = "[No Name]", -- Text to show for unnamed buffers.
	},
}

local fileformat = {
	"fileformat",
	fmt = function(str)
		if str == "" then
			return ""
		end
		return str
	end,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
	cond = hide_in_width,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
	fmt = function(str)
		if str == "master" then
			return ""
		end
	end,
}

local location = {
	"location",
	padding = 0,
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "netrw", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, diagnostics },
		lualine_b = { filename },
		lualine_x = { diff },
		lualine_y = { encoding, fileformat, filetype },
		lualine_z = { location, "%-3L%<" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
