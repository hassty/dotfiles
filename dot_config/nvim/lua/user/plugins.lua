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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- have packer use a popup window
packer.init({
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
	use("hrsh7th/cmp-cmdline")
	use("lukas-reineke/cmp-under-comparator")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("tamago324/nlsp-settings.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("j-hui/fidget.nvim")
	use("ray-x/lsp_signature.nvim")
	use("b0o/schemastore.nvim")

	-- rust
	use("simrat39/rust-tools.nvim")
	use("Saecki/crates.nvim")

	-- debugging
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")

	-- telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("sudormrfbin/cheatsheet.nvim")
	use("nvim-telescope/telescope-packer.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("p00f/nvim-ts-rainbow")
	use("windwp/nvim-ts-autotag")

	-- statusline
	use("nvim-lualine/lualine.nvim")
	use("SmiteshP/nvim-gps")

	-- git
	use("lewis6991/gitsigns.nvim")

	-- nvim-tree
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")

	-- zen-mode
	use({ "folke/twilight.nvim", cmd = "Twilight" })
	use({ "folke/zen-mode.nvim", cmd = "ZenMode" })

	-- db
	use({ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "plsql" } })
	use({ "tpope/vim-dadbod", ft = { "sql", "plsql" } })
	use({ "kristijanhusak/vim-dadbod-ui", ft = { "sql", "plsql" } })

	-- note taking
	use({ "lervag/vimtex", ft = { "tex" } })
	use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", ft = { "markdown" } })
	use({ "preservim/vim-markdown", ft = { "markdown" } })

	-- misc
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use("voldikss/vim-floaterm")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")
	use({ "AndrewRadev/switch.vim", cmd = { "Switch" }, keys = { "gs" } })
	use("norcalli/nvim-colorizer.lua")
	use("psliwka/vim-smoothie")
	use("rcarriga/nvim-notify")
	use("dstein64/nvim-scrollview")
	use("sunjon/shade.nvim")
	use({ "unblevable/quick-scope", keys = { "f", "F", "t", "T" } })
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-abolish")
	use("alker0/chezmoi.vim")
	use("zhimsel/vim-stay")
	use("jeffkreeftmeijer/vim-numbertoggle")
	use("takac/vim-hardtime")
	use("stevearc/dressing.nvim")

	-- colorschemes
	use("lunarvim/darkplus.nvim")
	use("marko-cerovac/material.nvim")
	use("shaunsingh/nord.nvim")
	use("cocopon/iceberg.vim")

	-- automatically set up your configuration after cloning packer.nvim
	-- put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
