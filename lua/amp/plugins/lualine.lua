return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      tabline = {
        lualine_a = { 'buffers' }
      },
      sections = {
        lualine_b = { "branch", "diagnostics" },
        lualine_y = { "lsp_status" }
      }
    },
  },
}
