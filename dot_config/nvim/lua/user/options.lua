vim.cmd([[
syntax on
filetype plugin indent on
]])

local options = {
	clipboard = "unnamedplus",
	exrc = true,
	fileencodings = { "usc-bom", "utf-8", "default", "cp1251", "latin1" },
	fileformat = "unix",
	ignorecase = true,
	laststatus = 2,
	lazyredraw = true,
	linebreak = true,
	mouse = "a",
	number = true,
	pumblend = 10,
	pumheight = 10,
	relativenumber = true,
	scrolloff = 1,
	sidescrolloff = 5,
	expandtab = true,
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	smartindent = true,
	smarttab = true,
	showmode = false,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 500,
	undofile = true,
	updatetime = 50,
	wildignore = { "*.a", "*.o", "*.so", "*.pyc", ".git", "*.pdf" },
	wrap = false,
	writebackup = false,
	guifont = "Hack Nerd Font Mono:h15",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.display:append("lastline")
vim.opt.shortmess:append("c")
