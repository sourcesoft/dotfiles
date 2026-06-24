vim.keymap.set('n', '<S-h>', ':bp<CR>', { desc = 'Previous buffer', silent = true })
vim.keymap.set('n', '<S-l>', ':bn<CR>', { desc = 'Next buffer', silent = true })
-- Close current buffer
vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = 'Close the buffer' })
-- Save active buffer
vim.keymap.set('n', '<leader>;', ':w!<CR>', { desc = 'Save current buffer' })
-- jump up and down with 5 lines
vim.api.nvim_set_keymap('n', '<C-d>', '5j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '5k', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')
vim.keymap.set('n', '<leader>E', function()
  Snacks.explorer()
end, { desc = 'Snacks explorer' })
vim.keymap.set('n', '<leader>G', function()
  Snacks.lazygit()
end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>un', function()
  Snacks.notifier.show_history()
end, { desc = 'Notification history' })
vim.keymap.set({ 'n', 't' }, ']w', function()
  Snacks.words.jump(vim.v.count1)
end, { desc = 'Next LSP reference' })
vim.keymap.set({ 'n', 't' }, '[w', function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = 'Previous LSP reference' })
vim.keymap.set('n', '<leader>g', ':Telescope git_status<CR>')
vim.keymap.set('n', '<leader><space>', ':Telescope resume<CR>')
vim.keymap.set('n', '<leader>w', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>x', function()
  require('quicker').toggle()
end, { desc = 'Toggle quickfix' })
vim.keymap.set('n', '<leader>X', function()
  require('quicker').toggle { loclist = true }
end, { desc = 'Toggle loclist' })

vim.keymap.set('n', '<leader>v', ':OverseerRun<CR>')
vim.keymap.set('n', '<leader>V', ':OverseerToggle<CR>')

vim.keymap.set('n', 'K', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', 'J', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

vim.keymap.set('n', '<leader>a', function()
  local harpoon = require 'harpoon'
  harpoon:list():add()
end, { desc = 'Harpoon add file' })
vim.keymap.set('n', '<leader>h', function()
  local harpoon = require 'harpoon'
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon quick menu' })

return {}
