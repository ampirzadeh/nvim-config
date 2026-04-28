{ ... }:
{
  plugins.windsurf-vim = {
    enable = true;
  };

  plugins.sidekick = {
    enable = true;
    settings = {
      nes.enabled = false;

      cli = {
        win = {
          layout = "right";
          split.width = 50;
        };
      };
    };
  };
  keymaps = [
    {
      mode = [
        "n"
        "t"
        "i"
        "x"
      ];
      key = "<c-.>";
      action.__raw = "function() require('sidekick.cli').toggle({ name = 'gemini', focus = true }) end";
      options.desc = "Toggle Gemini";
    }
    {
      mode = "x";
      key = "<leader>av";
      action.__raw = "function() require('sidekick.cli').send({ msg = '{selection}' }) end";
      options.desc = "Send selection";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>ap";
      action.__raw = "function() require('sidekick.cli').prompt() end";
      options.desc = "Sidekick prompt";
    }
  ];
}
