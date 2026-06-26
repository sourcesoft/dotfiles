local M = {}

local min_cli_version = { 0, 26, 1 }
M.min_cli_version = table.concat(min_cli_version, '.')

local cached_status

---@param output string?
---@return integer[]?
local function parse_version(output)
  if type(output) ~= 'string' then
    return nil
  end

  local major, minor, patch = output:match '(%d+)%.(%d+)%.(%d+)'
  if not major then
    return nil
  end

  return { tonumber(major), tonumber(minor), tonumber(patch) }
end

---@param version integer[]
---@return boolean
local function version_at_least(version)
  for index, expected in ipairs(min_cli_version) do
    local actual = version[index] or 0
    if actual > expected then
      return true
    elseif actual < expected then
      return false
    end
  end

  return true
end

---@param version integer[]?
---@return string?
function M.format_version(version)
  if not version then
    return nil
  end

  return table.concat(version, '.')
end

---@return table
local function detect_cli()
  if vim.fn.executable 'tree-sitter' ~= 1 then
    return { ok = false, reason = 'missing' }
  end

  local ok, result = pcall(function()
    return vim.system({ 'tree-sitter', '--version' }, { text = true }):wait()
  end)

  if not ok then
    return { ok = false, reason = 'check_failed', detail = tostring(result) }
  end

  local output = vim.trim(((result.stdout or '') .. '\n' .. (result.stderr or '')))
  if result.code ~= 0 then
    return { ok = false, reason = 'check_failed', detail = output }
  end

  local version = parse_version(output)
  if not version then
    return { ok = false, reason = 'unknown_version', detail = output }
  end

  if not version_at_least(version) then
    return { ok = false, reason = 'old_version', version = version, detail = output }
  end

  return { ok = true, version = version, detail = output }
end

---@return table
function M.cli_status()
  if not cached_status then
    cached_status = detect_cli()
  end

  return vim.deepcopy(cached_status)
end

---@return boolean
function M.can_install()
  return M.cli_status().ok == true
end

return M
