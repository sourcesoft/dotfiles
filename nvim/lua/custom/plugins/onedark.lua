return {
  'navarasu/onedark.nvim',
  name = 'onedark',
  init = function()
    require('onedark').load()
  end,
  config = function()
    require('onedark').setup {
      style = 'dark',
      term_colors = true,
    }
  end,
}
