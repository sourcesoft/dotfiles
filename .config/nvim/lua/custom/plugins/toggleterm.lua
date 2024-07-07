return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 30,
      open_mapping = [[<c-t>]],
      direction = 'float',
      shading_factor = 90,
      shade_terminals = true,
      float_opts = {
        border = 'double',
      },
    }
  end,
}
