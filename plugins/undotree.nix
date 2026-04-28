{ ... }:
{
  keymaps = [
    {
      key = "<leader>u";
      action = "<CMD>UndotreeToggle<CR>";
      options.desc = "Toggle Undotree";
    }
  ];

  plugins.undotree.enable = true;
}
