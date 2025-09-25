return {
  'folke/edgy.nvim',
  event = 'VeryLazy',
  init = function()
    vim.opt.splitkeep = 'screen'
  end,
  opts = {
    options = {
      left = { size = 31 },
      right = { size = 40 },
    },
    right = {
      { title = 'Outline', ft = 'Outline', size = { height = 1 }, pinned = true },
    },
    left = {
      -- Neo-tree filesystem always takes half the screen height
      {
        title = 'Files',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'filesystem'
        end,
        size = { height = 0.5 },
        pinned = true,
      },
      {
        title = 'Git',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'git_status'
        end,
        pinned = true,
        open = 'Neotree position=right git_status',
      },
      {
        title = 'Buffers',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'buffers'
        end,
        open = 'Neotree position=top buffers',
        pinned = true,
      },
    },
  },
}
