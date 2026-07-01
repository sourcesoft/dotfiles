local function restart_lsp()
  local clients = vim.lsp.get_clients()

  for _, client in ipairs(clients) do
    client:stop(true)
  end

  vim.defer_fn(function()
    require('plugins.lsp.servers').setup()
    vim.notify(('Restarted %d LSP client%s'):format(#clients, #clients == 1 and '' or 's'), vim.log.levels.INFO)
  end, 300)
end

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
    callback = require('plugins.lsp.keymaps').on_attach,
  })

  require('plugins.lsp.servers').setup()

  vim.api.nvim_create_user_command('LspRestart', restart_lsp, {
    desc = 'Restart active LSP clients',
  })
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
