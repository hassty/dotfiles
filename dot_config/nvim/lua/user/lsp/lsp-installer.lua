local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Automatically install LSP servers
local servers = {
	"ansiblels",
	"asm_lsp",
	"bashls",
	"clangd",
	"cmake",
	"cssls",
	"dockerls",
	"gopls",
	"graphql",
	"html",
	"intelephense",
	"jsonls",
	"lemminx",
	"omnisharp",
	"pyright",
	"rust_analyzer",
	"spectral",
	"sumneko_lua",
	"taplo",
	"texlab",
	"tsserver",
	"vimls",
	"yamlls",
}

local function install_missing()
	for _, name in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(name)
		if server_is_found and not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end
vim.api.nvim_create_user_command("LspInstallMissing", install_missing, {})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "tsserver" then
		local tsserver_opts = require("user.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	if server.name == "clangd" then
		local clangd_opts = require("user.lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
	end

	if server.name == "jsonls" then
		local jsonls_opts = require("user.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "rust_analyzer" then
		local rust_analyzer_opts = require("user.lsp.settings.rust_analyzer")
		opts = vim.tbl_deep_extend("force", rust_analyzer_opts, opts)

		require("rust-tools").setup({
			tools = require("user.lsp.settings.rust_tools"),

			-- The "server" property provided in rust-tools setup function are the
			-- settings rust-tools will provide to lspconfig during init.            --
			-- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
			-- with the user's own settings (opts).
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
		})
		-- Initialize the LSP via rust-tools instead
		server:attach_buffers()
		-- Only if standalone support is needed
		require("rust-tools").start_standalone_if_required()
	else
		-- This setup() function is exactly the same as lspconfig's setup function.
		-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		server:setup(opts)
	end
end)
