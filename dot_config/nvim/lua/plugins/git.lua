return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signcolumn = true,
            numhl = false,
        },
        event = "BufEnter",
        keys = {
            {
                ']c',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        require("gitsigns").nav_hunk('next')
                    end
                end,
                desc = "Next hunk",
            },

            {
                '[c',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        require("gitsigns").nav_hunk('prev')
                    end
                end,
                desc = "Previous hunk",
            },

            {
                '[C',
                function() require("gitsigns").nav_hunk('first') end,
                desc = "First hunk",
            },
            {
                ']C',
                function() require("gitsigns").nav_hunk('last') end,
                desc = "Last hunk",
            },

            -- Actions
            { '<leader>hs', "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
            { '<leader>hr', "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },

            {
                '<leader>hs',
                function()
                    require("gitsigns").stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end,
                mode = "v",
                desc = "Stage selected",
            },

            {
                '<leader>hr',
                function()
                    require("gitsigns").reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end,
                mode = "v",
                desc = "Reset selected",
            },

            { '<leader>hS', "<cmd>Gitsigns stage_buffer<cr>",        desc = "Stage buffer" },
            { '<leader>hR', "<cmd>Gitsigns reset_buffer<cr>",        desc = "Reset buffer" },
            { '<leader>hp', "<cmd>Gitsigns preview_hunk<cr>",        desc = "Preview hunk" },
            { '<leader>hi', "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview hunk inline" },

            {
                '<leader>hb',
                function() require("gitsigns").blame_line({ full = true }) end,
                desc = "Blame line",
            },

            {
                '<leader>hd',
                "<cmd>Gitsigns diffthis<cr>",
                desc = "Diff this"
            },

            {
                '<leader>hD',
                function() require("gitsigns").diffthis('~') end,
                desc = "Diff ~",
            },

            {
                '<leader>hQ',
                function() require("gitsigns").setqflist('all') end,
                desc = "Set qflist all"
            },
            {
                '<leader>hq',
                "<cmd>Gitsigns setqflist<cr>",
                desc = "Set qflist"
            },

            -- Toggles
            {
                '<leader>tb',
                "<cmd>Gitsigns toggle_current_line_blame<cr>",
                desc = "Toggle current line blame"
            },
            {
                '<leader>tw',
                "<cmd>Gitsigns toggle_word_diff<cr>",
                desc = "Toggle word diff"
            },

            -- Text object
            {
                'ih',
                "<cmd>Gitsigns select_hunk<cr>",
                mode = { "o", "x" },
                desc = "Select hunk",
            },
        },
    },
}
