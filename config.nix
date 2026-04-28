{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    nerd-fonts.fira-code
    font-awesome
  ];
  imports = [
    ./keymaps.nix
    ./autocmds.nix
    ./options.nix
    ./ui.nix
    ./plugins/default.nix
  ];
}
