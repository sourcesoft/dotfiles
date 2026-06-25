local M = {}

M.session_dir = vim.fn.stdpath 'state' .. '/session'

local function project_session_name()
  local cwd = vim.fn.getcwd()
  local name = vim.fn.fnamemodify(cwd, ':t')
  if name == '' then
    name = 'session'
  end

  name = name:gsub('[^%w_.-]', '_')
  return ('%s-%s.vim'):format(name, vim.fn.sha256(cwd):sub(1, 12))
end

local function project_session_path()
  return M.session_dir .. '/' .. project_session_name()
end

local function has_session_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(bufnr)
    if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted and vim.bo[bufnr].buftype == '' and name ~= '' then
      return true
    end
  end

  return false
end

function M.clean_buffers()
  pcall(vim.cmd, 'CleanEmptyBuffers')
end

function M.restore_project()
  local name = project_session_name()
  if vim.fn.filereadable(project_session_path()) == 0 then
    vim.notify(('No saved session for %s'):format(vim.fn.getcwd()), vim.log.levels.INFO)
    return
  end

  local ok, sessions = pcall(require, 'mini.sessions')
  if not ok then
    vim.notify('mini.sessions is not available', vim.log.levels.WARN)
    return
  end

  local read_ok, err = pcall(sessions.read, name, { force = true, verbose = true })
  if not read_ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

function M.autosave_project()
  if not has_session_buffers() then
    return
  end

  M.clean_buffers()

  local ok, sessions = pcall(require, 'mini.sessions')
  if not ok then
    return
  end

  local write_ok, err = pcall(sessions.write, project_session_name(), { force = true, verbose = false })
  if not write_ok then
    vim.notify(err, vim.log.levels.WARN)
  end
end

return M
