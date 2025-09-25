return {
  'petertriho/nvim-scrollbar',
  opts = {},
  config = function()
    require('scrollbar').setup {
      handle = {
        text = ' ',
        blend = 60, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
        color = '#000000',
        color_nr = nil,
        highlight = 'CursorColumn',
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
      marks = {
        Cursor = {
          text = '•',
        },
      },
    }
  end,
}
