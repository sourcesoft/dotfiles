local sessions = require 'plugins.ui.sessions'

return {
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
      require('mini.comment').setup()
      require('mini.splitjoin').setup()
      require('mini.trailspace').setup()
      require('mini.jump2d').setup()
      require('mini.hipatterns').setup {
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        },
      }

      vim.keymap.set('n', '<leader>cw', function()
        MiniTrailspace.trim()
      end, { desc = '[C]ode trim trailing [w]hitespace' })

      vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
      require('mini.sessions').setup {
        autoread = false,
        autowrite = false,
        directory = sessions.session_dir,
        file = '',
        hooks = {
          pre = {
            write = sessions.clean_buffers,
          },
        },
        verbose = { read = true, write = false, delete = true },
      }

      vim.api.nvim_create_autocmd('VimLeavePre', {
        group = vim.api.nvim_create_augroup('dotfiles-mini-sessions', { clear = true }),
        callback = sessions.autosave_project,
        desc = 'Autosave current project session',
      })
    end,
  },
}
