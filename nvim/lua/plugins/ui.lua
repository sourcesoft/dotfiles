local modules = {
  'plugins.ui.foundation',
  'plugins.ui.mini',
  'plugins.ui.themes',
  'plugins.ui.cmdline',
  'plugins.ui.snacks',
  'plugins.ui.buffers',
  'plugins.ui.statusline',
  'plugins.ui.visuals',
}

local specs = {}
for _, module in ipairs(modules) do
  vim.list_extend(specs, require(module))
end

return specs
