{ ... }:
{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<C-p>" = {
        action = "find_files";
        options.desc = "Telescope find files";
      };
      "<C-f>" = {
        action = "live_grep";
        options.desc = "Telescope live grep";
      };
      "<C-t>" = {
        action = "treesitter";
        options.desc = "Telescope Treesitter";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Telescope buffers";
      };
      "<leader>fr" = {
        action = "registers";
        options.desc = "Telescope registers";
      };
      "<leader>fh" = {
        action = "help_tags";
        options.desc = "Telescope help tags";
      };
      "<leader>p" = {
        action = "project";
        options.desc = "Telescope projects";
      };
    };
    extensions = {
      fzf-native = {
        enable = true;
        settings = {
          fuzzy = true;
          override_generic_sorter = true;
          override_file_sorter = true;
          case_mode = "smart_case";
        };
      };

      project = {
        enable = true;
        settings = {
          sync_with_nvim_tree = true;
          theme = "dropdown";
          hidden_files = true;
          base_dirs = [
            "~/Projects"
            "~/.config/nvim"
          ];
        };
      };
    };

    settings = {
      defaults = {
        sorting_strategy = "ascending";
        layout_config.prompt_position = "top";
      };
    };
  };
}
