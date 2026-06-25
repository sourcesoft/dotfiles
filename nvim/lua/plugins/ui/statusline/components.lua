local M = {}

local filetype_map = {
  lazy = { name = 'lazy.nvim', icon = '󰒲' },
  mason = { name = 'mason', icon = '󰏖' },
  minifiles = { name = 'minifiles', icon = '󰉋' },
  oil = { name = 'oil', icon = '󰏇' },
  snacks_picker_input = { name = 'picker', icon = '' },
  snacks_terminal = { name = 'terminal', icon = '' },
  trouble = { name = 'trouble', icon = '󰙅' },
}

function M.hello()
  return [[Toro is the best]]
end

function M.hl_color(group, attr)
  attr = attr or 'fg'
  if not group then
    return nil
  end

  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  if not ok or not hl or not hl[attr] then
    return nil
  end

  return { [attr] = ('#%06x'):format(hl[attr]) }
end

function M.file_icon()
  local ft = vim.bo.filetype
  if filetype_map[ft] then
    return ' ' .. filetype_map[ft].icon .. ' '
  end

  local devicons = require 'nvim-web-devicons'
  local filename = vim.fn.expand '%:t'
  local icon = devicons.get_icon(filename)
  if icon == nil then
    icon = devicons.get_icon_by_filetype(ft)
  end

  return (icon or '󰈤') .. ' '
end

function M.file_icon_color()
  if filetype_map[vim.bo.filetype] then
    return M.hl_color 'Special'
  end

  local devicons = require 'nvim-web-devicons'
  local filename = vim.fn.expand '%:t'
  local _, hl = devicons.get_icon(filename)
  if hl == nil then
    _, hl = devicons.get_icon_by_filetype(vim.bo.filetype)
  end

  return M.hl_color(hl) or M.hl_color 'Normal'
end

function M.filename(name)
  local mapped = filetype_map[vim.bo.filetype]
  if mapped then
    return mapped.name
  end

  return name
end

function M.listed_buffer_count()
  local count = 0
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
      count = count + 1
    end
  end

  return count
end

return M
