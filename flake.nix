{
  description = "Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      neovim-nightly-overlay,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly-overlay.overlays.default ];
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
        { ... }:
        let
          nightly-pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ neovim-nightly-overlay.overlays.default ];
          };
        in
        {
          imports = [ nixvim.homeModules.nixvim ];
          programs.nixvim = {
            enable = true;
            package = nightly-pkgs.neovim;
            imports = [ ./config.nix ];
          };
        };
    };
}
