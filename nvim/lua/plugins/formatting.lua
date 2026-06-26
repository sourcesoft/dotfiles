return {
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        notify_on_error = false,
        default_format_opts = {
          lsp_format = 'fallback',
        },
        format_on_save = function(bufnr)
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          end

          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end,
        formatters_by_ft = {
          go = { 'goimports', 'gofumpt' },
          lua = { 'stylua' },
          sql = { 'sql_formatter' },
        },
      }

      vim.keymap.set({ 'n', 'v' }, '<leader>F', function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end, { desc = '[F]ormat buffer' })
    end,
  },
}
