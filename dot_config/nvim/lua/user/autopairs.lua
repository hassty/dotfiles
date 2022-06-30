local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

autopairs.setup({
	check_ts = true,
	ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
	map_cr = true,
	map_bs = true, -- map the <BS> key
	map_c_h = true, -- Map the <C-h> key to delete a pair
	map_c_w = true, -- map <c-w> to delete a pair if possible
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local ts_utils = require("nvim-treesitter.ts_utils")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
cmp.event:on("confirm_done", function(event)
	local node = ts_utils.get_node_at_cursor()
	if not node then
		return
	end
	local type = node:type()
	if
		type == "named_imports"
		or type == "use_list"
		or type == "meta_arguments"
		or type == "use_declaration"
		or type == "source_file"
	then
		return
	end
	cmp_autopairs.on_confirm_done()(event)
end)
