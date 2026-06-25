local pack = require 'plugin_manager'

local modules = {
  'plugins.ui',
  'plugins.git',
  'plugins.search',
  'plugins.lsp',
  'plugins.completion',
  'plugins.treesitter',
  'plugins.formatting',
  'plugins.editor',
  'plugins.workflow',
  'plugins.ai',
  'plugins.markdown',
  'plugins.debug',
}

for _, module in ipairs(modules) do
  pack.use(require(module))
end
