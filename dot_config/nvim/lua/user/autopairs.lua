local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

npairs.setup({
	check_ts = true,
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
	local name = ts_utils.get_node_at_cursor():type()
	if name == "named_imports" or name == "use_list" or name == "meta_arguments" then
		return
	end
	cmp_autopairs.on_confirm_done()(event)
end)
