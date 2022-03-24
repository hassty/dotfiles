local M = {}

local function setup_adapter(dap)
	dap.adapters.go = function(callback, config)
		local stdout = vim.loop.new_pipe(false)
		local handle
		local pid_or_err
		local port = 38697
		local opts = {
			stdio = { nil, stdout },
			args = { "dap", "-l", "127.0.0.1:" .. port },
			detached = true,
		}
		handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
			stdout:close()
			handle:close()
			if code ~= 0 then
				print("dlv exited with code", code)
			end
		end)
		assert(handle, "Error running dlv: " .. tostring(pid_or_err))
		stdout:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				vim.schedule(function()
					require("dap.repl").append(chunk)
				end)
			end
		end)
		-- Wait for delve to start
		vim.defer_fn(function()
			callback({ type = "server", host = "127.0.0.1", port = port })
		end, 100)
	end
end

local function setup_configuration(dap)
	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			name = "Launch",
			type = "go",
			request = "launch",
			program = "${file}",
		},
		{
			name = "Launch with args",
			type = "go",
			request = "launch",
			program = "${file}",
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " +")
			end,
		},
		{
			name = "Attach to process",
			type = "go",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
		{
			name = "Debug test", -- configuration for debugging test files
			type = "go",
			request = "launch",
			mode = "test",
			program = "${file}",
		},
		-- works with go.mod packages and sub packages
		{
			name = "Debug test (go.mod)",
			type = "go",
			request = "launch",
			mode = "test",
			program = "./${relativeFileDirname}",
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
