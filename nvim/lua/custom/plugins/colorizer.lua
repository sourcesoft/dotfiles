return {
  'catgoose/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup {
      filetypes = { 'css', 'scss', 'html', 'javascript' },
      options = {
        parsers = {
          css = true,
          css_fn = true,
          hex = {
            default = true,
            rrggbbaa = true,
          },
          rgb = { enable = true },
          hsl = { enable = true },
        },
      },
    }
  end,
}
