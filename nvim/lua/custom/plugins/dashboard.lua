return {
  'folke/snacks.nvim',
  opts = function()
    local logo = [[
BEST DOG IN THE WORLD (good boy):
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

    local function plugin_count()
      local plugins = vim.pack.get()
      local active = 0
      for _, plugin in ipairs(plugins) do
        if plugin.active then
          active = active + 1
        end
      end

      return ('⚡ Neovim loaded %d/%d vim.pack plugins'):format(active, #plugins)
    end

    return {
      dashboard = {
        enabled = true,
        preset = {
          header = logo,
          keys = {
            { desc = 'Update', icon = '󰊳 ', key = 'u', action = ':lua vim.pack.update()' },
            {
              desc = 'Find File',
              icon = ' ',
              key = 'f',
              action = function()
                require('telescope.builtin').find_files()
              end,
            },
            {
              desc = 'Restore Session',
              icon = ' ',
              key = 'r',
              action = function()
                require('persistence').load()
              end,
            },
            { desc = 'Quit', icon = ' ', key = 'q', action = ':qa' },
          },
        },
        sections = {
          { section = 'header' },
          { section = 'keys', gap = 1, padding = 1 },
          function()
            return { align = 'center', footer = plugin_count(), padding = 1 }
          end,
        },
      },
      explorer = {
        enabled = true,
        replace_netrw = false,
      },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      words = { enabled = true },
      lazygit = { enabled = true },
      scroll = { enabled = true },
    }
  end,
}
