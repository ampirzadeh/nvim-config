{ ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "<C-b>";
      action = "<CMD>Oil<CR>";
      options.desc = "Oil";
    }
  ];

  plugins.oil-git-status = {
    enable = true;
    settings = {
      show_ignored = false;
    };
  };
  plugins.oil = {
    enable = true;
    settings = {
      skip_confirm_for_simple_edits = true;
      view_options = {
        show_hidden = true;
      };
      win_options = {
        signcolumn = "yes:2";
      };
      keymaps = {
        "<C-p>" = false;
        "<C-s>" = false;
        "<C-h>" = false;
        "<C-t>" = false;
        "<BS>" = "actions.parent";
      };
    };
  };
}
