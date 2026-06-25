local session_dir = vim.fn.stdpath 'state' .. '/session'

local function project_session_name()
  local cwd = vim.fn.getcwd()
  local name = vim.fn.fnamemodify(cwd, ':t')
  if name == '' then
    name = 'session'
  end

  name = name:gsub('[^%w_.-]', '_')
  return ('%s-%s.vim'):format(name, vim.fn.sha256(cwd):sub(1, 12))
end

local function project_session_path()
  return session_dir .. '/' .. project_session_name()
end

local function has_session_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(bufnr)
    if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted and vim.bo[bufnr].buftype == '' and name ~= '' then
      return true
    end
  end

  return false
end

local function clean_session_buffers()
  pcall(vim.cmd, 'CleanEmptyBuffers')
end

local function restore_project_session()
  local name = project_session_name()
  if vim.fn.filereadable(project_session_path()) == 0 then
    vim.notify(('No saved session for %s'):format(vim.fn.getcwd()), vim.log.levels.INFO)
    return
  end

  local ok, sessions = pcall(require, 'mini.sessions')
  if not ok then
    vim.notify('mini.sessions is not available', vim.log.levels.WARN)
    return
  end

  local read_ok, err = pcall(sessions.read, name, { force = true, verbose = true })
  if not read_ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

local function autosave_project_session()
  if not has_session_buffers() then
    return
  end

  clean_session_buffers()

  local ok, sessions = pcall(require, 'mini.sessions')
  if not ok then
    return
  end

  local write_ok, err = pcall(sessions.write, project_session_name(), { force = true, verbose = false })
  if not write_ok then
    vim.notify(err, vim.log.levels.WARN)
  end
end

