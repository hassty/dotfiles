vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.selection = "old"
vim.o.scrolloff = 1
vim.o.sidescrolloff = 5
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.numberwidth = 3
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.o.updatetime = 50
vim.o.fillchars = "eob: "
vim.o.wrap = false
vim.o.laststatus = 3
vim.o.winborder = "rounded"
vim.o.pumblend = 20
-- vim.o.winblend = 20
vim.o.pumheight = 15

vim.o.inccommand = "split"

vim.opt.title = true
vim.opt.titlestring = '%F - nvim'

vim.opt.wildignore = { "*.a", "*.o", "*.so", "*.pyc", ".git", "*.pdf" }
vim.opt.shortmess:append("c")
