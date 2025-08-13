vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client:supports_method('textDocument/completion') then
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                    -- HACK
                    vim.diagnostic.enable(true, { bufnr = args.buf })
                end,
            })
        end
    end,
})

vim.opt.completeopt = { "menuone", "popup", "noinsert", "fuzzy" }

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        }
    }
})

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true })

vim.lsp.inlay_hint.enable()
