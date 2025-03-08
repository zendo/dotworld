{ inputs, ... }:
{
  flake.homeConfigurations =
    let
      mkHome =
        {
          username,
          nixpkgs ? inputs.nixpkgs,
          system ? "x86_64-linux",
          extraModules ? [ ],
        }:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = builtins.attrValues inputs.self.overlays;
            config.allowUnfree = true;
          };

          extraSpecialArgs = {
            inherit inputs;
          };

          modules = [
            ./ssh.nix
            ./git.nix
            ./cli.nix
            ./zsh.nix
            ./fish.nix
            ./alias.nix
            ./files.nix
            ./nvim.nix
            ./non-nixos.nix

            {
              home.username = "${username}";
              home.homeDirectory = "/home/${username}";
              home.stateVersion = "25.05";
            }
          ] ++ extraModules;
        };
    in
    {
      # non-nixos
      iab = mkHome {
        username = "iab";
        extraModules = [ ./dconf.nix ];
      };

      # other user on nixos
      guest = mkHome {
        username = "guest";
        extraModules = [
          ./gui.nix
          ./bash.nix
          ./editor.nix
          ./firefox.nix
        ];
      };
    };
}
