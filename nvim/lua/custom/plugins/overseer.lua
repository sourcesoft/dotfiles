return {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    require('overseer').setup {
      task_list = {
        max_height = { 20 },
        min_height = 15,
      },
    }
  end,
}
