local M = {}

local function setup_adapter(dap)
	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/repos/vscode-node-debug2/out/src/nodeDebug.js" },
	}
end

local function setup_configuration(dap)
	dap.configurations.javascript = {
		{
			name = "Launch",
			type = "node2",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			name = "Attach to process",
			type = "node2",
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
