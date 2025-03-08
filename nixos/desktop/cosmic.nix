{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
  };

  mods.fcitx.enable = true;

  # environment.systemPackages = with pkgs; [ ];
}
