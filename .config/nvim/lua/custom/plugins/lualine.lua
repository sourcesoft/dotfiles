local function hello()
  return [[Toro is the best]]
end

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
      winbar = {
        lualine_a = {
          {
            'filename',
            use_mode_color = false,
            icon = ' ',
            path = 4,
          },
        },
        lualine_b = {
          {
            'diagnostics',
            use_mode_color = false,
            color = {
              bg = 'white',
              fg = 'black',
            },
            fmt = function(str)
              if str == '' then
                return ''
              end
              return string.format('diagnostics:  %s  ', str)
            end,
          },
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
        },
        lualine_c = {
          {
            'navic',
            color_correction = 'static',
            navic_opts = {
              highlight = false,
              separator = ' ',
              depth_limit = 4,
              icons = {
                File = '',
                Module = '',
                Namespace = '',
                Package = '',
                Class = '',
                Method = '',
                Property = '',
                Field = '',
                Constructor = '',
                Enum = '',
                Interface = '',
                Function = '',
                Variable = '',
                Constant = '',
                String = '',
                Number = '',
                Boolean = '',
                Array = '',
                Object = '',
                Key = '',
                Null = '',
                EnumMember = '',
                Struct = '',
                Event = '',
                Operator = '',
                TypeParameter = '',
              },
            },
          },
        },
        lualine_z = { hello },
      },
      sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = {
          'branch',
        },
        lualine_c = {
          {
            'filename',
            icon = ' ',
            path = 3,
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
