vim.o.background = "dark" -- or "light" for light mode

return {
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
