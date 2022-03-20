local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/repos/vscode-node-debug2/out/src/nodeDebug.js" },
}
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

dap.adapters.coreclr = {
	type = "executable",
	command = "/usr/bin/netcoredbg",
	args = { "--interpreter=vscode" },
}

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
