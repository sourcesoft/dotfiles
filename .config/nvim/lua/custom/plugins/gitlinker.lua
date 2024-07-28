return {
  'linrongbin16/gitlinker.nvim',
  cmd = 'GitLink',
  opts = {},
  keys = {
    { '<leader>cy', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Yank git-line link' },
    { '<leader>cg', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git-line permanent link' },
    { '<leader>cb', '<cmd>GitLink! blame<cr>', mode = { 'n', 'v' }, desc = 'Open git-line blame' },
    { '<leader>cc', '<cmd>GitLink! current_branch<cr>', mode = { 'n', 'v' }, desc = 'Open git-line branch link' },
  },
}
