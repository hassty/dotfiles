require("user.options")
require("user.notify")
require("user.plugins")
require("user.keymaps")

require("user.alpha")
require("user.autopairs")
require("user.cmp")
require("user.colorscheme")
require("user.comment")
require("user.debug")
require("user.dressing")
require("user.gitsigns")
require("user.impatient")
require("user.indentline")
require("user.lsp")
require("user.nvim-tree")
require("user.project")
require("user.statusline")
require("user.telescope")
require("user.treesitter")
require("user.whichkey")
require("user.hardtime")
require("user.scrollview")

vim.cmd([[
runtime vim/autocommands.vim
runtime vim/db.vim
runtime vim/quickscope.vim
runtime vim/vimtex.vim
runtime vim/floaterm.vim
]])
