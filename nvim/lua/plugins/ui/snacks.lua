local sessions = require 'plugins.ui.sessions'

local function dashboard_opts()
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
              Snacks.picker.files()
            end,
          },
          {
            desc = 'Restore Session',
            icon = ' ',
            key = 'r',
            action = sessions.restore_project,
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
    gitbrowse = {},
    scroll = { enabled = true },
    indent = {
      enabled = true,
      indent = {
        char = '▎',
      },
      scope = {
        char = '▎',
      },
    },
    toggle = { enabled = true },
    zen = { enabled = true },
  }
end

local function yank_gitbrowse_url(opts)
  opts = vim.tbl_deep_extend('force', {
    what = 'permalink',
    notify = false,
    open = function(url)
      vim.fn.setreg('"', url)
      if vim.fn.has 'clipboard' == 1 then
        vim.fn.setreg('+', url)
      end
      Snacks.notify('Copied git link to clipboard', { title = 'Git Browse' })
    end,
  }, opts or {})

  Snacks.gitbrowse(opts)
end

local function gitbrowse_blame()
  Snacks.gitbrowse {
    what = 'permalink',
    url_patterns = {
      ['github%.com'] = {
        permalink = '/blame/{commit}/{file}?plain=1#L{line_start}-L{line_end}',
      },
      ['gitlab%.com'] = {
        permalink = '/-/blame/{commit}/{file}#L{line_start}-{line_end}',
      },
      ['bitbucket%.org'] = {
        permalink = '/annotate/{commit}/{file}#lines-{line_start}:{line_end}',
      },
    },
  }
end

return {
  {
    'folke/snacks.nvim',
    keys = {
      {
        '<leader>E',
        function()
          Snacks.explorer()
        end,
        desc = 'Explorer',
      },
      {
        '<leader>G',
        function()
          Snacks.lazygit()
        end,
        desc = 'LazyGit',
      },
      {
        '<leader>cy',
        function()
          yank_gitbrowse_url()
        end,
        mode = { 'n', 'v' },
        desc = 'Yank git-line link',
      },
      {
        '<leader>cg',
        function()
          Snacks.gitbrowse { what = 'permalink' }
        end,
        mode = { 'n', 'v' },
        desc = 'Open git-line permanent link',
      },
      {
        '<leader>cb',
        gitbrowse_blame,
        mode = { 'n', 'v' },
        desc = 'Open git-line blame',
      },
      {
        '<leader>cc',
        function()
          Snacks.gitbrowse { what = 'file' }
        end,
        mode = { 'n', 'v' },
        desc = 'Open git-line branch link',
      },
    },
    opts = dashboard_opts,
  },
}
