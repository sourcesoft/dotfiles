-- Core Neovim settings -------------------------------------------------------
vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 200
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.tabstop = 4
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.scroll = 5
vim.o.hlsearch = true
vim.o.confirm = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Basic keymaps and autocommands --------------------------------------------
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    max_width = 120,
    max_height = 30,
  },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  virtual_lines = false,
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim.pack helpers -----------------------------------------------------------
local function gh(repo)
  return 'https://github.com/' .. repo
end

local function pack_add(specs)
  vim.pack.add(specs, { confirm = false })
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
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
      return
    end

    if name == 'LuaSnip' and vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
      return
    end
  end,
})

-- UI and core plugins --------------------------------------------------------
pack_add {
  gh 'NMAC427/guess-indent.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'folke/which-key.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'nvim-mini/mini.nvim',
  gh 'nvim-tree/nvim-web-devicons',
}

require('guess-indent').setup {}

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  current_line_blame = true,
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'stage git hunk' })
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'reset git hunk' })
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline' })
    map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function()
      gitsigns.diffthis '@'
    end, { desc = 'git [D]iff against last commit' })
    map('n', '<leader>hQ', function()
      gitsigns.setqflist 'all'
    end, { desc = 'git hunk [Q]uickfix list (all files in repo)' })
    map('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)' })
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
    map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff' })
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
  end,
}

require('which-key').setup {
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>c', group = '[C]ode' },
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { 'gr', group = 'LSP Actions' },
  },
}

require('todo-comments').setup { signs = false }

if vim.g.have_nerd_font then
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
end

require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}
require('mini.surround').setup()
require('mini.jump2d').setup()

-- Search and navigation ------------------------------------------------------
local telescope_plugins = {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
  gh 'nvim-telescope/telescope-file-browser.nvim',
}
if vim.fn.executable 'make' == 1 then
  table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim')
end
pack_add(telescope_plugins)

require('telescope').setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.9 },
      prompt_position = 'top',
      mirror = true,
    },
  },
  pickers = {},
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
    file_browser = {
      hidden = { file_browser = true, folder_browser = true },
      grouped = true,
      select_buffer = true,
      prompt_path = true,
      layout_strategy = 'vertical',
      no_ignore = true,
      layout_config = {
        vertical = { width = 0.5 },
        prompt_position = 'top',
        mirror = true,
      },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'file_browser')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = '[/] Grep search all project' })
