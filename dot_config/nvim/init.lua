require("user.options")
require("user.notify")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.cmp")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvim-tree")
require("user.toggleterm")
require("user.project")
require("user.impatient")
require("user.indentline")
require("user.alpha")
require("user.whichkey")
require("user.statusline")
require("user.zen-mode")
require("user.cheatsheet")
require("user.debug")
require("user.dressing")
vim.cmd([[
runtime vim/autocommands.vim
runtime vim/vimtex.vim
runtime vim/hardtime.vim
runtime vim/db.vim
runtime vim/scrollview.vim
runtime vim/quickscope.vim
]])
