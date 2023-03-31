local status_ok, scrollview = pcall(require, "scrollview")
if not status_ok then
	return
end

scrollview.setup({
	excluded_filetypes = { "NvimTree", "alpha" },
	current_only = true,
	winblend = 10,
	base = "right",
	column = 2,
})
