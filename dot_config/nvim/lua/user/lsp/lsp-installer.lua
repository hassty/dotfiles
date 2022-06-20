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
local formatting = require("user.lsp.handlers").formatting

for _, server in ipairs(lsp_installer.get_installed_servers()) do
	local settings = {}
	local on_attach = function(client, bufnr)
		if client.name == "omnisharp" then
			formatting(client, bufnr)
		end

		local illuminate_status_ok, illuminate = pcall(require, "illuminate")
		if not illuminate_status_ok then
			return
		end
		illuminate.on_attach(client)
	end

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
		local opts = {
			tools = rust_tools_opts,
			-- all the opts to send to nvim-lspconfig
			-- these override the defaults set by rust-tools.nvim
			-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
			server = {
				-- standalone file support
				-- setting it to false may improve startup time
				standalone = true,
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					-- to enable rust-analyzer settings visit:
					-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
					["rust-analyzer"] = {
						-- enable clippy on save
						checkOnSave = {
							command = "clippy",
						},
						diagnostics = {
							disabled = { "unresolved-macro-call" },
						},
					},
				},
			}, -- rust-analyer options

			-- debugging stuff
			dap = {
				adapter = {
					type = "executable",
					command = "lldb-vscode",
					name = "rt_lldb",
				},
			},
		}
		require("rust-tools").setup(opts)
		-- Initialize the LSP via rust-tools instead
		server:attach_buffers()
		-- Only if standalone support is needed
		require("rust-tools").start_standalone_if_required()
	else
		lspconfig[server.name].setup({
			settings = settings,
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end
end
