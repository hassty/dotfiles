local lsp_settings = vim.api.nvim_create_augroup("_lsp_settings", { clear = true })
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

local setup_completion = function(client, buf)
  local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
  client.server_capabilities.completionProvider.triggerCharacters = chars
  vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
end

local setup_formatting = function(client, buf)
  local format = function()
    vim.lsp.buf.format({ bufnr = buf, id = client.id })
    -- HACK
    vim.diagnostic.enable(true, { bufnr = buf })
  end
  if client.name ~= 'clangd' then
    autocmd('BufWritePre', {
      group = lsp_settings,
      buffer = buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = buf, id = client.id })
        -- HACK
        vim.diagnostic.enable(true, { bufnr = buf })
      end,
    })
  end
  vim.api.nvim_buf_create_user_command(buf, 'LspFormat', format, {})
  map('n', '<leader>lf', format, { desc = "Format buffer", buffer = buf })
end

local setup_inlay_hints = function(client, buf)
  vim.lsp.inlay_hint.enable()
  map('',
    '<leader>lh',
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    { desc = "Toggle inlay hints", buffer = buf }
  )
end

local setup_diagnostics = function()
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

  local function next_diag(severity, desc)
    vim.diagnostic.jump({ count = 1, float = true, border = "rounded", severity = severity, desc = desc })
  end
  local function prev_diag(severity, desc)
    vim.diagnostic.jump({ count = -1, float = true, border = "rounded", severity = severity, desc = desc })
  end
  local severity = vim.diagnostic.severity

  map('', '[e', function() prev_diag(severity.ERROR, "Previous error") end)
  map('', ']e', function() next_diag(severity.ERROR, "Next error") end)
  map('', '[w', function() prev_diag(severity.WARN, "Previous warning") end)
  map('', ']w', function() next_diag(severity.WARN, "Next warning") end)
end

-- TODO: LspDetach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    autocmd({ "CursorHold", "CursorHoldI" }, {
      group = lsp_settings,
      pattern = "*",
      callback = vim.lsp.buf.document_highlight,
    })

    autocmd("CursorMoved", {
      group = lsp_settings,
      pattern = "*",
      callback = vim.lsp.buf.clear_references,
    })

    if client:supports_method('textDocument/completion') then
      setup_completion(client, args.buf)
    end

    if client:supports_method('textDocument/formatting') then
      setup_formatting(client, args.buf)
    end

    if client:supports_method('textDocument/inlayHint') then
      setup_inlay_hints(client, args.buf)
    end
  end,
})

setup_diagnostics()
