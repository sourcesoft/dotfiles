return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    -- vim.cmd.colorscheme 'catppuccin-mocha'
  end,
  config = function()
    require('catppuccin').setup {
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    }
  end,
}
