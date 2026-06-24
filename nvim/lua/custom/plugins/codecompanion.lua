return {
  'olimorris/codecompanion.nvim',
  version = vim.version.range '^19.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<leader><Tab>', '<cmd>CodeCompanionChat Toggle<CR>', desc = 'Toggle AI chat' },
    { '<leader><Tab>', '<cmd>CodeCompanionChat Add<CR>', mode = 'v', desc = 'Add selection to AI chat' },
    { '<leader>cp', '<cmd>CodeCompanionActions<CR>', mode = { 'n', 'v' }, desc = 'AI action palette' },
    { '<leader>ci', '<cmd>CodeCompanion<CR>', mode = { 'n', 'v' }, desc = 'AI inline prompt' },
  },
  config = function()
    require('codecompanion').setup {
      display = {
        chat = {
          window = {
            layout = 'float',
            width = 0.45,
          },
        },
      },
    }
  end,
}
