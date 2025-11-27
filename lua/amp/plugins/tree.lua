return {
  'nvim-tree/nvim-tree.lua',
  enabled = true,
  config = function()
    require("nvim-tree").setup()
    local Map = require("amp.remaps")

    Map('n', '<C-b>', ':NvimTreeToggle<CR>')
  end
}
