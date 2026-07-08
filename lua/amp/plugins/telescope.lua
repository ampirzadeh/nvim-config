-- Recommended dependencies:
-- https://github.com/BurntSushi/ripgrep
-- https://github.com/sharkdp/fd
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { '<C-p>',      "<cmd>Telescope find_files<CR>", desc = 'Telescope find files' },
      { '<C-f>',      "<cmd>Telescope live_grep<CR>",  desc = 'Telescope live grep' },
      { '<C-t>',      "<cmd>Telescope treesitter<CR>", desc = 'Telescope treesitter' },
      { '<leader>fb', "<cmd>Telescope buffers<CR>",    desc = 'Telescope buffers' },
      { '<leader>fr', "<cmd>Telescope registers<CR>",  desc = 'Telescope registers' },
      { '<leader>fh', "<cmd>Telescope help_tags<CR>",  desc = 'Telescope help tags' },
    },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top"
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        },
        project = {
          sync_with_nvim_tree = true,
          theme = "dropdown",
          hidden_files = true,
          base_dirs = {
            '~/Projects',
            '~/.config/nvim'
          },
        },
        -- file_browser = {
        --   -- hidden      = true, -- toggle with ctrl-h
        --   grouped       = true,
        --   prompt_path   = true,
        --   select_buffer =true,
        -- }
      }
    },
  },
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" }
  --   keys = {
  --     { '<C-b>', "<cmd>Telescope file_browser.file_browser<CR>", desc = 'Telescope file browser' },
  --   }
  -- },
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    keys = {
      { '<leader>p', ":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>", desc = 'Telescope open project' },
    }
  }
}
