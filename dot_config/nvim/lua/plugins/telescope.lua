return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    config = function()
      local ok, telescope = pcall(require, 'telescope')
      if not ok then
        return
      end
      telescope.setup {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.95,
            height = 0.95,
            horizontal = {
              preview_cutoff = 100,
              preview_width = 55,
            },
          },
        },
        pickers = {
          find_files = {
            -- theme = "ivy",
          },
        },
        extensions = {
          fzf = {},
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          }
        },
      }

      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      telescope.load_extension('live_grep_args')
    end,
    keys = {
      { "<leader>f",  "<cmd>Telescope find_files<cr>", desc = "Find files" },
      {
        "<leader>st",
        function() require('telescope').extensions.live_grep_args.live_grep_args() end,
        desc = "Search text"
      },
      {
        "<leader>sw",
        function()
          require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
        end,
        desc = "Search word",
      },
      {
        "<leader>sw",
        function()
          require("telescope-live-grep-args.shortcuts").grep_visual_selection()
        end,
        mode = "v",
        desc = "Search selection",
      },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",  desc = "Search help" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>",   desc = "Search recent files" },
      { "<leader>sp", "<cmd>Telescope projects<cr>",   desc = "Search projects" },
      { "<leader>so", "<cmd>Telescope buffers<cr>",    desc = "Search open buffers" },
      {
        "<leader>s/",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Search current buffer"
      },
      { "<leader>sv", "<cmd>Telescope vim_options<cr>",  desc = "Search vim options" },
      { "<leader>go", "<cmd>Telescope git_status<cr>",   desc = "Git modified files" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",  desc = "Checkout commit" },
    },
  },
}
