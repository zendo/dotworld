{
  description = "Hello World";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/pull/185116/merge";
    # nixpkgs-pr.url = "git+file:///home/iab/devs/nixpkgs/?ref=gnome-shell";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/be61e5636f4c7478c0093ace59bc7512e320feaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix.url = github:ryantm/agenix;
    # sops-nix.url = github:Mic92/sops-nix;
    # devshell.url = "github:numtide/devshell";
    nur.url = "github:nix-community/NUR";
    musnix.url = "github:musnix/musnix";
    templates.url = "github:NixOS/templates";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    # nixpkgs-pr,
    # nixpkgs-stable,
    # nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    emacs-overlay,
    hyprland,
    nur,
    musnix,
    nixos-wsl,
    templates,
    flake-utils,
    ...
  }: let
    mkHost = import ./lib/mkHost.nix inputs;

    overlays = [
      nur.overlay
      emacs-overlay.overlay
      (import ./overlays)
      # (final: prev: {
        #   pr = nixpkgs-pr.legacyPackages.${prev.system};
        # })
    ];
  in
  {
    nixosConfigurations = {
      yoga = mkHost {
        username = "iab";
        hostname = "yoga";
        inherit overlays;
        extraModules = [
          ./modules/gnome.nix
          # ./modules/wm-hyprland.nix
          # ./modules/wm-sway.nix
          # ./modules/wm-wayfire.nix
          # ./modules/kde.nix

          ({
            config,
            pkgs,
            ...
          }: {
            environment.systemPackages = with pkgs; [
              # nixpkgs-pr.legacyPackages.${system}.gnomeExtensions.pano
            ];
          })
        ];
      };

      svp = mkHost {
        username = "zendo";
        hostname = "svp";
        # hmEnable = false;
        # nixpkgs = inputs.nixpkgs-stable;
        inherit overlays;
        extraModules = [
          # ./modules/gnome.nix
          # ./modules/kde.nix
          ./modules/wm-sway.nix
        ];
      };
    };

    #######################################################################
    ## HM Standalone
    #######################################################################
    # nix run nixpkgs#home-manager build switch -- --flake .#$(whoami)
    homeConfigurations = let
      username = "iab";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    in {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home-manager/alias.nix
          ./home-manager/cli.nix
          ./home-manager/git.nix
          ./home-manager/non-nixos.nix
          ./home-manager/xdg.nix
          ./home-manager/zsh.nix
          {
            home.stateVersion = "22.05";
            home.username = "${username}";
            home.homeDirectory = "/home/${username}";
          }
        ];
      };
    };

    #######################################################################
    ## WSL
    #######################################################################
    # nix build .#nixosConfigurations.wsl.config.system.build.installer
    nixosConfigurations.wsl = let
      username = "iab";
      # nixpkgs = inputs.nixpkgs-stable;
    in
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs username;};
      modules = [
        ./hosts/wsl.nix
        nixos-wsl.nixosModules.wsl
        {nixpkgs.overlays = overlays;}

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.${username} = import ./home-manager;
        }
      ];
    };

    #######################################################################
    ## VM
    #######################################################################
    # nix build .#nixosConfigurations.vmtest.config.system.build.vm
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
        inherit system overlays;
        allowUnfree = true;
        # allowBroken = true;
        # allowUnsupportedSystem = true;
      };
    in {
      # nix fmt :Formatter all files in this repo.
      formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
      # nix develop .#rust
      devShells = import ./devshells.nix {inherit pkgs;};
      # nix build .#apps or self#apps / nix run self#apps
      packages = pkgs;
    }
  );

  # auto-fetch deps when `nix run/shell/develop`
  nixConfig = {
    bash-prompt = "[nix]λ ";
    # substituters = ["https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"];
    # extra-substituters = ["https://nix-gaming.cachix.org"];
    # extra-trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };
}
