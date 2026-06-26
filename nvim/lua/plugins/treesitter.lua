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

local treesitter_cli = require 'dotfiles.treesitter'
local warned_missing_cli = false

local function warn_missing_tree_sitter_cli()
  if warned_missing_cli or #vim.api.nvim_list_uis() == 0 then
    return
  end

  warned_missing_cli = true

  vim.schedule(function()
    local status = treesitter_cli.cli_status()
    local reason = 'not usable'
    if status.reason == 'missing' then
      reason = 'not found'
    elseif status.reason == 'old_version' then
      reason = ('version %s is older than %s'):format(
        treesitter_cli.format_version(status.version) or 'unknown',
        treesitter_cli.min_cli_version
      )
    end

    local message = (
      'tree-sitter CLI %s; install tree-sitter %s or newer '
      .. 'with your system package manager to install parsers.'
    ):format(reason, treesitter_cli.min_cli_version)

    vim.notify(message, vim.log.levels.WARN)
  end)
end

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

return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = 'main',
    config = function()
      local treesitter = require 'nvim-treesitter'
      if treesitter_cli.can_install() then
        treesitter.install(parsers)
      else
        warn_missing_tree_sitter_cli()
      end

      local available_parsers = treesitter.get_available()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('dotfiles-treesitter', { clear = true }),
        callback = function(args)
          local language = vim.treesitter.language.get_lang(args.match)
          if not language then
            return
          end

          local installed_parsers = treesitter.get_installed 'parsers'
          if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(args.buf, language)
          elseif vim.tbl_contains(available_parsers, language) and treesitter_cli.can_install() then
            treesitter.install(language):await(function()
              treesitter_try_attach(args.buf, language)
            end)
          else
            if vim.tbl_contains(available_parsers, language) then
              warn_missing_tree_sitter_cli()
            end
            treesitter_try_attach(args.buf, language)
          end
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        mode = 'topline',
        multiline_threshold = 1,
      }
    end,
  },

  {
    'andymass/vim-matchup',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
}
