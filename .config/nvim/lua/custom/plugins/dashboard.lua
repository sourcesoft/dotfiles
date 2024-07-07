return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  opts = function()
    local logo = [[

 .----------------. .----------------. .----------------. .----------------. 
| .--------------. | .--------------. | .--------------. | .--------------. |
| |  _________   | | |     ____     | | |  _______     | | |     ____     | |
| | |  _   _  |  | | |   .'    `.   | | | |_   __ \    | | |   .'    `.   | |
| | |_/ | | \_|  | | |  /  .--.  \  | | |   | |__) |   | | |  /  .--.  \  | |
| |     | |      | | |  | |    | |  | | |   |  __ /    | | |  | |    | |  | |
| |    _| |_     | | |  \  `--'  /  | | |  _| |  \ \_  | | |  \  `--'  /  | |
| |   |_____|    | | |   `.____.'   | | | |____| |___| | | |   `.____.'   | |
| |              | | |              | | |              | | |              | |
| '--------------' | '--------------' | '--------------' | '--------------' |
 '----------------' '----------------' '----------------' '----------------' 

       I know that I know nothing. - Socrates
  ]]

    logo = string.rep('\n', 8) .. logo .. '\n\n'

    local opts = {
      theme = 'hyper',
      config = {
        packages = { enable = false },
        header = vim.split(logo, '\n'),
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          { action = 'lua require("telescope.builtin").find_files()', desc = ' Find File', icon = ' ', key = 'f' },
          { action = 'lua require("persistence").load()', desc = ' Restore Session', icon = ' ', key = 'r' },
          {
            action = function()
              vim.api.nvim_input '<cmd>qa<cr>'
            end,
            desc = ' Quit',
            icon = ' ',
            key = 'q',
          },
        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
        end,
      },
    }

    return opts
  end,
}
