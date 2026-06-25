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
      treesitter.install(parsers)

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
          elseif vim.tbl_contains(available_parsers, language) then
            treesitter.install(language):await(function()
              treesitter_try_attach(args.buf, language)
            end)
          else
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
