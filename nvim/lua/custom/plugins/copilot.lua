return {
  'github/copilot.vim',
  config = function()
    -- Avoid an extra npx-managed language-server download path.
    vim.g.copilot_version = false
  end,
}
