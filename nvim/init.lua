vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require 'core.options'
require 'core.diagnostics'
require 'core.autocmds'
require 'core.keymaps'
require 'core.terminal'
require 'plugins'

-- vim: ts=2 sts=2 sw=2 et
