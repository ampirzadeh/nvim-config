{ ... }:
{
  plugins.rest = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>s"; # s for send
      action = "<CMD>Rest run<CR>";
      options.desc = "Execute the http request under the cursor";
    }
  ];
}
