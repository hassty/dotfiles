local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

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
			disabled_filetypes = { "html" },
		}),
		formatting.rustfmt,
		formatting.shellharden,
		formatting.sqlformat,
		formatting.stylua,
		formatting.xmllint,

		diagnostics.checkmake,
		diagnostics.golangci_lint,
		diagnostics.hadolint,
		diagnostics.shellcheck,
		diagnostics.tsc,
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
