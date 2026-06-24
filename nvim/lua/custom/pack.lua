local M = {}

local main_overrides = {
  ['akinsho/bufferline.nvim'] = 'bufferline',
  ['catgoose/nvim-colorizer.lua'] = 'colorizer',
  ['chrisgrieser/nvim-early-retirement'] = 'early-retirement',
  ['folke/persistence.nvim'] = 'persistence',
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

local function is_uri(source)
  return source:match '^https?://' or source:match '^git@' or source:match '^ssh://'
end

function M.gh(repo)
  return 'https://github.com/' .. repo
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
    src = is_uri(source) and source or M.gh(source),
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

local function setup_from_opts(spec)
  if spec.config ~= nil or spec.opts == nil then
    return
  end

  local main = infer_main(spec)
  if not main then
    return
  end

  local opts = type(spec.opts) == 'function' and spec.opts() or spec.opts
  local ok, plugin = pcall(require, main)
  if ok and type(plugin.setup) == 'function' then
    plugin.setup(opts or {})
  end
end

local function run_config(spec)
  if type(spec.setup) == 'function' then
    spec.setup()
  end

  if type(spec.config) == 'function' then
    spec.config()
    return
  end

  if spec.config == true then
    local main = infer_main(spec)
    if main then
      local opts = type(spec.opts) == 'function' and spec.opts() or spec.opts
      local ok, plugin = pcall(require, main)
      if ok and type(plugin.setup) == 'function' then
        plugin.setup(opts or {})
      end
    end
  end
end

function M.use(value)
  for _, spec in ipairs(spec_list(value)) do
    if type(spec) == 'string' then
      add_one(spec)
    elseif type(spec) == 'table' then
      M.use(spec.dependencies)
      add_one(spec)

      if type(spec.init) == 'function' then
        spec.init()
      end

      apply_keys(spec)
      setup_from_opts(spec)
      run_config(spec)
    end
  end
end

return M
