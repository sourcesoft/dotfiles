return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    config = function()
      require('lualine').setup(require 'plugins.ui.statusline.options')
    end,
  },
}
