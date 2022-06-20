local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

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
			filetypes = { "json", "markdown" },
		}),
		formatting.rustfmt.with({ extra_args = rust_edition }),
		formatting.shfmt,
		formatting.sqlformat,
		formatting.stylua,
		formatting.xmllint,
		formatting.latexindent,

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
	on_attach = require("user.lsp.handlers").formatting,
})
