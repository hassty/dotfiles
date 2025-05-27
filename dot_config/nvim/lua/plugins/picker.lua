return {
  {
    "folke/snacks.nvim",
    keys = function()
      return {
        {
          "<leader>f",
          function()
            Snacks.picker.files()
          end,
          desc = "Find Files",
        },
        {
          "<leader>e",
          function()
            Snacks.explorer.open({ cwd = LazyVim.root() })
          end,
          desc = "Explorer",
        },
        {
          "<leader>E",
          function()
            Snacks.explorer.reveal()
          end,
          desc = "Explorer Reveal",
        },
        -- SEARCH
        {
          "<leader>sr",
          function()
            Snacks.picker.recent()
          end,
          desc = "Recent Files",
        },
        {
          "<leader>sp",
          function()
            Snacks.picker.projects()
          end,
          desc = "Projects",
        },
        {
          "<leader>st",
          function()
            Snacks.picker.grep()
          end,
          desc = "Find Text",
        },
        {
          "<leader>so",
          function()
            Snacks.picker.buffers()
          end,
          desc = "Open Buffers",
        },
        -- GIT
        {
          "<leader>gl",
          function() end,
          desc = "Blame",
        },
        {
          "<leader>gp",
          "",
          desc = "Preview Hunk",
        },
        {
          "<leader>gr",
          "",
          desc = "Reset Hunk",
        },
        {
          "<leader>gR",
          "",
          desc = "Reset Buffer",
        },
        {
          "<leader>gs",
          "",
          desc = "Stage Hunk",
        },
        {
          "<leader>gS",
          "",
          desc = "Stage Buffer",
        },
        {
          "<leader>gu",
          "",
          desc = "Undo Stage Hunk",
        },
        {
          "<leader>go",
          "",
          desc = "Open Changed File",
        },
        {
          "<leader>gb",
          function()
            Snacks.picker.git_branches()
          end,
          desc = "Checkout Branch",
        },
        {
          "<leader>gc",
          "",
          desc = "Checkout Commit",
        },
        {
          "<leader>gd",
          "",
          desc = "Diff",
        },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    -- TODO: wtf
    enabled = false,
    keys = {
      { "<leader>st", false },
    },
    {
      "MagicDuck/grug-far.nvim",
      opts = { headerMaxWidth = 80 },
      cmd = "GrugFar",
      keys = {
        {
          "<leader>sR",
          function()
            local grug = require("grug-far")
            local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
            grug.open({
              transient = true,
              prefills = {
                filesFilter = ext and ext ~= "" and "*." .. ext or nil,
              },
            })
          end,
          mode = { "n", "v" },
          desc = "Search and Replace",
        },
      },
    },
  },
}
