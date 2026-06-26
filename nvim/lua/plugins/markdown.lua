local function doctoc_command()
  local mason_doctoc = vim.fn.stdpath 'data' .. '/mason/bin/doctoc'
  if vim.fn.executable(mason_doctoc) == 1 then
    return mason_doctoc
  end

  if vim.fn.executable 'doctoc' == 1 then
    return 'doctoc'
  end

  return nil
end

local function run_doctoc(args)
  local executable = doctoc_command()
  if not executable then
    vim.notify('doctoc is not executable. Run :MasonToolsInstallSync.', vim.log.levels.ERROR)
    return
  end

  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    vim.notify(':TOC needs a file-backed Markdown buffer.', vim.log.levels.ERROR)
    return
  end

  local extension = vim.fn.fnamemodify(file, ':e'):lower()
  if not ({ md = true, markdown = true, mdx = true })[extension] then
    vim.notify(':TOC only supports .md, .markdown, and .mdx files.', vim.log.levels.ERROR)
    return
  end

  if vim.bo.modified then
    vim.cmd.write()
  end

  local command = { executable, '--github', '--toc-location', 'before', '--title', '**Table of Contents**' }
  vim.list_extend(command, args.fargs or {})
  table.insert(command, file)

  local view = vim.fn.winsaveview()
  local result = vim.system(command, { text = true }):wait()
  if result.code ~= 0 then
    local output = vim.trim((result.stderr or '') .. '\n' .. (result.stdout or ''))
    vim.notify(output ~= '' and output or 'doctoc failed.', vim.log.levels.ERROR)
    return
  end

  vim.cmd.edit { bang = true }
  vim.fn.winrestview(view)
  vim.notify('Updated table of contents with doctoc.', vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('Toc', run_doctoc, {
  desc = 'Generate or update the current Markdown table of contents with doctoc',
  nargs = '*',
})

vim.cmd [[
  cnoreabbrev <expr> TOC getcmdtype() ==# ':' && getcmdline() ==# 'TOC' ? 'Toc' : 'TOC'
]]

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>tm', '<cmd>RenderMarkdown toggle<CR>', desc = '[T]oggle rendered [m]arkdown' },
    },
    opts = {
      latex = { enabled = false },
    },
  },
}
