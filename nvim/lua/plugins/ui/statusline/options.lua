local components = require 'plugins.ui.statusline.components'

return {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = ' ', right = ' ' },
    globalstatus = true,
    disabled_filetypes = { statusline = { 'alpha', 'dashboard', 'snacks_dashboard' } },
  },
  extensions = { 'mason', 'trouble', 'oil' },
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
    lualine_z = { components.hello },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        icon = '',
        fmt = function(mode)
          return mode:lower()
        end,
      },
    },
    lualine_b = { { 'branch', icon = '' } },
    lualine_c = {
      {
        'diagnostics',
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = '󰝶 ',
        },
      },
      {
        components.file_icon,
        color = components.file_icon_color,
        separator = '',
        padding = { left = 0, right = 0 },
      },
      {
        'filename',
        path = 3,
        padding = { left = 0, right = 0 },
        fmt = components.filename,
      },
      {
        function()
          return '+' .. (components.listed_buffer_count() - 1) .. ' '
        end,
        cond = function()
          return components.listed_buffer_count() > 1
        end,
        color = function()
          return components.hl_color 'Operator'
        end,
        padding = { left = 0, right = 1 },
      },
      {
        function()
          return vim.fn.tabpagenr() .. ' of ' .. vim.fn.tabpagenr '$'
        end,
        cond = function()
          return vim.fn.tabpagenr '$' > 1
        end,
        icon = '󰓩',
        color = function()
          return components.hl_color 'Special'
        end,
      },
    },
    lualine_x = {
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
    lualine_y = {
      {
        'progress',
      },
      {
        'location',
        icon = '',
        color = function()
          return components.hl_color 'Boolean'
        end,
      },
    },
    lualine_z = {
      {
        'datetime',
        style = ' %R',
      },
    },
  },
}
