local install_status_ok, dap_install = pcall(require, "dap-install")
if not install_status_ok then
	return
end

-- configure every installed debugger
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end
