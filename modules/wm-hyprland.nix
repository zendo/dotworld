{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  imports = [
    ./wm.nix
    inputs.hyprland.nixosModules.default
  ];

  services.greetd.settings = {
    default_session.command = "${lib.getExe pkgs.greetd.tuigreet} --time --cmd Hyprland";
    # Autologin
    initial_session = {
      command = "Hyprland";
      user = "${username}";
    };
  };

  # programs.hyprland.enable = true;

  home-manager.users.${username} = {
    pkgs,
    config,
    inputs,
    ...
  }: {
    imports = [inputs.hyprland.homeManagerModules.default];

    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        source=./custom.conf
        exec-once=${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      '';
    };

    home.packages = with pkgs; [
      # hyprpaper # wallpaper
      # hyprpicker # color picker
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      }))
    ];
  };
}
