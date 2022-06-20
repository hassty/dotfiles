local installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_status_ok then
	return
end

local servers = {
	"ansiblels",
	"bashls",
	"clangd",
	"cmake",
	"cssls",
	"dockerls",
	"elixirls",
	"gopls",
	"html",
	"jsonls",
	"lemminx",
	"omnisharp",
	"pyright",
	"rust_analyzer",
	"sumneko_lua",
	"taplo",
	"texlab",
	"tsserver",
	"vimls",
	"yamlls",
}

lsp_installer.setup({
	ensure_installed = servers,
	ui = {
		check_outdated_servers_on_open = true,
	},
	max_concurrent_installers = 4,
})

local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
	return
end

local capabilities = require("user.lsp.handlers").capabilities

for _, server in ipairs(lsp_installer.get_installed_servers()) do
	local settings = {}

	if server.name == "sumneko_lua" then
		local lua_settings = require("user.lsp.settings.sumneko_lua")
		settings = vim.tbl_deep_extend("force", lua_settings, settings)
	end

	if server.name == "clangd" then
		local clangd_capabilities = { offsetEncoding = { "utf-16" } }
		capabilities = vim.tbl_deep_extend("force", clangd_capabilities, capabilities)
	end

	if server.name == "jsonls" then
		local json_settings = require("user.lsp.settings.jsonls")
		settings = vim.tbl_deep_extend("force", json_settings, settings)
	end

	if server.name == "rust_analyzer" then
		local rust_tools_opts = require("user.lsp.settings.rust_tools")
		require("rust-tools").setup(rust_tools_opts)
		-- Initialize the LSP via rust-tools instead
		server:attach_buffers()
		-- Only if standalone support is needed
		require("rust-tools").start_standalone_if_required()
	else
		lspconfig[server.name].setup({
			settings = settings,
			capabilities = capabilities,
		})
	end
end
