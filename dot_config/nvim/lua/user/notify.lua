local status_ok, notify = pcall(require, "notify")
if not status_ok then
	return
end

vim.notify = notify

notify.setup({
	-- Animation style (see below for details)
	stages = "slide",

	-- Function called when a new window is opened, use for changing win settings/config
	on_open = nil,

	-- Function called when a window is closed
	on_close = nil,

	-- Render function for notifications. See notify-render()
	render = "minimal",

	-- Default timeout for notifications
	timeout = 200,

	-- For stages that change opacity this is treated as the highlight behind the window
	-- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
	background_colour = "#000000",

	-- Minimum width for notification windows
	minimum_width = 20,

	-- Icons for the different levels
	icons = {
		ERROR = "",
		WARN = "",
		INFO = "",
		DEBUG = "",
		TRACE = "✎",
	},
})
