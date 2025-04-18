local transparent = {
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent"
  }
}
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
