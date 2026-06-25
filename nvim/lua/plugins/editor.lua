return {
  {
    'windwp/nvim-autopairs',
    opts = {},
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', ':Oil --float<CR>', { desc = 'Oil reveal' } },
      { '<leader>O', ':Oil --float<CR>', { desc = 'Oil float' } },
    },
    config = function()
      require('oil').setup {
        float = {
          border = 'rounded',
          padding = 8,
        },
      }
    end,
  },

  {
    'gbprod/cutlass.nvim',
    opts = {
      exclude = { 's<space>' },
    },
  },

  {
    'chrisgrieser/nvim-early-retirement',
    config = true,
    opts = {
      retirementAgeMins = 180,
      minimumBufferNum = 11,
    },
  },

  {
    'hedyhli/outline.nvim',
    keys = {
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle Outline' },
    },
    opts = {
      outline_window = {
        focus_on_open = true,
      },
    },
  },

  {
    'stevearc/quicker.nvim',
    version = vim.version.range '^1.5.0',
    keys = {
      {
        '<leader>x',
        function()
          require('quicker').toggle()
        end,
        desc = 'Toggle quickfix',
      },
      {
        '<leader>X',
        function()
          require('quicker').toggle { loclist = true }
        end,
        desc = 'Toggle loclist',
      },
    },
    opts = {
      keys = {
        {
          '>',
          function()
            require('quicker').expand { before = 2, after = 2, add_to_existing = true }
          end,
          desc = 'Expand quickfix context',
        },
        {
          '<',
          function()
            require('quicker').collapse()
          end,
          desc = 'Collapse quickfix context',
        },
      },
    },
  },

  {
    'folke/trouble.nvim',
    opts = {},
    keys = {
      {
        '<leader>n',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
    },
  },
}
