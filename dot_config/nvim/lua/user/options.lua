vim.cmd([[
syntax on
filetype plugin indent on
]])

local options = {
	conceallevel = 2,
	cursorline = true,
	exrc = true,
	fileencodings = { "ucs-bom", "utf-8", "default", "cp1251", "latin1" },
	fileformat = "unix",
	ignorecase = true,
	lazyredraw = true,
	linebreak = true,
	mouse = "a",
	number = true,
	pumblend = 10,
	pumheight = 10,
	relativenumber = true,
	selection = "old",
	scrolloff = 1,
	sidescrolloff = 5,
	expandtab = true,
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,
	smartcase = true,
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
	fillchars = "eob: ",
	guifont = "Hack Nerd Font Mono:h15",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.display:append("lastline")
vim.opt.shortmess:append("c")

vim.g.c_syntax_for_h = 1
