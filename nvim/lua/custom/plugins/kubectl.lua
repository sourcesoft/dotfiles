return {
  'ramilito/kubectl.nvim',
  init = function()
    vim.keymap.set('n', '<leader>m', function()
      require('kubectl').open()
    end, { desc = 'Open kubectl', silent = true })
    vim.keymap.set('n', '<leader>M', function()
      require('kubectl').close()
    end, { desc = 'Close kubectl', silent = true })
  end,
  config = function()
    require('kubectl').setup {
      auto_refresh = {
        enabled = false,
        interval = 3000, -- milliseconds
      },
      namespace = 'All',
      hints = true,
      context = true,
      float_size = {
        -- Almost fullscreen:
        -- width = 1.0,
        -- height = 0.95, -- Setting it to 1 will cause bottom to be cutoff by statuscolumn

        -- For more context aware size:
        width = 0.9,
        height = 0.8,

        -- Might need to tweak these to get it centered when float is smaller
        col = 10,
        row = 5,
      },
      obj_fresh = 0, -- highlight if creation newer than number (in minutes)
    }
  end,
}
