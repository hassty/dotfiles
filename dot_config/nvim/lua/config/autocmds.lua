local general_settings = vim.api.nvim_create_augroup("_general_settings", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter" }, {
    group = general_settings,
    pattern = { "*" },
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
        vim.opt_local.formatoptions:remove { "c", "r", "o" }
    end
})

autocmd({ "BufRead", "BufReadPost" }, {
    group = general_settings,
    pattern = "*",
    callback = function()
        local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
        local buf_line_count = vim.api.nvim_buf_line_count(0)

        if row >= 1 and row <= buf_line_count then
            vim.api.nvim_win_set_cursor(0, { row, column + 1 })
            vim.cmd("norm! zz")
        end
    end,
})

autocmd("TextYankPost", {
    group = general_settings,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

--[[
local winbar = vim.api.nvim_create_augroup("_winbar", { clear = true })
autocmd("WinNew", {
    group = winbar,
    pattern = "*",
    callback = function()
        vim.o.winbar = "%=%t"
    end
})

autocmd("WinClosed", {
    group = winbar,
    pattern = "*",
    callback = function()
        local wins = vim.api.nvim_tabpage_list_wins(0)
        local splits = 0
        for _, win in pairs(wins) do
            local cfg = vim.api.nvim_win_get_config(win)
            if cfg.focusable and cfg.relative == "" then
                splits = splits + 1
            end
        end

        if splits <= 2 then
            vim.o.winbar = ""
        end
    end
})
--]]
