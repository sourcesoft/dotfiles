return {
  {
    'navarasu/onedark.nvim',
    name = 'onedark',
    config = function()
      require('onedark').setup {
        style = 'dark',
        term_colors = true,
      }
      require('onedark').load()
    end,
  },

  { 'scottmckendry/cyberdream.nvim' },
  { 'catppuccin/nvim', name = 'catppuccin' },
  { 'rebelot/kanagawa.nvim' },
}
