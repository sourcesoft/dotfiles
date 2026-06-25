vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('dotfiles-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local function clean_empty_buffers()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) then
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match 'OUTLINE_' then
        vim.api.nvim_win_close(win, true)
      end
    end
  end
end

vim.api.nvim_create_user_command('CleanEmptyBuffers', clean_empty_buffers, {})
