local M = {}

local function markdown_oxide_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  return vim.tbl_deep_extend('force', capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  })
end

---@type table<string, vim.lsp.Config>
local servers = {
  autotools_ls = {},
  clangd = {},
  cssls = {},
  docker_language_server = {},
  gopls = {},
  helm_ls = {},
  html = {},
  jsonls = {},
  markdown_oxide = {
    capabilities = markdown_oxide_capabilities(),
  },
  rust_analyzer = {},
  sqls = {
    root_markers = { '.sqls.yml', 'sqls.yml', 'config.yml', '.git' },
  },
  terraformls = {},
  tflint = {},
  ts_ls = {},
  yamlls = {},
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
        format = { enable = false },
      },
    },
  },
}

function M.setup()
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'doctoc',
    'gofumpt',
    'goimports',
    'stylua',
    'sql-formatter',
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

return M
