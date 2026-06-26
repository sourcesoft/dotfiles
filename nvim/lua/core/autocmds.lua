vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('dotfiles-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local function has_helm_chart(path)
  return vim.fs.find('Chart.yaml', { path = vim.fs.dirname(path), upward = true })[1] ~= nil
end

vim.filetype.add {
  extension = {
    tf = 'terraform',
    tfvars = 'terraform-vars',
  },
  filename = {
    ['compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
  },
  pattern = {
    ['.*/templates/.*%.tpl'] = function(path)
      return has_helm_chart(path) and 'helm' or nil
    end,
    ['.*/templates/.*%.ya?ml'] = function(path)
      return has_helm_chart(path) and 'helm' or nil
    end,
    ['.*/values.*%.ya?ml'] = function(path)
      return has_helm_chart(path) and 'yaml.helm-values' or nil
    end,
  },
}

vim.api.nvim_create_user_command('CleanEmptyBuffers', function()
  require('plugins.ui.sessions').clean_buffers()
end, {})
