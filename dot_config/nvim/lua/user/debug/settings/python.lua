local M = {}

local function setup_adapter(dap)
	dap.adapters.python = {
		type = "executable",
		command = os.getenv("HOME") .. "/.local/share/environments/debugpy/bin/python",
		args = { "-m", "debugpy.adapter" },
	}
end

local function setup_configuration(dap)
	dap.configurations.python = {
		{
			-- The first three options are required by nvim-dap
			name = "Launch file",
			request = "launch",
			type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`

			-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = function()
				-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
				-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
				-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				else
					return "/usr/bin/python"
				end
			end,
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
