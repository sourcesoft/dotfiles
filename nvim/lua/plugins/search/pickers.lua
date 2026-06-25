local map = vim.keymap.set

local function current_buffer_dir()
  local name = vim.api.nvim_buf_get_name(0)

  if name == '' then
    return vim.uv.cwd() or vim.fn.getcwd()
  end

  local stat = vim.uv.fs_stat(name)
  if stat and stat.type == 'directory' then
    return name
  end

  return vim.fn.fnamemodify(name, ':p:h')
end

local function files_in_current_folder()
  local cwd = current_buffer_dir()

  Snacks.picker.files {
    cwd = cwd,
    title = 'Search in ' .. cwd,
  }
end

local function explorer_in_current_folder()
  Snacks.explorer {
    cwd = current_buffer_dir(),
    jump = { close = true },
    layout = { preset = 'vertical', preview = false },
  }
end

local function neovim_files()
  Snacks.picker.files {
    cwd = vim.fn.stdpath 'config',
    follow = true,
  }
end

map('n', '<leader>f', function()
  Snacks.picker.files()
end, { desc = '[S]earch [F]iles' })
map('n', '<leader>/', function()
  Snacks.picker.grep()
end, { desc = '[/] Grep search all project' })
map('n', '<leader>df', function()
  Snacks.picker.diagnostics()
end, { desc = '[D]iagnostics' })
map('n', '<leader>dd', vim.diagnostic.open_float, { desc = '[D]iagnostics' })

map('n', '<leader>sh', function()
  Snacks.picker.help()
end, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', function()
  Snacks.picker.keymaps()
end, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', function()
  Snacks.picker.files()
end, { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', function()
  Snacks.picker.lsp_symbols()
end, { desc = '[S]earch document [S]ymbols' })
map('n', '<leader>sS', function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = '[S]earch workspace [S]ymbols' })
map({ 'n', 'v' }, '<leader>sw', function()
  Snacks.picker.grep_word()
end, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sd', function()
  Snacks.picker.diagnostics()
end, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sD', function()
  Snacks.picker.diagnostics_buffer()
end, { desc = '[S]earch buffer [D]iagnostics' })
map('n', '<leader>sr', function()
  Snacks.picker.resume()
end, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', function()
  Snacks.picker.recent()
end, { desc = '[S]earch Recent Files' })
map('n', '<leader>sc', function()
  Snacks.picker.commands()
end, { desc = '[S]earch [C]ommands' })
map('n', '<leader>sC', function()
  Snacks.picker.colorschemes()
end, { desc = '[S]earch [C]olorschemes' })
map('n', '<leader>s?', function()
  Snacks.picker.pickers()
end, { desc = '[S]earch Snacks pickers' })
map('n', '<leader>sq', function()
  Snacks.picker.qflist()
end, { desc = '[S]earch [Q]uickfix list' })
map('n', '<leader>sl', function()
  Snacks.picker.loclist()
end, { desc = '[S]earch [L]ocation list' })
map('n', '<leader>sm', function()
  Snacks.picker.marks()
end, { desc = '[S]earch [M]arks' })
map('n', '<leader>su', function()
  Snacks.picker.undo()
end, { desc = '[S]earch [U]ndo history' })
map('n', '<leader>se', files_in_current_folder, { desc = '[S]earch current file directory' })
map('n', '<leader><leader>', function()
  Snacks.picker.buffers()
end, { desc = '[ ] Find existing buffers' })
map('n', '<leader><space>', function()
  Snacks.picker.resume()
end, { desc = 'Resume Snacks picker' })
map('n', '<leader>w', function()
  Snacks.picker.buffers()
end, { desc = 'Find buffers' })
map('n', '<leader>e', explorer_in_current_folder, { desc = 'Floating file browser' })

map('n', '<leader>sg', function()
  Snacks.picker.lines()
end, { desc = 'Fuzzily search in current buffer' })
map('n', '<leader>s/', function()
  Snacks.picker.grep_buffers()
end, { desc = '[S]earch [/] in Open Files' })
map('n', '<leader>sn', neovim_files, { desc = '[S]earch [N]eovim files' })
