return {
  {
    'dmtrKovalenko/fff.nvim',
    opts = {
      lazy_sync = true,
      max_results = 100,
      layout = {
        width = 0.8,
        height = 0.85,
        prompt_position = 'bottom',
        preview_position = 'right',
        preview_size = 0.5,
        border = 'rounded',
      },
      preview = {
        enabled = true,
        line_numbers = true,
        wrap_lines = false,
      },
    },
  },

  {
    'MagicDuck/grug-far.nvim',
    opts = {},
    keys = {
      { '<leader>sR', '<cmd>GrugFar<CR>', desc = '[S]earch and [R]eplace' },
      { '<leader>sR', ':GrugFarWithin<CR>', mode = 'v', desc = '[S]earch and [R]eplace selection' },
    },
  },
}
