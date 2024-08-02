return {
  'SmiteshP/nvim-navic',
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local buffer = args.buf ---@type number
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require('nvim-navic').attach(client, buffer)
      end,
    })
  end,
  opts = function()
    return {
      separator = ' ',
      highlight = true,
      depth_limit = 5,
      lazy_update_context = true,
    }
  end,
}
