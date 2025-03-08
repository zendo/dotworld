{ self, ... }:
{
  flake.nixosModules = {
    default = {
      imports = self.lib.umport {
        path = ./.;
        exclude = [
          ./desktop
          ./profiles
          ./flake-module.nix
        ];
      };
    };

    homeManagerInit = {
      imports = [ ../home-manager/hm-as-module.nix ];
    };

    laptopPowerPlan = {
      imports = [ ./profiles/laptop-power-plan.nix ];
    };

    gnome = {
      imports = [ ./desktop/gnome.nix ];
    };

    kde = {
      imports = [ ./desktop/kde.nix ];
    };

    cosmic = {
      imports = [ ./desktop/cosmic.nix ];
    };

    niri = {
      imports = [
        ./desktop/wm.nix
        ./desktop/wm-dm.nix
        ./desktop/wm-niri.nix
      ];
    };

    sway = {
      imports = [
        ./desktop/wm.nix
        ./desktop/wm-dm.nix
        ./desktop/wm-sway.nix
      ];
    };

    hyprland = {
      imports = [
        ./desktop/wm.nix
        ./desktop/wm-dm.nix
        ./desktop/wm-hyprland.nix
      ];
    };
  };
}
