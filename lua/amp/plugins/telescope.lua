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
        }
      }
    },
    config = function()
      local Map = require("amp.remaps")
      local builtin = require("telescope.builtin")

      Map('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
      Map('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
      Map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      Map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require('telescope').load_extension('fzf')
    end
  }
}
