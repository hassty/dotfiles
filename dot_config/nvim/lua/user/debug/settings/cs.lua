local M = {}

local function setup_adapter(dap)
	dap.adapters.coreclr = {
		type = "executable",
		command = "/usr/bin/netcoredbg",
		args = { "--interpreter=vscode" },
	}
end

local function setup_configuration(dap)
	dap.configurations.cs = {
		{
			name = "Launch",
			type = "coreclr",
			request = "launch",
			program = function()
				return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
			end,
		},
		{
			name = "Attach to process",
			type = "coreclr",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
	}
end

local function load_module(module_name)
	local status_ok, module = pcall(require, module_name)
	if not status_ok then
		return nil
	end
	return module
end

function M.setup()
	local dap = load_module("dap")
	setup_adapter(dap)
	setup_configuration(dap)
end

return M
