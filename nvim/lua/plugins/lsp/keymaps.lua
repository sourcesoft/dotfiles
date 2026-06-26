local M = {}

local function configure_markdown_oxide(event, client)
  if not client or client.name ~= 'markdown_oxide' then
    return
  end

  vim.api.nvim_buf_create_user_command(event.buf, 'Daily', function(args)
    local command = { command = 'jump' }
    if args.args ~= '' then
      command.arguments = { args.args }
    end
    client:exec_cmd(command, { bufnr = event.buf })
  end, { desc = 'Open Markdown Oxide daily note', nargs = '*' })

  if client:supports_method('textDocument/codeLens', event.buf) then
    vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, { buffer = event.buf, desc = 'LSP: Run Code Lens' })
    vim.lsp.codelens.enable(true, { bufnr = event.buf })
  end
end

function M.on_attach(event)
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  map('gd', function()
    Snacks.picker.lsp_definitions()
  end, '[G]oto [D]efinition')
  map('<leader>D', function()
    Snacks.picker.lsp_type_definitions()
  end, 'Type [D]efinition')
  map('<leader>ls', function()
    Snacks.picker.lsp_symbols()
  end, '[D]ocument [S]ymbols')
  map('<leader>lS', function()
    Snacks.picker.lsp_workspace_symbols()
  end, '[W]orkspace [S]ymbols')
  map('<leader>R', vim.lsp.buf.rename, '[R]ename')
  map('<leader>lr', vim.lsp.buf.rename, '[R]ename')
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
  map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
  map('gD', function()
    Snacks.picker.lsp_declarations()
  end, '[G]oto [D]eclaration')
  map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
  map('grD', function()
    Snacks.picker.lsp_declarations()
  end, '[G]oto [D]eclaration')
  map('grr', function()
    Snacks.picker.lsp_references()
  end, '[G]oto [R]eferences')
  map('gri', function()
    Snacks.picker.lsp_implementations()
  end, '[G]oto [I]mplementation')
  map('grd', function()
    Snacks.picker.lsp_definitions()
  end, '[G]oto [D]efinition')
  map('gO', function()
    Snacks.picker.lsp_symbols()
  end, 'Open Document Symbols')
  map('gW', function()
    Snacks.picker.lsp_workspace_symbols()
  end, 'Open Workspace Symbols')
  map('grt', function()
    Snacks.picker.lsp_type_definitions()
  end, '[G]oto [T]ype Definition')

  vim.keymap.set('n', '<leader>r', function()
    Snacks.picker.lsp_references()
  end, { buffer = event.buf, desc = 'Show References' })
  vim.keymap.set('n', '<leader>i', function()
    Snacks.picker.lsp_implementations()
  end, { buffer = event.buf, desc = 'Show Implementations' })
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { buffer = event.buf, desc = 'Hover Documentation' })
  vim.keymap.set('n', '<leader>K', function()
    local ok, goto_preview = pcall(require, 'goto-preview')
    if ok then
      goto_preview.goto_preview_definition()
    else
      vim.lsp.buf.definition()
    end
  end, { buffer = event.buf, desc = 'Hover Definition' })

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  configure_markdown_oxide(event, client)

  if client and client:supports_method('textDocument/inlayHint', event.buf) then
    map('<leader>lh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, '[T]oggle Inlay [H]ints')
  end

  if client and client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, event.buf)
  end
end

return M
