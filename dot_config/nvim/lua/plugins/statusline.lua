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

local encoding = {
	"encoding",
	fmt = function(str)
		if str == "utf-8" then
			return ""
		end
		return str
	end,
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

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
	cond = hide_in_width,
}

local location = {
	"location",
	padding = 0,
}

return {
	"nvim-lualine/lualine.nvim",
	opts = {
		sections = {
			lualine_a = { "root_dir" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"diagnostics",
				},
				filename,
			},
			lualine_x = { "diff", encoding },
			lualine_y = { fileformat, filetype },
			lualine_z = { location, "%-3L%<" },
		},
	},
}
