-- Load all Lua files in this directory through the local vim.pack adapter.
local pack = require 'custom.pack'
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
local uv = vim.uv or vim.loop

for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local path = vim.fs.joinpath(plugins_dir, file_name)
    if uv.fs_stat(path) then
      local module = file_name:gsub('%.lua$', '')
      local ok, spec = pcall(require, 'custom.plugins.' .. module)
      if not ok then
        vim.notify(('Failed to load custom plugin module %s: %s'):format(module, spec), vim.log.levels.ERROR)
      else
        pack.use(spec)
      end
    end
  end
end
