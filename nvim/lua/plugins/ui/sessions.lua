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

local function is_empty_placeholder(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
    return false
  end

  if not vim.bo[bufnr].buflisted or vim.bo[bufnr].buftype ~= '' then
    return false
  end

  if vim.bo[bufnr].modified or vim.api.nvim_buf_get_name(bufnr) ~= '' then
    return false
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 2, false)
  return #lines <= 1 and (lines[1] or '') == ''
end

local function is_oil_uri(name)
  return name:match '^oil://' ~= nil
end

local function is_oil_buffer(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and is_oil_uri(vim.api.nvim_buf_get_name(bufnr))
end

local function normal_windows(tabpage)
  return vim.tbl_filter(function(win)
    return vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_config(win).relative == ''
  end, vim.api.nvim_tabpage_list_wins(tabpage))
end

local function close_outline_windows()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) then
      local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
      if buf_name:match 'OUTLINE_' then
        pcall(vim.api.nvim_win_close, win, true)
      end
    end
  end
end

local function close_empty_windows()
  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    if vim.api.nvim_tabpage_is_valid(tabpage) then
      local wins = normal_windows(tabpage)
      if #wins == 1 then
        local bufnr = vim.api.nvim_win_get_buf(wins[1])
        if is_empty_placeholder(bufnr) and #vim.api.nvim_list_tabpages() > 1 then
          vim.api.nvim_set_current_tabpage(tabpage)
          pcall(vim.cmd, 'silent! tabclose')
        end
      elseif #wins > 1 then
        for _, win in ipairs(wins) do
          if vim.api.nvim_win_is_valid(win) and is_empty_placeholder(vim.api.nvim_win_get_buf(win)) then
            pcall(vim.api.nvim_win_close, win, true)
          end
        end
      end
    end
  end
end

local function clean_arglist()
  local args = {}
  local changed = false

  for i = 0, vim.fn.argc(-1) - 1 do
    local arg = vim.fn.argv(i)
    if is_oil_uri(arg) then
      changed = true
    else
      table.insert(args, arg)
    end
  end

  if not changed then
    return
  end

  pcall(vim.cmd, 'argglobal')
  pcall(vim.cmd, '%argdelete')
  for _, arg in ipairs(args) do
    vim.cmd.argadd(vim.fn.fnameescape(arg))
  end
end

function M.clean_buffers()
  clean_arglist()
  close_outline_windows()
  close_empty_windows()

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if (is_empty_placeholder(bufnr) or is_oil_buffer(bufnr)) and #vim.fn.win_findbuf(bufnr) == 0 then
      pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
    end
  end
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
  else
    M.clean_buffers()
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
