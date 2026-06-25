local function set_barbar_highlights()
  local current_bg = '#3a4252'
  local current_fg = '#ffffff'
  local accent = '#8fb8ff'

  local current_groups = {
    'BufferCurrent',
    'BufferCurrentBtn',
    'BufferCurrentIcon',
    'BufferCurrentIndex',
    'BufferCurrentNumber',
    'BufferCurrentPin',
    'BufferCurrentPinBtn',
    'BufferCurrentTarget',
  }

  for _, group in ipairs(current_groups) do
    vim.api.nvim_set_hl(0, group, { bg = current_bg, fg = current_fg, bold = true })
  end

  vim.api.nvim_set_hl(0, 'BufferCurrentMod', { bg = current_bg, fg = '#ffd166', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentModBtn', { bg = current_bg, fg = '#ffd166', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentSign', { bg = current_bg, fg = accent, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentSignRight', { bg = current_bg, fg = accent, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentADDED', { bg = current_bg, fg = '#a6e3a1', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentCHANGED', { bg = current_bg, fg = '#89b4fa', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentDELETED', { bg = current_bg, fg = '#f38ba8', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentERROR', { bg = current_bg, fg = '#ff6b6b', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentWARN', { bg = current_bg, fg = '#ffd166', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentINFO', { bg = current_bg, fg = '#89b4fa', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentHINT', { bg = current_bg, fg = '#94e2d5', bold = true })
end

return {
  {
    'romgrk/barbar.nvim',
    version = vim.version.range '^1.0.0',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require('barbar').setup {
        auto_hide = false,
        minimum_padding = 2,
        maximum_padding = 3,
        maximum_length = 24,
        icons = {
          separator = { left = '▌', right = '▐' },
          inactive = { separator = { left = '▌', right = '▐' } },
          separator_at_end = false,
        },
      }

      set_barbar_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('dotfiles-barbar-highlights', { clear = true }),
        callback = set_barbar_highlights,
        desc = 'Keep current barbar buffer visible',
      })
    end,
  },
}
