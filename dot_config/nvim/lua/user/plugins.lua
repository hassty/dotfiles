local fn = vim.fn

-- automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer, close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- autocommand that reloads neovim whenever you save the plugins.lua file
local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = packer_user_config,
	pattern = "plugins.lua",
	command = "source <afile>",
})

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

local util = require("packer.util")

-- have packer use a popup window
packer.init({
	snapshot = "just-works-tm",
	snapshot_path = util.join_paths(vim.fn.stdpath("config")),
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	-- autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("lukas-reineke/cmp-under-comparator")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- lsp
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("jose-elias-alvarez/null-ls.nvim")
	use("j-hui/fidget.nvim")
	use("ray-x/lsp_signature.nvim")
	use("b0o/schemastore.nvim")
	use("RRethy/vim-illuminate")

	-- rust
	use("simrat39/rust-tools.nvim")
	use("Saecki/crates.nvim")

	use("p00f/clangd_extensions.nvim")

	-- telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-telescope/telescope-ui-select.nvim")

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("windwp/nvim-ts-autotag")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("nvim-treesitter/nvim-treesitter-context")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- git
	use("lewis6991/gitsigns.nvim")

	use("tpope/vim-eunuch")

	-- db
	use("kristijanhusak/vim-dadbod-completion")
	use("tpope/vim-dadbod")
	use("kristijanhusak/vim-dadbod-ui")

	-- note taking
	use({ "lervag/vimtex", ft = { "tex" } })
	use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", ft = { "markdown" } })
	use({ "preservim/vim-markdown", ft = { "markdown" } })

	-- misc
	use("numToStr/Comment.nvim")
	use("lewis6991/impatient.nvim")
	use("folke/which-key.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("psliwka/vim-smoothie")
	use("dstein64/nvim-scrollview")
	use("unblevable/quick-scope")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-abolish")
	use("alker0/chezmoi.vim")
	use("jeffkreeftmeijer/vim-numbertoggle")

	-- colorschemes
	use("marko-cerovac/material.nvim")

	-- automatically set up your configuration after cloning packer.nvim
	-- put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
