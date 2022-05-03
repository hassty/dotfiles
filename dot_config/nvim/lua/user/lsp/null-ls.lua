local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function()
	vim.lsp.buf.format({
		filter = function(clients)
			-- filter out clients that you don't want to use
			return vim.tbl_filter(function(client)
				if
					client.name == "tsserver"
					or client.name == "gopls"
					or client.name == "rust_analyzer"
					or client.name == "sumneko_lua"
					or client.name == "clangd"
					or client.name == "sqls"
					or client.name == "lemminx"
					or client.name == "jsonls"
					or client.name == "csharp_ls"
				then
					return false
				else
					return true
				end
			end, clients)
		end,
	})
end

local function has_eslint_config(utils)
	return utils.root_has_file({ ".eslintrc.json" })
end

local function rust_edition(params)
	local Path = require("plenary.path")
	local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

	if cargo_toml:exists() and cargo_toml:is_file() then
		for _, line in ipairs(cargo_toml:readlines()) do
			local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
			if edition then
				return { "--edition=" .. edition }
			end
		end
	end
	-- default edition when we don't find `Cargo.toml` or the `edition` in it.
	return { "--edition=2021" }
end

null_ls.setup({
	debug = false,
	sources = {
		formatting.black,
		formatting.clang_format.with({ disabled_filetypes = { "cs" } }),
		formatting.cmake_format,
		formatting.eslint_d.with({
			condition = has_eslint_config,
			prefer_local = "node_modules/.bin",
		}),
		formatting.goimports,
		formatting.prettierd.with({
			condition = function(utils)
				return not has_eslint_config(utils)
			end,
			filetypes = formatting.eslint_d.filetypes,
		}),
		formatting.prettierd.with({
			filetypes = { "json" },
		}),
		formatting.rustfmt.with({ extra_args = rust_edition }),
		formatting.shfmt,
		formatting.sqlformat,
		formatting.stylua,
		formatting.xmllint,

		diagnostics.checkmake,
		diagnostics.eslint_d.with({
			condition = has_eslint_config,
			prefer_local = "node_modules/.bin",
		}),
		diagnostics.golangci_lint,
		diagnostics.hadolint,
		diagnostics.shellcheck,
		diagnostics.tsc,

		code_actions.eslint_d.with({
			condition = has_eslint_config,
			prefer_local = "node_modules/.bin",
		}),
	},

	on_attach = function(client)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_user_command("LspFormat", lsp_formatting, {})
			vim.api.nvim_clear_autocmds({ group = augroup })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				command = "LspFormat",
			})
		end
	end,
})
