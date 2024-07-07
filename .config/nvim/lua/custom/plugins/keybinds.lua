vim.keymap.set('n', '<S-h>', ':bp<CR>', { desc = 'Move focus to the left window', silent = true })
vim.keymap.set('n', '<S-l>', ':bn<CR>', { desc = 'Move focus to the left window', silent = true })
vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader><Tab>', ':ChatGPT<CR>', { desc = 'Talk to ChatGPT' })

vim.api.nvim_set_keymap('n', '<C-d>', '5j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '5k', { noremap = true, silent = true })

return {}