local function set_barbar_highlights()
  local current_bg = '#3a4252'
  local current_fg = '#ffffff'
  local accent = '#8fb8ff'

  local current_groups = {
    'BufferCurrent',
    'BufferCurrentBtn',
    'BufferCurrentIcon',
    'BufferCurrentIndex',
    'BufferCurrentNumber',
    'BufferCurrentPin',
    'BufferCurrentPinBtn',
    'BufferCurrentTarget',
  }

  for _, group in ipairs(current_groups) do
    vim.api.nvim_set_hl(0, group, { bg = current_bg, fg = current_fg, bold = true })
  end

  vim.api.nvim_set_hl(0, 'BufferCurrentMod', { bg = current_bg, fg = '#ffd166', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentModBtn', { bg = current_bg, fg = '#ffd166', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentSign', { bg = current_bg, fg = accent, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentSignRight', { bg = current_bg, fg = accent, bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentADDED', { bg = current_bg, fg = '#a6e3a1', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentCHANGED', { bg = current_bg, fg = '#89b4fa', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentDELETED', { bg = current_bg, fg = '#f38ba8', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentERROR', { bg = current_bg, fg = '#ff6b6b', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentWARN', { bg = current_bg, fg = '#ffd166', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentINFO', { bg = current_bg, fg = '#89b4fa', bold = true })
  vim.api.nvim_set_hl(0, 'BufferCurrentHINT', { bg = current_bg, fg = '#94e2d5', bold = true })
end

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
            action = restore_project_session,
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

local function hello()
  return [[Toro is the best]]
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
  { 'nvim-tree/nvim-web-devicons' },

  {
    'folke/which-key.nvim',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]iagnostics' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>l', group = '[L]SP' },
        { '<leader>p', group = '[P]lugins' },
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { 'gr', group = 'LSP Actions' },
      },
    },
  },

  {
    'nvim-mini/mini.nvim',
    config = function()
      if vim.g.have_nerd_font then
        require('mini.icons').setup()
        MiniIcons.mock_nvim_web_devicons()
      end

      require('mini.ai').setup {
        mappings = {
          around_next = 'aa',
          inside_next = 'ii',
        },
        n_lines = 500,
      }
      require('mini.surround').setup()
      require('mini.jump2d').setup()
      require('mini.hipatterns').setup {
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        },
      }

      vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
      require('mini.sessions').setup {
        autoread = false,
        autowrite = false,
        directory = session_dir,
        file = '',
        hooks = {
          pre = {
            write = clean_session_buffers,
          },
        },
        verbose = { read = true, write = false, delete = true },
      }

      vim.api.nvim_create_autocmd('VimLeavePre', {
        group = vim.api.nvim_create_augroup('dotfiles-mini-sessions', { clear = true }),
        callback = autosave_project_session,
        desc = 'Autosave current project session',
      })
    end,
  },

  {
    'navarasu/onedark.nvim',
    name = 'onedark',
    config = function()
      require('onedark').setup {
        style = 'dark',
        term_colors = true,
      }
      require('onedark').load()
    end,
  },

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

  {
    'romgrk/barbar.nvim',
    version = vim.version.range '^1.0.0',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require('barbar').setup {
        auto_hide = false,
        minimum_padding = 2,
        maximum_padding = 3,
        maximum_length = 24,
        icons = {
          separator = { left = '▌', right = '▐' },
          inactive = { separator = { left = '▌', right = '▐' } },
          separator_at_end = false,
        },
      }

      set_barbar_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('dotfiles-barbar-highlights', { clear = true }),
        callback = set_barbar_highlights,
        desc = 'Keep current barbar buffer visible',
      })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'gruvbox_dark',
        },
        extensions = { 'mason', 'trouble', 'oil' },
        winbar = {
          lualine_a = {
            {
              'filename',
              use_mode_color = false,
              icon = ' ',
              path = 4,
            },
          },
          lualine_b = {
            {
              'diagnostics',
              use_mode_color = false,
              color = {
                bg = 'white',
                fg = 'black',
              },
              fmt = function(str)
                if str == '' then
                  return ''
                end
                return string.format('diagnostics:  %s  ', str)
              end,
            },
            {
              'diff',
              diff_color = {
                added = { fg = '#9ece6a' },
                modified = { fg = '#7aa2f7' },
                removed = { fg = '#f7768e' },
              },
              symbols = {
                added = ' ',
                modified = ' ',
                removed = ' ',
              },
            },
          },
          lualine_c = {
            {
              'navic',
              color_correction = 'static',
              navic_opts = {
                highlight = false,
                separator = ' ',
                depth_limit = 4,
                icons = {
                  File = '',
                  Module = '',
                  Namespace = '',
                  Package = '',
                  Class = '',
                  Method = '',
                  Property = '',
                  Field = '',
                  Constructor = '',
                  Enum = '',
                  Interface = '',
                  Function = '',
                  Variable = '',
                  Constant = '',
                  String = '',
                  Number = '',
                  Boolean = '',
                  Array = '',
                  Object = '',
                  Key = '',
                  Null = '',
                  EnumMember = '',
                  Struct = '',
                  Event = '',
                  Operator = '',
                  TypeParameter = '',
                },
              },
            },
          },
          lualine_z = { hello },
        },
        sections = {
          lualine_a = { { 'mode', icon = '' } },
          lualine_b = { 'branch' },
          lualine_c = {
            {
              'filename',
              icon = ' ',
              path = 3,
            },
          },
          lualine_y = {
            {
              'progress',
              icon = '󰠞',
              color = {
                bg = '#f38ba8',
                fg = '#1e1e2e',
              },
            },
            {
              'location',
              icon = '',
              color = {
                bg = '#89b4fa',
                fg = '#1e1e2e',
              },
            },
          },
          lualine_z = {
            {
              function()
                return os.date '%R'
              end,
              color = {
                bg = '#9ece6a',
              },
              icon = ' ',
            },
          },
        },
      }
    end,
  },

  {
    'catgoose/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        filetypes = { 'css', 'scss', 'html', 'javascript' },
        options = {
          parsers = {
            css = true,
            css_fn = true,
            hex = {
              default = true,
              rrggbbaa = true,
            },
            rgb = { enable = true },
            hsl = { enable = true },
          },
        },
      }
    end,
  },

  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup {
        handle = {
          text = ' ',
          blend = 60,
          color = '#000000',
          color_nr = nil,
          highlight = 'CursorColumn',
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = {
            text = '•',
          },
        },
      }
    end,
  },

  {
    'NStefan002/screenkey.nvim',
    version = '*',
  },
}
