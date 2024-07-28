vim.keymap.set('n', '<S-h>', ':bp<CR>', { desc = 'Move focus to the left window', silent = true })
vim.keymap.set('n', '<S-l>', ':bn<CR>', { desc = 'Move focus to the left window', silent = true })
-- Close current buffer
vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = 'Close the buffer' })
-- Save active buffer
vim.keymap.set('n', '<leader>;', ':w!<CR>', { desc = 'Save current buffer' })
-- Open ChatGPT chat prompt
vim.keymap.set('n', '<leader><Tab>', ':ChatGPT<CR>', { desc = 'Talk to ChatGPT' })
-- jump up and down with 5 lines
vim.api.nvim_set_keymap('n', '<C-d>', '5j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '5k', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')
vim.keymap.set('n', '<leader>g', ':Telescope git_status<CR>')
vim.keymap.set('n', '<leader><space>', ':Telescope resume<CR>')

return {}
