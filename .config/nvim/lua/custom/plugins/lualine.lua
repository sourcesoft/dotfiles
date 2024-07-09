return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'gruvbox_dark',
      },
      extensions = { 'lazy', 'mason', 'toggleterm', 'trouble', 'oil', 'neo-tree' },
      sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = {
          'branch',
          {
            'diff',
            diff_color = {
              added = { fg = '#9ece6a' },
              modified = { fg = '#7aa2f7' },
              removed = { fg = '#f7768e' },
            },
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
          },
          'diagnostics',
        },
        lualine_c = {
          {
            'filename',
            icon = '',
            path = 3,
          },
        },
        lualine_x = {
          {
            'filetype',
          },
          {
            'encoding',
          },
        },
        lualine_y = {
          {
            'progress',
            icon = '󰠞',
            color = {
              bg = '#f38ba8',
              fg = '#1e1e2e',
            },
          },
          {
            'location',
            icon = '',
            color = {
              bg = '#89b4fa',
              fg = '#1e1e2e',
            },
          },
        },
        lualine_z = {
          {
            function()
              return os.date '%R'
            end,
            color = {
              bg = '#9ece6a',
            },
            icon = ' ',
          },
        },
      },
    }
  end,
}
