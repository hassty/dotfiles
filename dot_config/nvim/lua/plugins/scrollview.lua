return {
  "dstein64/nvim-scrollview",
  event = "LazyFile",
  opts = {
    excluded_filetypes = { "netrw" },
    current_only = true,
    winblend = 10,
    base = "right",
    column = 2,
  },
}
