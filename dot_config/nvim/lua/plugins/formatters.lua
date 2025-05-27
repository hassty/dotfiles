return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["python"] = { "black" },
        ["bash"] = { "beautysh" },
        ["go"] = { "goimports" },
      },
    },
  },
}
