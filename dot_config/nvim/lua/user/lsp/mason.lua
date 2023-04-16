require("mason").setup({
	ui = {
		check_outdated_packages_on_open = true,
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "none",

		icons = {
			package_installed = "",
			package_pending = "",
			package_uninstalled = "",
		},

		keymaps = {
			toggle_package_expand = "<CR>",
			install_package = "i",
			update_package = "u",
			check_package_version = "c",
			update_all_packages = "U",
			check_outdated_packages = "C",
			uninstall_package = "X",
			cancel_installation = "<C-c>",
			apply_language_filter = "<C-f>",
		},
	},
	--[[ install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }), ]]

	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
	github = {
		-- The template URL to use when downloading assets from GitHub.
		-- The placeholders are the following (in order):
		-- 1. The repository (e.g. "rust-lang/rust-analyzer")
		-- 2. The release version (e.g. "v0.3.0")
		-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
		download_url_template = "https://github.com/%s/releases/download/%s/%s",
	},
})
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")

local capabilities = require("user.lsp.handlers").capabilities

require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,
	-- Next, you can provide targeted overrides for specific servers.
	["rust_analyzer"] = function()
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
		-- TODO: rust settings
	end,
	["clangd"] = function()
		capabilities = { offsetEncoding = { "utf-16" } }
		lspconfig.clangd.setup({
			capabilities = capabilities,
		})
	end,
	["jsonls"] = function()
		local settings = require("user.lsp.settings.jsonls")
		-- TODO: fix schemastore
		lspconfig.jsonls.setup({
			settings = settings,
		})
	end,
	["lua_ls"] = function()
		local settings = require("user.lsp.settings.lua_ls")
		lspconfig.lua_ls.setup({
			settings = settings,
		})
	end,
})
