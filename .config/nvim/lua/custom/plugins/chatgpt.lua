return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  init = function()
    vim.keymap.set('n', '<leader><Tab>', ':ChatGPT<CR>', { desc = 'Open ChatGPT' })
  end,
  config = function()
    require('chatgpt').setup {
      chat = {
        welcome_message = 'I know that I know nothing. - Socrates',
      },
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
