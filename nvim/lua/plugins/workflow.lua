return {
  {
    'stevearc/overseer.nvim',
    keys = {
      { '<leader>v', ':OverseerRun<CR>', desc = 'Run task' },
      { '<leader>V', ':OverseerToggle<CR>', desc = 'Toggle tasks' },
    },
    opts = {
      task_list = {
        max_height = { 20 },
        min_height = 15,
      },
    },
  },

  {
    'Maxteabag/sqlit.nvim',
    opts = {
      keymap = '<leader>S',
      desc = 'Database (sqlit)',
    },
  },
}
