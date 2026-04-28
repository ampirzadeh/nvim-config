{
  description = "Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    { nixpkgs, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
      };

      nvimConfig = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = import ./config.nix;
      };
    in
    {
      # nix run .
      packages.${system}.default = nvimConfig.config.build.package;

      # nix flake check .
      checks.${system}.default = nvimConfig.config.build.test;

      # used by your HM flake
      homeManagerModules.default =
        { pkgs, ... }:
        {
          imports = [ nixvim.homeModules.nixvim ];
          programs.nixvim = {
            enable = true;
            # viAlias = true;
            # vimAlias = true;
            # defaultEditor = true;
            # nixpkgs.config.allowUnfree = true;
            imports = [ ./config.nix ];
          };
        };
    };
}
