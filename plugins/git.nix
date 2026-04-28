{ ... }:
{
  plugins.gitsigns = {
    enable = true;
    settings.current_line_blame = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ga";
      action = "<CMD>Gitsigns stage_hunk<CR>";
      options.desc = "Stage hunk";
    }
    {
      mode = "n";
      key = "<leader>gu";
      action = "<CMD>Gitsigns undo_stage_hunk<CR>";
      options.desc = "Undo stage hunk";
    }
    {
      mode = "n";
      key = "<leader>gv";
      action = "<CMD>Gitsigns preview_hunk_inline<CR>";
      options.desc = "Preview hunk";
    }
    {
      mode = "n";
      key = "<leader>gr";
      action = "<CMD>Gitsigns reset_hunk<CR>";
      options.desc = "Reset hunk";
    }
  ];
}
