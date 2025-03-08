{
  description = "Building a bootable ISO image";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ nixpkgs, self, ... }:
    {
      one-iso = self.nixosConfigurations.one.config.system.build.isoImage;

      nixosConfigurations = {
        one = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [ ./configuration.nix ];
        };
      };
    };
}
