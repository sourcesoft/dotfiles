local M = {}

local main_overrides = {
  ['catgoose/nvim-colorizer.lua'] = 'colorizer',
  ['chrisgrieser/nvim-early-retirement'] = 'early-retirement',
  ['folke/trouble.nvim'] = 'trouble',
  ['gbprod/cutlass.nvim'] = 'cutlass',
  ['hedyhli/outline.nvim'] = 'outline',
  ['linrongbin16/gitlinker.nvim'] = 'gitlinker',
  ['lukas-reineke/indent-blankline.nvim'] = 'ibl',
  ['navarasu/onedark.nvim'] = 'onedark',
  ['petertriho/nvim-scrollbar'] = 'scrollbar',
  ['rmagatti/goto-preview'] = 'goto-preview',
  ['SmiteshP/nvim-navic'] = 'nvim-navic',
  ['stevearc/overseer.nvim'] = 'overseer',
}

local function gh(repo)
  return 'https://github.com/' .. repo
end

local function is_uri(source)
  return source:match '^https?://' or source:match '^git@' or source:match '^ssh://'
end

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local output = result.stderr ~= '' and result.stderr or result.stdout
    if output == '' then
      output = 'No output from build command.'
    end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('dotfiles-pack-changed', { clear = true }),
  callback = function(ev)
    local data = ev.data or {}
    local spec = data.spec or {}
    local name = spec.name
    local kind = data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    if name == 'blink.cmp' and vim.fn.executable 'cargo' == 1 then
      run_build(name, { 'cargo', 'build', '--release' }, data.path)
      return
    end

    if name == 'nvim-treesitter' then
      if not data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

function M.gh(repo)
  return gh(repo)
end

local function is_spec(value)
  if type(value) ~= 'table' then
    return false
  end

  if type(value.src) == 'string' then
    return true
  end

  if type(value[1]) ~= 'string' then
    return false
  end

  if value[2] == nil then
    return true
  end

  for key in pairs(value) do
    if type(key) ~= 'number' then
      return true
    end
  end

  return false
end

local function spec_name(spec)
  local source = spec[1] or spec.src
  if not source then
    return nil
  end

  return spec.name or source:gsub('%.git$', ''):match '([^/]+)$'
end

local function repo_id(spec)
  local source = spec[1] or spec.src
  if not source then
    return nil
  end

  if is_uri(source) then
    return source:gsub('%.git$', ''):match 'github.com[:/]([^/]+/[^/]+)$'
  end

  return source
end

local function normalize_spec(spec)
  if type(spec) == 'string' then
    spec = { spec }
  end

  local source = spec.src or spec[1]
  if not source then
    return nil
  end

  local normalized = {
    src = is_uri(source) and source or gh(source),
  }

  if spec.name then
    normalized.name = spec.name
  end

  if spec.branch then
    normalized.version = spec.branch
  elseif spec.version and spec.version ~= '*' then
    normalized.version = spec.version
  end

  return normalized
end

local function infer_main(spec)
  if spec.main then
    return spec.main
  end

  local id = repo_id(spec)
  if id and main_overrides[id] then
    return main_overrides[id]
  end

  local name = spec_name(spec)
  if not name then
    return nil
  end

  return name:gsub('%.nvim$', ''):gsub('%-nvim$', '')
end

local function spec_list(value)
  if value == nil then
    return {}
  end

  if type(value) == 'string' or is_spec(value) then
    return { value }
  end

  local specs = {}
  for _, item in ipairs(value) do
    vim.list_extend(specs, spec_list(item))
  end
  return specs
end

local function add_one(spec, opts)
  local normalized = normalize_spec(spec)
  if normalized then
    vim.pack.add({ normalized }, opts or { confirm = false, load = true })
  end
end

local function apply_keys(spec)
  local keys = spec.keys
  if type(keys) == 'function' then
    local ok
    ok, keys = pcall(keys, spec, {})
    if not ok then
      vim.notify(('Failed to evaluate keymaps for %s: %s'):format(spec_name(spec) or 'plugin', keys), vim.log.levels.ERROR)
      return
    end
  end

  if type(keys) ~= 'table' then
    return
  end

  for _, key in ipairs(keys) do
    local lhs = key[1]
    local rhs = key[2]
    if lhs and rhs then
      local opts = {}
      if type(key[3]) == 'table' then
        opts = vim.deepcopy(key[3])
      end
      opts.desc = key.desc or opts.desc
      opts.silent = opts.silent ~= false

      local mode = key.mode or opts.mode or 'n'
      opts.mode = nil
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end
end

local function opts_for(spec)
  return type(spec.opts) == 'function' and spec.opts(spec, {}) or spec.opts
end

local function setup_from_opts(spec)
  if spec.config ~= nil or spec.opts == nil then
    return
  end

  local main = infer_main(spec)
  if not main then
    return
  end

  local ok, plugin = pcall(require, main)
  if ok and type(plugin.setup) == 'function' then
    plugin.setup(opts_for(spec) or {})
  end
end

local function run_config(spec)
  if type(spec.config) == 'function' then
    spec.config()
    return
  end

  if spec.config == true then
    local main = infer_main(spec)
    if main then
      local ok, plugin = pcall(require, main)
      if ok and type(plugin.setup) == 'function' then
        plugin.setup(opts_for(spec) or {})
      end
    end
  end
end

function M.use(value)
  for _, spec in ipairs(spec_list(value)) do
    if type(spec) == 'string' then
      add_one(spec)
    elseif type(spec) == 'table' and spec.enabled ~= false then
      if type(spec.init) == 'function' then
        spec.init()
      end

      if type(spec.setup) == 'function' then
        spec.setup()
      end

      M.use(spec.dependencies)
      add_one(spec)
      apply_keys(spec)
      setup_from_opts(spec)
      run_config(spec)
    end
  end
end

return M
