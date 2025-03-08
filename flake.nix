{
  description = "NIX SAVE THE WORLD";

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      imports = [
        ./hosts/flake-module.nix
        ./nixos/flake-module.nix
        ./overlays/flake-module.nix
        ./home-manager/hm-standalone.nix
        ./hosts/deployment.nix
        ./lib/flake-module.nix
        ./templates/flake-module.nix
        ./treefmt.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        {
          lib,
          pkgs,
          config,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ self.overlays.modifications ];
            config = {
              allowUnfree = true;
              # allowBroken = true;
              # allowInsecure = true;
              # allowUnsupportedSystem = true;
              android_sdk.accept_license = true;
            };
          };

          # quickly access nixpkgs packages without specifying `legacyPackages.<arch>`
          legacyPackages = pkgs;

          packages =
            lib.packagesFromDirectoryRecursive {
              inherit (pkgs) callPackage;
              directory = ./pkgs;
            }
            // {
              # nix run .
              default = config.packages.azcomicv;
            };

          # nix develop .#rust
          devShells = import ./devshells.nix { inherit pkgs; };
        };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
    # nixpkgs.url = "git+file:///home/iab/dev/nixpkgs/?ref=pr-358877-clash-rev";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nur.url = "github:nix-community/NUR";
    # agenix.url = "github:ryantm/agenix";
    sops-nix.url = "github:Mic92/sops-nix";
    nvf.url = "github:notashelf/nvf";
    templates.url = "github:NixOS/templates";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  # Flake Local Nix Configuration
  nixConfig = {
    # bash-prompt = "[nix]λ ";
    # substituters = ["https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"];
    # extra-substituters = ["https://nix-gaming.cachix.org"];
    # extra-trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };
}
