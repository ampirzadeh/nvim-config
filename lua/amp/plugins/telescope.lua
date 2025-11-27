return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
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
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('project')
      telescope.load_extension('fzf')
      -- telescope.load_extension('file_browser')

      local Map = require("amp.remaps")
      local builtin = require("telescope.builtin")
      local extensions = telescope.extensions

      Map('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
      Map('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
      Map('n', '<leader>p', function() extensions.project.project { display_type = 'full' } end,
        { desc = 'Telescope open project' })
      -- Map('n', '<C-b>', extensions.file_browser.file_browser, { desc = 'Telescope file browser' })
      Map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      Map('n', '<leader>fr', builtin.registers, { desc = 'Telescope registers' })
      Map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make",
  },
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" }
  -- },
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  }
}
