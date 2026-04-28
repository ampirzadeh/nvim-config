{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "codeium"
      # TODO: There is a bug in sidekick.nvim that causes it to require this
      # even when NES is disabled. In reality this lsp is not even enabled!
      "copilot-language-server"
    ];

  plugins.windsurf-vim = {
    enable = true;
  };

  # TODO: There is currently a bug in the nixvim plugin that causes the copilot lsp to be
  # required even when NES is disabled. So for now I have switched to using sidekick.nvim
  # directly instead of using the nixvim plugin.
  plugins.sidekick = {
    enable = true;
    settings = {
      # INFO: This is correct:
      nes.enabled = false;
      # INFO: This is what is expected
      opts.nes.enabled = false;

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
      action.__raw = "function() require('sidekick.cli').toggle({ name = 'opencode', focus = true }) end";
      options.desc = "Toggle OpenCode";
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
