return {
  'stevearc/oil.nvim',
  opts = {},
  keys = {
    { '-', ':Oil --float<CR>', { desc = 'Oil reveal' } },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  config = function()
    require('oil').setup {
      float = {
        -- Padding around the floating window
        padding = 8,
      },
    }
  end,
}
