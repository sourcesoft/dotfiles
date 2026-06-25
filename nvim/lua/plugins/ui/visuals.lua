return {
  {
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
  },

  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup {
        handle = {
          text = ' ',
          blend = 60,
          color = '#000000',
          color_nr = nil,
          highlight = 'CursorColumn',
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = {
            text = '•',
          },
        },
      }
    end,
  },

  {
    'NStefan002/screenkey.nvim',
    version = '*',
  },
}
