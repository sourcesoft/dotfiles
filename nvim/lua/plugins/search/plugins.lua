return {
  {
    'MagicDuck/grug-far.nvim',
    opts = {},
    keys = {
      { '<leader>sR', '<cmd>GrugFar<CR>', desc = '[S]earch and [R]eplace' },
      { '<leader>sR', ':GrugFarWithin<CR>', mode = 'v', desc = '[S]earch and [R]eplace selection' },
    },
  },
}
