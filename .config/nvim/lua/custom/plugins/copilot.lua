return {
  'zbirenbaum/copilot-cmp',
  event = 'InsertEnter',
  dependencies = { 'zbirenbaum/copilot.lua' },
  config = function()
    vim.defer_fn(function()
      require('copilot').setup {
        suggestion = {
          enable = true,
          auto_trigger = true,
          hide_during_completion = false,
          debounce = 75,
          keymap = {
            accept = '<Tab>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
      } -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require('copilot_cmp').setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
}
