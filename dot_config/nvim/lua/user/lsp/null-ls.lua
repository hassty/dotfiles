local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		formatting.black,
		formatting.clang_format.with({
			disabled_filetypes = { "c", "cpp" },
		}),
		formatting.cmake_format,
		formatting.goimports,
		formatting.prettierd.with({
			disabled_filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"html",
			},
		}),
		formatting.rustfmt,
		formatting.shellharden,
		formatting.sqlformat,
		formatting.stylua,
		formatting.xmllint,
		formatting.eslint_d.with({
			prefer_local = "node_modules/.bin",
		}),

		diagnostics.eslint_d.with({
			prefer_local = "node_modules/.bin",
		}),
		diagnostics.checkmake,
		diagnostics.golangci_lint,
		diagnostics.hadolint,
		diagnostics.shellcheck,
		diagnostics.tsc,

		code_actions.eslint_d.with({
			prefer_local = "node_modules/.bin",
		}),
	},

	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
