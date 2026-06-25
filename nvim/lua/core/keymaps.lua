local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', '<S-h>', ':bp<CR>', { desc = 'Previous buffer', silent = true })
map('n', '<S-l>', ':bn<CR>', { desc = 'Next buffer', silent = true })
map('n', '<leader>q', ':bd<CR>', { desc = 'Close the buffer' })
map('n', '<leader>;', ':w!<CR>', { desc = 'Save current buffer' })

map('n', '<C-d>', '5j', { desc = 'Move down 5 lines', silent = true })
map('n', '<C-u>', '5k', { desc = 'Move up 5 lines', silent = true })

map('n', 'K', ':m .-2<CR>==', { desc = 'Move line up' })
map('n', 'J', ':m .+1<CR>==', { desc = 'Move line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

vim.api.nvim_create_user_command('Plugins', function()
  vim.pack.update(nil, { offline = true })
end, { desc = 'List plugins' })

vim.api.nvim_create_user_command('PluginUpdate', function()
  vim.pack.update()
end, { desc = 'Update plugins' })

map('n', '<leader>pl', '<cmd>Plugins<CR>', { desc = '[P]lugins [l]ist' })
map('n', '<leader>pu', '<cmd>PluginUpdate<CR>', { desc = '[P]lugins [u]pdate' })
