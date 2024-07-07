return {
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  opts = {},
  config = function()
    require('ibl').setup {
      indent = {
        tab_char = '▎',
      },
    }
  end,
}
