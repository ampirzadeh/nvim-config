return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        },
        project = {
          sync_with_nvim_tree = true,
          hidden_files = true,
          base_dirs = {
            '~/Projects',
            '~/.config/nvim'
          },
        }
      }
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('project')
      telescope.load_extension('fzf')
      telescope.load_extension('file_browser')

      local Map = require("amp.remaps")
      local builtin = require("telescope.builtin")

      Map('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
      Map('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
      Map('n', '<leader>p', telescope.extensions.project.project, { desc = 'Telescope open project' })
      Map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      Map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make",
  },
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  }
}
