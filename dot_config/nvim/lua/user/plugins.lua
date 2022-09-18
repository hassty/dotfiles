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

	-- debugging
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/cmp-dap")

	-- telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-telescope/telescope-packer.nvim")

	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("p00f/nvim-ts-rainbow")
	use("windwp/nvim-ts-autotag")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- statusline
	use("nvim-lualine/lualine.nvim")
	use("SmiteshP/nvim-gps")

	-- git
	use("lewis6991/gitsigns.nvim")

	-- nvim-tree
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")

	-- db
	use("kristijanhusak/vim-dadbod-completion")
	use("tpope/vim-dadbod")
	use("kristijanhusak/vim-dadbod-ui")

	-- note taking
	use({ "lervag/vimtex", ft = { "tex" } })
	use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", ft = { "markdown" } })
	use({ "preservim/vim-markdown", ft = { "markdown" } })

	-- misc
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("folke/which-key.nvim")
	use({ "AndrewRadev/switch.vim", cmd = { "Switch" }, keys = { "gs" } })
	use("norcalli/nvim-colorizer.lua")
	use("psliwka/vim-smoothie")
	use("rcarriga/nvim-notify")
	use("dstein64/nvim-scrollview")
	use("unblevable/quick-scope")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-abolish")
	use("alker0/chezmoi.vim")
	use("jeffkreeftmeijer/vim-numbertoggle")
	use("takac/vim-hardtime")
	use("stevearc/dressing.nvim")

	-- colorschemes
	use("marko-cerovac/material.nvim")

	-- automatically set up your configuration after cloning packer.nvim
	-- put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