vim.keymap.set('n', '<leader>df', builtin.diagnostics, { desc = '[D]iagnostics' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = '[D]iagnostics' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>sg', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true }
end, { desc = '[S]earch [N]eovim files' })

-- LSP ------------------------------------------------------------------------
pack_add {
  gh 'j-hui/fidget.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('fidget').setup {}
require('mason').setup {}
pcall(function()
  require('mason-lspconfig').setup { automatic_enable = false }
end)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local builtin_lsp = require 'telescope.builtin'

    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', builtin_lsp.lsp_definitions, '[G]oto [D]efinition')
    map('<leader>D', builtin_lsp.lsp_type_definitions, 'Type [D]efinition')
    map('<leader>s', builtin_lsp.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>S', builtin_lsp.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>R', vim.lsp.buf.rename, '[R]ename')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('grr', builtin_lsp.lsp_references, '[G]oto [R]eferences')
    map('gri', builtin_lsp.lsp_implementations, '[G]oto [I]mplementation')
    map('grd', builtin_lsp.lsp_definitions, '[G]oto [D]efinition')
    map('gO', builtin_lsp.lsp_document_symbols, 'Open Document Symbols')
    map('gW', builtin_lsp.lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
    map('grt', builtin_lsp.lsp_type_definitions, '[G]oto [T]ype Definition')

    vim.keymap.set('n', '<leader>r', builtin_lsp.lsp_references, { buffer = event.buf, desc = 'Show References' })
    vim.keymap.set('n', '<leader>i', builtin_lsp.lsp_implementations, { buffer = event.buf, desc = 'Show Implementations' })
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { buffer = event.buf, desc = 'Hover Documentation' })
    vim.keymap.set('n', '<leader>K', function()
      local ok, goto_preview = pcall(require, 'goto-preview')
      if ok then
        goto_preview.goto_preview_definition()
      else
        vim.lsp.buf.definition()
      end
    end, { buffer = event.buf, desc = 'Hover Definition' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

---@type table<string, vim.lsp.Config>
local servers = {
  gopls = {},
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

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'gofumpt',
  'goimports',
  'stylua',
  'sql-formatter',
  'markdownlint',
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- Formatting -----------------------------------------------------------------
pack_add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  default_format_opts = {
    lsp_format = 'fallback',
  },
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end

    return {
      timeout_ms = 500,
      lsp_format = 'fallback',
    }
  end,
  formatters_by_ft = {
    go = { 'goimports', 'gofumpt' },
    lua = { 'stylua' },
    sql = { 'sql_formatter' },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>F', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

-- Completion and snippets ----------------------------------------------------
pack_add {
  { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
}

require('luasnip').setup {}
require('blink.cmp').setup {
  keymap = {
    preset = 'default',
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
}

-- Treesitter -----------------------------------------------------------------
pack_add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

local parsers = {
  'bash',
  'c',
  'diff',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'yaml',
}
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then
    return
  end

  vim.treesitter.start(buf, language)

  if vim.treesitter.query.get(language, 'indents') then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local language = vim.treesitter.language.get_lang(args.match)
    if not language then
      return
    end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'
    if vim.tbl_contains(installed_parsers, language) then
      treesitter_try_attach(args.buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      require('nvim-treesitter').install(language):await(function()
        treesitter_try_attach(args.buf, language)
      end)
    else
      treesitter_try_attach(args.buf, language)
    end
  end,
})

-- Kickstart examples and local plugins --------------------------------------
local custom_pack = require 'custom.pack'
custom_pack.use(require 'kickstart.plugins.debug')
custom_pack.use(require 'kickstart.plugins.indent_line')
custom_pack.use(require 'kickstart.plugins.lint')
custom_pack.use(require 'kickstart.plugins.autopairs')
require 'custom.plugins'

-- Local workflow helpers -----------------------------------------------------
local function clean_empty_buffers()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) then
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match 'OUTLINE_' then
        vim.api.nvim_win_close(win, true)
      end
    end
  end
end

vim.api.nvim_create_user_command('CleanEmptyBuffers', clean_empty_buffers, {})
vim.api.nvim_create_autocmd('User', {
  pattern = 'PersistenceSavePre',
  callback = clean_empty_buffers,
})

local function search_in_current_folder()
  local current_buffer = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_buffer, ':p:h')
  require('telescope.builtin').find_files {
    cwd = current_dir,
    prompt_title = 'Search in ' .. current_dir,
  }
end

vim.keymap.set('n', '<leader>se', search_in_current_folder, { desc = '[S]earch current file directory' })

local floating_term = {
  buf = nil,
  win = nil,
  position = nil,
}

local function open_floating_term(width, height, anchor, row, col)
  local first_time = false
  if not floating_term.buf or not vim.api.nvim_buf_is_valid(floating_term.buf) then
    floating_term.buf = vim.api.nvim_create_buf(false, true)
    vim.bo[floating_term.buf].bufhidden = 'hide'
    first_time = true
  end

  if floating_term.win and vim.api.nvim_win_is_valid(floating_term.win) then
    vim.api.nvim_win_close(floating_term.win, true)
  end

  floating_term.win = vim.api.nvim_open_win(floating_term.buf, true, {
    relative = 'editor',
    anchor = anchor,
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  if first_time then
    vim.api.nvim_set_current_win(floating_term.win)
    vim.fn.termopen(vim.o.shell or '/bin/sh')
  end

  vim.cmd 'startinsert'
end

local function close_floating_term()
  if floating_term.win and vim.api.nvim_win_is_valid(floating_term.win) then
    vim.api.nvim_win_close(floating_term.win, true)
  end
  floating_term.win = nil
  floating_term.position = nil
end

local function toggle_floating_term_center()
  if floating_term.position == 'center' then
    close_floating_term()
    return
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  open_floating_term(width, height, 'NW', row, col)
  floating_term.position = 'center'
end

local function toggle_floating_term_right()
  if floating_term.position == 'right' then
    close_floating_term()
    return
  end

  local width = math.floor(vim.o.columns * 0.4)
  local height = vim.o.lines - 2
  open_floating_term(width, height, 'NE', 0, vim.o.columns - 1)
  floating_term.position = 'right'
end

vim.keymap.set('n', '<C-t>', toggle_floating_term_center, { silent = true, desc = 'Toggle centered terminal' })
vim.keymap.set('t', '<C-t>', [[<C-\><C-n><cmd>lua require('custom.term').toggle_center()<CR>]], { silent = true })
vim.keymap.set('n', '<C-y>', toggle_floating_term_right, { silent = true, desc = 'Toggle right terminal' })
vim.keymap.set('t', '<C-y>', [[<C-\><C-n><cmd>lua require('custom.term').toggle_right()<CR>]], { silent = true })

package.loaded['custom.term'] = {
  toggle_center = toggle_floating_term_center,
  toggle_right = toggle_floating_term_right,
}

-- vim: ts=2 sts=2 sw=2 et
