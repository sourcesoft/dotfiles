return {
  {
    'rachartier/tiny-cmdline.nvim',
    init = function()
      vim.o.cmdheight = 0
      -- Work around Neovim 0.12.3 UI2 msg_ruler errors during LSP detach/buffer close.
      vim.o.ruler = false
      require('vim._core.ui2').enable {}
    end,
    config = function()
      require('tiny-cmdline').setup {
        on_reposition = require('tiny-cmdline').adapters.blink,
      }
    end,
  },
}
