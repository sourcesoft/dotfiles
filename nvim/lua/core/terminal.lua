local M = {}

local float_opts = {
  win = {
    position = 'float',
    border = 'rounded',
    width = 0.9,
    height = 0.9,
  },
}

function M.toggle()
  Snacks.terminal(nil, float_opts)
end

vim.keymap.set('n', '<C-t>', M.toggle, { silent = true, desc = 'Toggle floating terminal' })
vim.keymap.set('t', '<C-t>', [[<C-\><C-n><cmd>lua require('core.terminal').toggle()<CR>]], { silent = true, desc = 'Toggle floating terminal' })

return M
