local function check_version()
  local verstr = tostring(vim.version())
  if not vim.version.ge then
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.12') then
    vim.health.ok(string.format("Neovim version is: '%s'", verstr))
  else
    vim.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
  end
end

local function check_external_reqs()
  for _, exe in ipairs { 'curl', 'git', 'make', 'tar', 'unzip', 'rg' } do
    if vim.fn.executable(exe) == 1 then
      vim.health.ok(string.format("Found executable: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end
end

local function check_c_compiler()
  for _, exe in ipairs { 'cc', 'gcc', 'clang' } do
    if vim.fn.executable(exe) == 1 then
      vim.health.ok(string.format("Found C compiler: '%s'", exe))
      return
    end
  end

  vim.health.warn 'Could not find a C compiler. Install Xcode Command Line Tools or your platform equivalent.'
end

local function check_tree_sitter_cli()
  local treesitter_cli = require 'dotfiles.treesitter'
  local status = treesitter_cli.cli_status()
  if status.ok then
    vim.health.ok(
      string.format(
        "Found tree-sitter CLI version: '%s'",
        treesitter_cli.format_version(status.version)
      )
    )
    return
  end

  if status.reason == 'missing' then
    vim.health.warn(
      string.format(
        "Could not find executable: 'tree-sitter'. "
          .. 'Install tree-sitter CLI %s or newer with your system package manager.',
        treesitter_cli.min_cli_version
      )
    )
  elseif status.reason == 'old_version' then
    vim.health.warn(
      string.format(
        "tree-sitter CLI version '%s' is older than required version '%s'",
        treesitter_cli.format_version(status.version) or 'unknown',
        treesitter_cli.min_cli_version
      )
    )
  else
    vim.health.warn(
      string.format(
        "Could not verify tree-sitter CLI %s or newer: %s",
        treesitter_cli.min_cli_version,
        status.detail or status.reason or 'unknown error'
      )
    )
  end
end

return {
  check = function()
    vim.health.start 'dotfiles.nvim'
    vim.health.info('System Information: ' .. vim.inspect((vim.uv or vim.loop).os_uname()))
    check_version()
    check_external_reqs()
    check_c_compiler()
    check_tree_sitter_cli()
  end,
}
