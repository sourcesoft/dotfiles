return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.bufremove',
  },
  opts = {},
  init = function()
    vim.opt.termguicolors = true
  end,
  config = function()
    local bufferline = require 'bufferline'
    bufferline.setup {
      highlights = {
        buffer_selected = {
          bold = true,
          italic = true,
        },
      },
      options = {
        max_name_length = 14,
        tab_size = 10,
        show_buffer_icons = false, -- disable filetype icons for buffers
        buffer_close_icon = '',
        close_icon = '',
        numbers = 'buffer_id',
        separator_style = 'padded_slant',
        show_close_icon = false,
        show_tab_indicators = true,
        indicator = {
          style = 'underline',
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
      },
    }
  end,
}
