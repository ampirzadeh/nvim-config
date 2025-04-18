local transparent = {
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent"
  }
}

if vim.g.neovide then
  transparent.transparent = false
  vim.g.neovide_opacity = 0.95
  vim.g.neovide_normal_opacity = 095
end

return {
  {
    'navarasu/onedark.nvim',
    opts = transparent
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = transparent
  },
}
