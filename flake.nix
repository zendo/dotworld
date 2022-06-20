{
  description = "Hello World";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    # nixpkgs.url = "git+file:///home/iab/devel/nixpkgs";
    # local.url = "git+file:///home/iab/devel/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/e8aa04eaa4cb8664a72191547fc2395dddd3c112";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos-cn = {
    #   url = "github:nixos-cn/flakes";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # agenix.url = github:ryantm/agenix;
    # sops-nix.url = github:Mic92/sops-nix;
    # devshell.url = "github:numtide/devshell";
    nixos-wsl.url = github:nix-community/NixOS-WSL;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    musnix.url = github:musnix/musnix;
    templates.url = github:NixOS/templates;
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    # local,
    home-manager,
    flake-utils,
    emacs-overlay,
    nixos-hardware,
    templates,
    nur,
    musnix,
    nixos-wsl,
    ...
  }: let
    mkHost = import ./lib/mkHost.nix inputs;

    pkgOverlays = [
      {
        nixpkgs.overlays = [
          nur.overlay
          emacs-overlay.overlay
          (import ./overlays)
          # (final: prev: {
          #   local = local.legacyPackages.${prev.system};
          # })
        ];
      }
    ];
  in
    {
      nixosConfigurations = {
        yoga = mkHost {
          username = "iab";
          hostname = "yoga";
          extraModules =
            pkgOverlays
            ++ [
              nixos-hardware.nixosModules.common-pc-laptop-ssd
              nixos-hardware.nixosModules.common-gpu-amd

              ./modules/gnome.nix
              # ./modules/kde.nix

              ./overlays/v2raya/v2raya.nix
              # {services.v2raya.enable = true;}

              musnix.nixosModules.musnix
              {musnix.enable = true;}
            ];
        };

        svp = mkHost {
          username = "zendo";
          hostname = "svp";
          extraModules =
            pkgOverlays
            ++ [
              nixos-hardware.nixosModules.common-pc-laptop-ssd
              nixos-hardware.nixosModules.common-cpu-intel

              ./modules/gnome.nix
              # ./modules/kde.nix
            ];
        };
      };

      #############################################
      # nix build .#nixosConfigurations.wsl.config.system.build.installer
      nixosConfigurations.wsl = let
        username = "iab";
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs username;};
          modules =
            pkgOverlays
            ++ [
              "${inputs.nixos-wsl}/configuration.nix"
              ./modules/nixconfig.nix
              ./hosts/wsl.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {inherit inputs;};
                home-manager.users.${username}.imports = [
                  ./home-manager/git.nix
                  ./home-manager/cli.nix
                  ./home-manager/bash.nix
                  ./home-manager/zsh.nix
                  ./home-manager/alias.nix
                ];
              }
            ];
        };

      #############################################
      # home-manager build switch .#nixos --flake
      homeConfigurations = let
        username = "iab";
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs system;
          username = "${username}";
          homeDirectory = "/home/${username}";
          stateVersion = "22.05";
          configuration = {
            imports = [
              ./home-manager/git.nix
              ./home-manager/cli.nix
              ./home-manager/zsh.nix
              ./home-manager/alias.nix
            ];
          };
        };
      };

      #############################################
      # nix build .#nixosConfigurations.vmtest.config.system.build.vmtest
      nixosConfigurations.vmtest = let
        username = "test";
        system = "x86_64-linux";
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs username;};
          modules = [
            ./hosts/vmtest.nix
          ];
        };
    }
    // flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          allowUnfree = true;
          # allowBroken = true;
          # allowUnsupportedSystem = true;
        };
      in {
        # devShell = import ./shell.nix {inherit pkgs;};
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            git
            jq
            gnumake
            alejandra
            nixUnstable
          ];
        };
      }
    );
}
