local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
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
		bufnr = bufnr,
	})
end

local highlight_augroup = vim.api.nvim_create_augroup("LspHighlight", { clear = true })
local function lsp_highlight_document(client)
	if client.supports_method("textDocument/documentHighlight") then
		vim.api.nvim_create_autocmd("CursorHold", {
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
	})
end

M.on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", function()
			lsp_formatting(bufnr)
		end, {})
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			command = "LspFormat",
		})
	end

	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
