return {
  {
    "tpope/vim-fugitive"
  },
  {
    'lewis6991/gitsigns.nvim',
    keys = {
      { "<leader>ga", "<CMD>Gitsigns stage_hunk<CR>",          desc = "Stage hunk" },
      { "<leader>gu", "<CMD>Gitsigns undo_stage_hunk<CR>",     desc = "Undo stage hunk" },
      { "<leader>gv", "<CMD>Gitsigns preview_hunk_inline<CR>", desc = "Preview hunk" },
      { "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>",          desc = "Reset hunk" }
    },
    opts = { current_line_blame = true }
  }
}
