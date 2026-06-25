local function configure_lsp()
  require('fidget').setup {}
  require('mason').setup {}

  pcall(function()
    require('mason-lspconfig').setup { automatic_enable = false }
  end)

  vim.g.navic_silence = true
  require('nvim-navic').setup {
    separator = ' ',
    highlight = true,
    depth_limit = 5,
    lazy_update_context = true,
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('dotfiles-lsp-attach', { clear = true }),
    callback = function(event)
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
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>lh', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end

      if client and client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, event.buf)
      end
    end,
  })

  ---@type table<string, vim.lsp.Config>
  local servers = {
    gopls = {},
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
              '${3rd}/luv/library',
              '${3rd}/busted/library',
            }),
          },
        })
      end,
      settings = {
        Lua = {
          completion = { callSnippet = 'Replace' },
          format = { enable = false },
        },
      },
    },
  }

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'gofumpt',
    'goimports',
    'stylua',
    'sql-formatter',
    'markdownlint',
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'j-hui/fidget.nvim',
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'SmiteshP/nvim-navic',
      'rmagatti/goto-preview',
    },
    config = configure_lsp,
  },
}
